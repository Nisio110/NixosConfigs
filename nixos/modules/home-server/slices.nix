# Per-service cgroup slices for resource accounting (no limits — visibility only).
#
#   systemd-cgtop homeserver.slice        → whole-stack rollup
#   systemd-cgtop homeserver-media.slice  → one service, containers included
#
# Docker containers join via `--cgroup-parent=homeserver-<x>.slice`; the
# docker-<name>.service wrapper (the attached CLI client) is moved into the
# same slice so its few MB count in the same bucket.
{
  systemd.slices = {
    homeserver.description = "Home server stack";
    homeserver-media.description = "Jellyfin";
    homeserver-manga.description = "Suwayomi + FlareSolverr";
    homeserver-notes.description = "Joplin server + Postgres";
    homeserver-dash.description = "Homer dashboard";
    homeserver-print.description = "FlashForge WebUI";
    homeserver-infra.description = "nginx + unbound + netdata";
  };

  # cgroup v2 accounts CPU/memory by default; IO needs opting in.
  # Cheap on v2, and block-IO per slice is half the point of this exercise.
  systemd.settings.Manager.DefaultIOAccounting = true;
}
