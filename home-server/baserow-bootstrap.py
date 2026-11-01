#!/usr/bin/env python3
"""One-time, idempotent bootstrap for the private Baserow task tracker.

Run inside the healthy all-in-one Baserow 2.4.0 container with:
    /baserow.sh backend-cmd manage shell < /path/to/baserow-bootstrap.py
"""

from pathlib import Path

from django.conf import settings as django_settings
from django.contrib.auth import get_user_model
from django.db import transaction

from baserow.contrib.database.fields.models import Field
from baserow.contrib.database.fields.handler import FieldHandler
from baserow.contrib.database.fields.registries import field_type_registry
from baserow.contrib.database.models import Database
from baserow.contrib.database.table.handler import TableHandler
from baserow.contrib.database.table.models import Table
from baserow.contrib.database.views.handler import ViewHandler
from baserow.contrib.database.views.models import GridView, ViewFilter
from baserow.core.handler import CoreHandler
from baserow.core.models import Settings, UserProfile, WorkspaceUser
from baserow.core.user.handler import UserHandler

ADMIN_EMAIL = "laneoisin64@gmail.com"
ADMIN_NAME = "Oisin"
PASSWORD_PATH = Path("/run/baserow/admin-password")
WORKSPACE_NAME = "Personal"
DATABASE_NAME = "Personal Tracker"
TABLE_NAME = "Tasks"

STATUS_OPTIONS = (
    (1, "Inbox", "light-blue"),
    (2, "Next", "blue"),
    (3, "In progress", "yellow"),
    (4, "Waiting", "orange"),
    (5, "Done", "green"),
    (6, "Cancelled", "gray"),
)
PRIORITY_OPTIONS = (
    (1, "Low", "light-gray"),
    (2, "Medium", "blue"),
    (3, "High", "orange"),
    (4, "Urgent", "red"),
)
PROJECT_OPTIONS = (
    (1, "Personal", "light-blue"),
    (2, "Home", "green"),
    (3, "Work", "purple"),
    (4, "Errands", "orange"),
)


def option_payload(options):
    return [
        {"id": option_id, "value": value, "color": color}
        for option_id, value, color in options
    ]


def field_type(field):
    return field_type_registry.get_by_model(field.specific_class).type


def ensure_select_options(user, field, options):
    """Add bootstrap choices without deleting or duplicating existing user choices."""

    existing = list(field.select_options.all())
    existing_values = {option.value for option in existing}
    missing = [
        {"value": value, "color": color}
        for _, value, color in options
        if value not in existing_values
    ]
    if not missing:
        return

    desired = [
        {"id": option.id, "value": option.value, "color": option.color}
        for option in existing
    ]
    FieldHandler().update_field_select_options(user, field, desired + missing)


def ensure_field(user, table, name, type_name, **field_options):
    field = (
        Field.objects.select_for_update()
        .filter(table=table, name=name, trashed=False)
        .first()
    )
    if field is not None:
        field = field.specific
        actual_type = field_type(field)
        if actual_type != type_name:
            raise RuntimeError(
                f"Tasks field {name!r} exists with type {actual_type!r}; "
                f"expected {type_name!r}."
            )
        return field

    return FieldHandler().create_field(
        user,
        table,
        type_name,
        name=name,
        **field_options,
    )


def ensure_view(user, table, name):
    view = GridView.objects.select_for_update().filter(table=table, name=name).first()
    if view is None:
        view = ViewHandler().create_view(user, table, "grid", name=name)
    return view


def ensure_filter(user, view, field, type_name, value):
    if ViewFilter.objects.filter(
        view=view, field=field, type=type_name, value=value
    ).exists():
        return
    ViewHandler().create_filter(user, view, field, type_name, value)


