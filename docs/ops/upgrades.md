# Upgrades

At the moment, the collection does not have a playbook to allow for automatic
detection of the current version and upgrade to the latest version.  In the
meantime, upgrades need to be done manually.

For the following steps, please make sure to select the "Playbooks" tab if you
used the playbooks directly and "Atmosphere" if you are using this collection
as part of the Atmosphere deployment.

!!! warning

    All of the commands below include both `--check` and `--diff` flags, you
    must remove them before running the commands if you want to apply the
    changes.

While running the steps below, you will need to make sure to verify that the
cluster is still functional after each step.

!!! warning

    These instructions have been validated for the 1.5.2 release of the
    collection (which ships in Atmosphere 1.5.1).

## Control plane infrastructure + `containerd`

!!! warning

    This step will "forget" the package by manipulating the `dpkg` database
    in order to avoid killing the service, it's recommended to try running
    this step on a test cluster and also on a single node before running it
    on the entire cluster.

=== "Playbooks"

    ``` bash
    ansible-playbook -i inventory/hosts.ini --check --diff /dev/stdin <<END
    ---
    - name: Configure Kubernetes VIP
      hosts: "{{ kubernetes_control_plane_group | default('controllers') }}"
      become: true
      roles:
        - role: vexxhost.kubernetes.keepalived
        - role: vexxhost.kubernetes.haproxy

    - name: Install Kubernetes
      hosts: "{{ kubernetes_group | default('all') }}"
      become: true
      roles:
        - role: vexxhost.containers.containerd
    END
    ```

=== "Atmosphere"

    ``` bash
    ansible-playbook -i inventory/hosts.ini --check --diff /dev/stdin <<END
    ---
    - name: Configure Kubernetes VIP
      hosts: "{{ kubernetes_control_plane_group | default('controllers') }}"
      become: true
      roles:
        - role: vexxhost.atmosphere.defaults
        - role: vexxhost.kubernetes.keepalived
          vars:
            keepalived_image: "{{ atmosphere_images['keepalived'] }}"
            keepalived_vrid: "{{ kubernetes_keepalived_vrid }}"
            keepalived_interface: "{{ kubernetes_keepalived_interface }}"
            keepalived_vip: "{{ kubernetes_keepalived_vip }}"
        - role: vexxhost.kubernetes.haproxy
          vars:
            haproxy_image: "{{ atmosphere_images['haproxy'] }}"

    - name: Install Kubernetes
      hosts: "{{ kubernetes_group | default('all') }}"
      become: true
      roles:
        - role: vexxhost.atmosphere.defaults
        - role: vexxhost.containers.containerd
          vars:
            containerd_pause_image: "{{ atmosphere_images['pause'] }}"
    END
    ```
