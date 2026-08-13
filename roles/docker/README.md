# `docker`

Docker releases are installed into a versioned directory under
`download_artifact_work_directory` and linked into `/usr/bin`. Updating the
links and daemon configuration does not restart a running Docker service by
default. Set `docker_restart_on_update: true` to activate updates immediately;
otherwise, activate the installed version during a separate service or node
maintenance operation.