def main():
    user_model = get_user_model()

    # Baserow 2.4.0 requires PostgreSQL. Its DDL is transactional, so this outer
    # transaction rolls back users, metadata, dynamic table schema, and views together.
    with transaction.atomic():
        # Close every registration path before creating the account. `force_create_user`
        # intentionally bypasses the public signup policy, so it remains usable after
        # this lock is applied.
        instance_settings = Settings.objects.select_for_update().first()
        if instance_settings is None:
            instance_settings = Settings.objects.create()
        settings_changed = []
        for attribute, value in (
            ("allow_new_signups", False),
            ("allow_signups_via_workspace_invitations", False),
            ("show_admin_signup_page", False),
        ):
            if getattr(instance_settings, attribute) != value:
                setattr(instance_settings, attribute, value)
                settings_changed.append(attribute)
        if settings_changed:
            instance_settings.save(update_fields=settings_changed)

        admin = (
            user_model.objects.select_for_update().filter(username=ADMIN_EMAIL).first()
        )
        if admin is None:
            password = PASSWORD_PATH.read_text(encoding="utf-8").strip()
            if not password:
                raise RuntimeError("The initial Baserow admin password is empty.")
            admin = UserHandler().force_create_user(
                email=ADMIN_EMAIL,
                name=ADMIN_NAME,
                password=password,
                is_staff=True,
                language="en",
            )
        elif not admin.is_staff:
            admin.is_staff = True
            admin.save(update_fields=["is_staff"])

        profile, _ = UserProfile.objects.get_or_create(
            user=admin, defaults={"language": django_settings.LANGUAGE_CODE}
        )
        if not profile.email_verified:
            profile.email_verified = True
            profile.save(update_fields=["email_verified"])

        workspace_user = (
            WorkspaceUser.objects.select_for_update()
            .select_related("workspace")
            .filter(user=admin, workspace__name=WORKSPACE_NAME, workspace__trashed=False)
            .first()
        )
        if workspace_user is None:
            workspace = CoreHandler().create_workspace(admin, WORKSPACE_NAME).workspace
        else:
            workspace = workspace_user.workspace

        database = (
            Database.objects.select_for_update()
            .filter(workspace=workspace, name=DATABASE_NAME, trashed=False)
            .first()
        )
        if database is None:
            database = CoreHandler().create_application(
                admin, workspace, "database", name=DATABASE_NAME
            )

        tasks = (
            Table.objects.select_for_update()
            .filter(database=database, name=TABLE_NAME, trashed=False)
            .first()
        )
        created_tasks = tasks is None
        if created_tasks:
            tasks = TableHandler().create_table_and_fields(
                admin, database, TABLE_NAME, [("Title", "text", {})]
            )

        ensure_field(admin, tasks, "Title", "text")
        status = ensure_field(
            admin,
            tasks,
            "Status",
            "single_select",
            select_options=option_payload(STATUS_OPTIONS),
            single_select_default=1,
        )
        priority = ensure_field(
            admin,
            tasks,
            "Priority",
            "single_select",
            select_options=option_payload(PRIORITY_OPTIONS),
            single_select_default=2,
        )
        due_date = ensure_field(
            admin, tasks, "Due date", "date", date_include_time=False
        )
        project = ensure_field(
            admin,
            tasks,
            "Project",
            "single_select",
            select_options=option_payload(PROJECT_OPTIONS),
        )
        ensure_field(admin, tasks, "Notes", "long_text")
        ensure_field(admin, tasks, "Attachments", "file")

        ensure_select_options(admin, status, STATUS_OPTIONS)
        ensure_select_options(admin, priority, PRIORITY_OPTIONS)
        ensure_select_options(admin, project, PROJECT_OPTIONS)

        if created_tasks:
            default_grid = GridView.objects.select_for_update().get(table=tasks)
            ViewHandler().update_view(admin, default_grid, name="All tasks")
        ensure_view(admin, tasks, "All tasks")
        open_tasks = ensure_view(admin, tasks, "Open")
        due_today = ensure_view(admin, tasks, "Due today")
        overdue = ensure_view(admin, tasks, "Overdue")
        completed = ensure_view(admin, tasks, "Completed")

        done_id = str(status.select_options.get(value="Done").id)
        cancelled_id = str(status.select_options.get(value="Cancelled").id)
        closed_ids = f"{done_id},{cancelled_id}"

        ensure_filter(admin, open_tasks, status, "single_select_is_none_of", closed_ids)
        ensure_filter(admin, due_today, status, "single_select_is_none_of", closed_ids)
        ensure_filter(admin, due_today, due_date, "date_equals_today", "")
        ensure_filter(admin, overdue, status, "single_select_is_none_of", closed_ids)
        ensure_filter(admin, overdue, due_date, "date_before_today", "")
        ensure_filter(admin, completed, status, "single_select_equal", done_id)


main()
print("Baserow personal tracker bootstrap complete.")
