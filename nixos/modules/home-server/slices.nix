# Per-service cgroup slices for resource accounting (no limits — visibility only).
#
#   systemd-cgtop teto.slice        → whole-stack rollup
#   systemd-cgtop teto-media.slice  → one service, containers included
#
# Docker containers join via `--cgroup-parent=teto-<x>.slice`; the
# docker-<name>.service wrapper (the attached CLI client) is moved into the
# same slice so its few MB count in the same bucket.
{
  systemd.slices = {
    teto.description = "Home server stack";
    teto-media.description = "Jellyfin";
    teto-manga.description = "Suwayomi + FlareSolverr";
    teto-notes.description = "Joplin server + Postgres";
    teto-dash.description = "Homer dashboard";
    teto-print.description = "FlashForge WebUI";
    teto-infra.description = "nginx + unbound + netdata";
  };

  # cgroup v2 accounts CPU/memory by default; IO needs opting in.
  # Cheap on v2, and block-IO per slice is half the point of this exercise.
  systemd.settings.Manager.DefaultIOAccounting = true;
}
