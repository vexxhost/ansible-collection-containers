# Copyright (c) 2022 VEXXHOST, Inc.
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

import pytest
from ansible_collections.vexxhost.containers.plugins.filter.docker_image import (
    docker_image,
)


@pytest.mark.parametrize(
    "test_input,expected",
    [
        ("quay.io/vexxhost/glance:zed", "quay.io/vexxhost/glance:zed"),
        (
            "us-docker.pkg.dev/vexxhost-infra/openstack/heat:wallaby",
            "us-docker.pkg.dev/vexxhost-infra/openstack/heat:wallaby",
        ),
        (
            "k8s.gcr.io/sig-storage/csi-snapshotter:v4.2.0",
            "k8s.gcr.io/sig-storage/csi-snapshotter:v4.2.0",
        ),
        ("docker.io/library/haproxy:2.5", "docker.io/library/haproxy:2.5"),
        (
            "k8s.gcr.io/ingress-nginx/controller:v1.1.1@sha256:0bc88eb15f9e7f84e8e56c14fa5735aaa488b840983f87bd79b1054190e660de",  # noqa E501
            "k8s.gcr.io/ingress-nginx/controller:v1.1.1@sha256:0bc88eb15f9e7f84e8e56c14fa5735aaa488b840983f87bd79b1054190e660de",  # noqa E501
        ),
    ],
)
def test_docker_image_ref(test_input, expected):
    assert docker_image(test_input, "ref") == expected


@pytest.mark.parametrize(
    "test_input,expected",
    [
        ("quay.io/vexxhost/glance:zed", "quay.io/vexxhost/glance"),
        (
            "us-docker.pkg.dev/vexxhost-infra/openstack/heat:wallaby",
            "us-docker.pkg.dev/vexxhost-infra/openstack/heat",
        ),
        (
            "k8s.gcr.io/sig-storage/csi-snapshotter:v4.2.0",
            "k8s.gcr.io/sig-storage/csi-snapshotter",
        ),
        ("docker.io/library/haproxy:2.5", "docker.io/library/haproxy"),
        (
            "k8s.gcr.io/ingress-nginx/controller:v1.1.1@sha256:0bc88eb15f9e7f84e8e56c14fa5735aaa488b840983f87bd79b1054190e660de",  # noqa E501
            "k8s.gcr.io/ingress-nginx/controller",
        ),
    ],
)
def test_docker_image_name(test_input, expected):
    assert docker_image(test_input, "name") == expected


@pytest.mark.parametrize(
    "test_input,expected",
    [
        ("quay.io/vexxhost/glance:zed", "quay.io"),
        (
            "us-docker.pkg.dev/vexxhost-infra/openstack/heat:wallaby",
            "us-docker.pkg.dev",
        ),
        (
            "k8s.gcr.io/sig-storage/csi-snapshotter:v4.2.0",
            "k8s.gcr.io",
        ),
        ("docker.io/library/haproxy:2.5", "docker.io"),
        (
            "k8s.gcr.io/ingress-nginx/controller:v1.1.1@sha256:0bc88eb15f9e7f84e8e56c14fa5735aaa488b840983f87bd79b1054190e660de",  # noqa E501
            "k8s.gcr.io",
        ),
    ],
)
def test_docker_image_domain(test_input, expected):
    assert docker_image(test_input, "domain") == expected


@pytest.mark.parametrize(
    "test_input,expected",
    [
        ("quay.io/vexxhost/glance:zed", "vexxhost/glance"),
        (
            "us-docker.pkg.dev/vexxhost-infra/openstack/heat:wallaby",
            "vexxhost-infra/openstack/heat",
        ),
        (
            "k8s.gcr.io/sig-storage/csi-snapshotter:v4.2.0",
            "sig-storage/csi-snapshotter",
        ),
        ("docker.io/library/haproxy:2.5", "library/haproxy"),
        (
            "k8s.gcr.io/ingress-nginx/controller:v1.1.1@sha256:0bc88eb15f9e7f84e8e56c14fa5735aaa488b840983f87bd79b1054190e660de",  # noqa E501
            "ingress-nginx/controller",
        ),
    ],
)
def test_docker_image_path(test_input, expected):
    assert docker_image(test_input, "path") == expected


@pytest.mark.parametrize(
    "test_input,expected",
    [
        ("quay.io/vexxhost/glance:zed", "quay.io/vexxhost"),
        (
            "us-docker.pkg.dev/vexxhost-infra/openstack/heat:wallaby",
            "us-docker.pkg.dev/vexxhost-infra/openstack",
        ),
        (
            "registry.k8s.io/kube-apiserver:v1.22.0",
            "registry.k8s.io",
        ),
        (
            "k8s.gcr.io/sig-storage/csi-snapshotter:v4.2.0",
            "k8s.gcr.io/sig-storage",
        ),
        ("docker.io/library/haproxy:2.5", "docker.io/library"),
        (
            "k8s.gcr.io/ingress-nginx/controller:v1.1.1@sha256:0bc88eb15f9e7f84e8e56c14fa5735aaa488b840983f87bd79b1054190e660de",  # noqa E501
            "k8s.gcr.io/ingress-nginx",
        ),
    ],
)
def test_docker_image_prefix(test_input, expected):
    assert docker_image(test_input, "prefix") == expected
