# Copyright (c) 2024 BBC R&D, Inc.
# Copyright (c) 2025 VEXXHOST, Inc.
# SPDX-License-Identifier: Apache-2.0

# Make coding more python3-ish, this is required for contributions to Ansible
from __future__ import absolute_import, division, print_function

__metaclass__ = type

from ansible.plugins.action import ActionBase

try:
    from ansible.template import trust_as_template as _trust_as_template

    HAS_DATATAGGING = True
except ImportError:
    HAS_DATATAGGING = False


def _make_safe(value):
    if HAS_DATATAGGING and isinstance(value, str):
        return _trust_as_template(value)
    return value


class ActionModule(ActionBase):
    def run(self, tmp=None, task_vars=None):
        if task_vars is None:
            task_vars = dict()
        result = super(ActionModule, self).run(tmp, task_vars)
        del tmp

        temp_vars = task_vars.copy()
        downloads = list()

        templar = self._templar.copy_with_new_env()
        templar.available_variables = temp_vars

        for p in self._task.args.get("prefixes", None):
            checksums = task_vars.get(p + "_checksums", None)
            if not checksums:
                checksums = task_vars.get(p + "_archive_checksums", None)

            # iterate over all defined versions for this download prefix
            for v, c in checksums["amd64"].items():
                temp_vars[p + "_version"] = v
                url = templar.template(task_vars.get(p + "_download_url"))
                dest = templar.template(task_vars.get(p + "_download_dest"))

                if dest.startswith("/usr/"):
                    temp_vars["_prefix"] = p
                    temp_vars["_version"] = v
                    dest = self._templar.template(
                        _make_safe(
                            f"{{{{ download_artifact_work_directory }}}}/{p}-{v}-{{{{ ansible_facts['system'] | lower }}}}-{{{{ download_artifact_goarch }}}}"  # noqa
                        )
                    )

                res = dict()
                res["url"] = url
                res["checksum"] = c
                res["dest"] = dest
                res["version"] = v

                downloads.append(res)

        result["downloads"] = downloads
        result["failed"] = False
        return result
