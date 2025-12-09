# Changelog

## [1.6.4](https://github.com/vexxhost/ansible-collection-containers/compare/v1.6.3...v1.6.4) (2025-12-09)


### Bug Fixes

* **ci:** disable label adding for fork PRs ([#80](https://github.com/vexxhost/ansible-collection-containers/issues/80)) ([1fad53f](https://github.com/vexxhost/ansible-collection-containers/commit/1fad53f84fd33d97d8a34e5e062c25c433c5cc8c))
* move docker_config ([#84](https://github.com/vexxhost/ansible-collection-containers/issues/84)) ([f004529](https://github.com/vexxhost/ansible-collection-containers/commit/f0045294d9e7187d2e7fafe2fc5887dd567dae60))

## [1.6.3](https://github.com/vexxhost/ansible-collection-containers/compare/v1.6.2...v1.6.3) (2025-11-12)


### Miscellaneous Chores

* release 1.6.3 ([2a652e3](https://github.com/vexxhost/ansible-collection-containers/commit/2a652e305d6f2d338cf2f482565900ce81670369))

## [1.6.2](https://github.com/vexxhost/ansible-collection-containers/compare/v1.6.1...v1.6.2) (2025-11-06)


### Bug Fixes

* CVE-2024-25621 ([#69](https://github.com/vexxhost/ansible-collection-containers/issues/69)) ([282d603](https://github.com/vexxhost/ansible-collection-containers/commit/282d6031254391cfbf07d5192da87c2be232bc69))

## [1.6.1](https://github.com/vexxhost/ansible-collection-containers/compare/v1.6.0...v1.6.1) (2025-09-15)


### Bug Fixes

* change LimitNOFILE again ([524b5b0](https://github.com/vexxhost/ansible-collection-containers/commit/524b5b052e50fa95e9da00f6893e8b865b36a930))

## [1.6.0](https://github.com/vexxhost/ansible-collection-containers/compare/v1.5.0...v1.6.0) (2025-09-03)


### Features

* switch to py311 and upgrade ansible.posix to 1.6.0 ([#56](https://github.com/vexxhost/ansible-collection-containers/issues/56)) ([838cd40](https://github.com/vexxhost/ansible-collection-containers/commit/838cd404f2141c8df3ca84f5c6a441c3afcc4beb))

## [1.5.0](https://github.com/vexxhost/ansible-collection-containers/compare/v1.4.4...v1.5.0) (2025-09-02)


### Features

* bump all components + add automation ([#53](https://github.com/vexxhost/ansible-collection-containers/issues/53)) ([23a3da2](https://github.com/vexxhost/ansible-collection-containers/commit/23a3da260f8848738d00132510decdc97d79134f))

## [1.4.4](https://github.com/vexxhost/ansible-collection-containers/compare/v1.4.3...v1.4.4) (2025-08-26)


### Bug Fixes

* add missing override_command in molecule.yml configuration 🐛 ([69d98b4](https://github.com/vexxhost/ansible-collection-containers/commit/69d98b4ff7f342620eaa462d62b0846908910bf1))
* add missing runtime dependency ([f498458](https://github.com/vexxhost/ansible-collection-containers/commit/f498458ac87590c086a05a9ab6ea42a7c5150775))
* add missing volume mapping for /lib/modules in molecule config 🐛 ([d46c1d2](https://github.com/vexxhost/ansible-collection-containers/commit/d46c1d25c4f5e0235c29d2abe15926c674000a06))
* add pre_build_image option for molecule instance configuration 🐛 ([6f5c66f](https://github.com/vexxhost/ansible-collection-containers/commit/6f5c66f070da611e4e82463ddb1d284262b3d172))
* add prepare.yml for host preparation and apt cache update 🐛 ([a756a6d](https://github.com/vexxhost/ansible-collection-containers/commit/a756a6d8a060e2254135ab093bec5eb234637c5d))
* add tmpfs configuration for containerd in molecule.yml 🐛 ([b1f7f65](https://github.com/vexxhost/ansible-collection-containers/commit/b1f7f65065226c40e2746885cf7a0066f5e471ae))
* add ubuntu2004 to the nerdctl job matrix configuration 🐛 ([ac72336](https://github.com/vexxhost/ansible-collection-containers/commit/ac723360bd51b58934a78310739e31a11587109b))
* correct command for running Molecule tests ([5f618b2](https://github.com/vexxhost/ansible-collection-containers/commit/5f618b24a7d421477cdb5b5a9baff214ff39213a))
* correct condition for apt cache update to use ansible_os_family 🐛 ([5261b9d](https://github.com/vexxhost/ansible-collection-containers/commit/5261b9d28b4a83ae79e663123f3efc501c60a232))
* remove become directive from converge, prepare, and verify tasks 🐛 ([944b9f0](https://github.com/vexxhost/ansible-collection-containers/commit/944b9f0233c412f9135b67f8542c2e5343c2d5f7))
* remove deprecated version 8 from matrix in CI workflow 🐛 ([f679c6a](https://github.com/vexxhost/ansible-collection-containers/commit/f679c6aa3c1e60175eee088e200994527ca020d5))
* remove rockylinux10 from the molecule job matrix configuration 🐛 ([00f0e3e](https://github.com/vexxhost/ansible-collection-containers/commit/00f0e3e3ebf1f7810e0d284014d440c217deb500))
* Split image versions from URLs to make overriding easier ([#32](https://github.com/vexxhost/ansible-collection-containers/issues/32)) ([9e33f65](https://github.com/vexxhost/ansible-collection-containers/commit/9e33f65bba808820779aa252e3deb50f8909e91b))
* update ansible-lint version to v25.6.1 ([1a3068d](https://github.com/vexxhost/ansible-collection-containers/commit/1a3068d56c74162a62078d34ac725bdd47daa36c))
* update MOLECULE_DISTRO_ID to ubuntu for molecule tests 🐛 ([9541c0e](https://github.com/vexxhost/ansible-collection-containers/commit/9541c0e97640d440edaa3cf6ee688bef95a5d6c6))
* update prepare.yml to use tasks instead of roles for apt cache 🐛 ([5912dcd](https://github.com/vexxhost/ansible-collection-containers/commit/5912dcdb5a5c14c74949f3516c91074939c05ae9))
* update tmpfs and volumes configuration in molecule.yml 🐛 ([07af3d9](https://github.com/vexxhost/ansible-collection-containers/commit/07af3d965028cf4d7dacc6ca2791a450921abcf3))

## [1.2.1](https://github.com/vexxhost/ansible-collection-containers/compare/v1.2.0...v1.2.1) (2024-03-13)


### Bug Fixes

* **docker:** Update to version 24.0.9 ([56de01a](https://github.com/vexxhost/ansible-collection-containers/commit/56de01aac1c933e468ddd6473a7fc43029516969))

## [1.2.0](https://github.com/vexxhost/ansible-collection-containers/compare/v1.1.1...v1.2.0) (2024-02-20)


### Features

* add nerdctl ([db64437](https://github.com/vexxhost/ansible-collection-containers/commit/db644371ce1a93c4e5d25cf00c0a1a0b12b12842))


### Bug Fixes

* typo in image list command ([14bc5a8](https://github.com/vexxhost/ansible-collection-containers/commit/14bc5a852b4531f75165c1df6674a4040c21a661))

## [1.1.1](https://github.com/vexxhost/ansible-collection-containers/compare/v1.1.0...v1.1.1) (2023-12-04)


### Bug Fixes

* **docker:** start on install ([b446dcc](https://github.com/vexxhost/ansible-collection-containers/commit/b446dccc642179ea6ae7f381311acb8084c7b4a9))

## [1.1.0](https://github.com/vexxhost/ansible-collection-containers/compare/v1.0.2...v1.1.0) (2023-11-24)


### Bug Fixes

* add socket file and daemon configs ([f950faf](https://github.com/vexxhost/ansible-collection-containers/commit/f950faf94506412055b936cf58643e170a453f38))
* docker verify ([c560b93](https://github.com/vexxhost/ansible-collection-containers/commit/c560b936a43533a389fca53ad4434487abd57db2))
* fix ansible-lint ([7e64707](https://github.com/vexxhost/ansible-collection-containers/commit/7e647070dd48204b68389ae66a531e2d25719bc9))
* fix docker idempotence ([fbfab19](https://github.com/vexxhost/ansible-collection-containers/commit/fbfab199a33766451bdd0dd50b5033936c00673b))
* only include docker files when download ([705ac94](https://github.com/vexxhost/ansible-collection-containers/commit/705ac94ccdeff296622432a2cb59bfd837d5a70e))
* refector docker role ([03ab6ea](https://github.com/vexxhost/ansible-collection-containers/commit/03ab6ead9b29b5fb98ee85f96e7f3f31c58aa081))


### Miscellaneous Chores

* release 1.1.0 ([1b1689d](https://github.com/vexxhost/ansible-collection-containers/commit/1b1689d286e2063b22e09091e9f95cf85ec12010))

## [1.0.2](https://github.com/vexxhost/ansible-collection-containers/compare/v1.0.1...v1.0.2) (2023-11-21)


### Bug Fixes

* add docker_image plugin ([b264a8b](https://github.com/vexxhost/ansible-collection-containers/commit/b264a8b4c102708a2a346b3d5cdd9de0d1abf5e5))
* add empty tests dir ([19b4c3c](https://github.com/vexxhost/ansible-collection-containers/commit/19b4c3c2de81f352a7290113f2154952607ff3f6))
* add missing ansible-lint file ([fd9023c](https://github.com/vexxhost/ansible-collection-containers/commit/fd9023c477574c9466e537bf6150281ed12571f6))
* add missing files ([d49588c](https://github.com/vexxhost/ansible-collection-containers/commit/d49588c8ebf86140f663507bd3f87ea802bff15d))
* add missing vexxhost.kubernetes dependencies ([6f0c0b1](https://github.com/vexxhost/ansible-collection-containers/commit/6f0c0b1feb2652695e46e06580838dea11f9e3b7))
* Add write permissions to workflows ([d60aaa9](https://github.com/vexxhost/ansible-collection-containers/commit/d60aaa9b16167fb11f2d8db36ec0fa6985423333))
* refector repo ([9e0cfe6](https://github.com/vexxhost/ansible-collection-containers/commit/9e0cfe6f0e33ef5be4f15994912d4200f7a52fbe))
* remove vexxhost.kubernetes dependencies ([db19b06](https://github.com/vexxhost/ansible-collection-containers/commit/db19b06d9cb9ff367bd345ed15ddcb5d7a09eb96))
* use 0.0 for Earthfile version ([573ce74](https://github.com/vexxhost/ansible-collection-containers/commit/573ce748886d9c9dac21fd9b4e75d40d5a6b5741))
* use docker_image from vexxhost.kubernetes ([8e30b34](https://github.com/vexxhost/ansible-collection-containers/commit/8e30b34c8da7854db7efb385928ed714eec02ba1))

## [1.0.1](https://github.com/vexxhost/ansible-collection-containers/compare/v1.0.0...v1.0.1) (2023-11-20)


### Bug Fixes

* add docker_image plugin ([b264a8b](https://github.com/vexxhost/ansible-collection-containers/commit/b264a8b4c102708a2a346b3d5cdd9de0d1abf5e5))
* add empty tests dir ([19b4c3c](https://github.com/vexxhost/ansible-collection-containers/commit/19b4c3c2de81f352a7290113f2154952607ff3f6))
* add missing ansible-lint file ([fd9023c](https://github.com/vexxhost/ansible-collection-containers/commit/fd9023c477574c9466e537bf6150281ed12571f6))
* add missing files ([d49588c](https://github.com/vexxhost/ansible-collection-containers/commit/d49588c8ebf86140f663507bd3f87ea802bff15d))
* add missing vexxhost.kubernetes dependencies ([6f0c0b1](https://github.com/vexxhost/ansible-collection-containers/commit/6f0c0b1feb2652695e46e06580838dea11f9e3b7))
* Add write permissions to workflows ([d60aaa9](https://github.com/vexxhost/ansible-collection-containers/commit/d60aaa9b16167fb11f2d8db36ec0fa6985423333))
* refector repo ([9e0cfe6](https://github.com/vexxhost/ansible-collection-containers/commit/9e0cfe6f0e33ef5be4f15994912d4200f7a52fbe))
* remove vexxhost.kubernetes dependencies ([db19b06](https://github.com/vexxhost/ansible-collection-containers/commit/db19b06d9cb9ff367bd345ed15ddcb5d7a09eb96))
* use 0.0 for Earthfile version ([573ce74](https://github.com/vexxhost/ansible-collection-containers/commit/573ce748886d9c9dac21fd9b4e75d40d5a6b5741))
* use docker_image from vexxhost.kubernetes ([8e30b34](https://github.com/vexxhost/ansible-collection-containers/commit/8e30b34c8da7854db7efb385928ed714eec02ba1))

## Changelog
