# Copyright (c) 2024 BBC R&D, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

# Make coding more python3-ish, this is required for contributions to Ansible
from __future__ import absolute_import, division, print_function

__metaclass__ = type

from ansible.plugins.action import ActionBase
from ansible.template import AnsibleEnvironment


class ActionModule(ActionBase):
    def run(self, tmp=None, task_vars=None):

        if task_vars is None:
            task_vars = dict()
        result = super(ActionModule, self).run(tmp, task_vars)
        del tmp

        temp_vars = task_vars.copy()
        downloads = list()

        templar = self._templar.copy_with_new_env(environment_class=AnsibleEnvironment)
        templar.available_variables = temp_vars

        for p in self._task.args.get("prefixes", None):
            checksums = task_vars.get(p + "_checksums", None)
            if not checksums:
                checksums = task_vars.get(p + "_archive_checksums", None)

            # iterate over all defined versions for this download prefix
            for v, c in checksums["amd64"].items():
                temp_vars[p + "_version"] = v
                url = templar.do_template(task_vars.get(p + "_download_url"))
                dest = templar.do_template(task_vars.get(p + "_download_dest"))

                if dest.startswith("/usr/"):
                    temp_vars["_prefix"] = p
                    temp_vars["_version"] = v
                    dest = templar.do_template(
                        "{{ download_artifact_work_directory }}/{{ _prefix }}-{{ _version }}-{{ ansible_facts['system'] | lower }}-{{ download_artifact_goarch }}"  # noqa
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
