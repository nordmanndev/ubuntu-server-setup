# Changelog

All notable changes to this project will be documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project attempts to adhere to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [v1.2.0](https://github.com/engineervix/ubuntu-server-setup/compare/v1.1.0...v1.2.0) (2021-08-06)


### 🐛 Bug Fixes

* do not source `.tmux.conf` during setup ([ee9a938](https://github.com/engineervix/ubuntu-server-setup/commit/ee9a9386515f892bcf1726ebe017795c37876e04))
* install `net-tools` package to provide the `netstat` command ([8f50b1a](https://github.com/engineervix/ubuntu-server-setup/commit/8f50b1a9921ca1d03ffa7819e47a84547e63252a))


### 🚀 Features

* add memcached ([2bc7160](https://github.com/engineervix/ubuntu-server-setup/commit/2bc7160defaec67fbbed4406239a596f7aca6913))
* add terminal enhancements, extra global npm packages & improve celery setup ([46070d1](https://github.com/engineervix/ubuntu-server-setup/commit/46070d15dcc838c57b98e614870c0aef17af54d0))
* configure tmux with powerline and Tmux Plugin Manager ([452468b](https://github.com/engineervix/ubuntu-server-setup/commit/452468b5221c4ae954f293923c3c7d734c0f5790))
* install dos2unix ([f8a4437](https://github.com/engineervix/ubuntu-server-setup/commit/f8a44372f1e357c4861a487b6bc9fffcab2d7aa8))
* no need for user input when configuring unattended-upgrades ([7e0646a](https://github.com/engineervix/ubuntu-server-setup/commit/7e0646a337f71bfeb1f9e88b2d5ab6193e564401))
* unattended Postgres install ([8b18b75](https://github.com/engineervix/ubuntu-server-setup/commit/8b18b75d2c4a3ea767ef685d85ed52503d0e750e))


### ♻️ Code Refactoring

* apt-mark auto libsasl2-modules ([b7c9933](https://github.com/engineervix/ubuntu-server-setup/commit/b7c9933808a89f5859cf516c88859cfc374eed09))
* move all dot files into the **configuration_files** directory ([0fbdc21](https://github.com/engineervix/ubuntu-server-setup/commit/0fbdc21acbf2a3fd96b9454777b08c5c9909edd3))


### 📝 Docs

* cross out one item in TODO list and reference commit ([9f3c0de](https://github.com/engineervix/ubuntu-server-setup/commit/9f3c0dec4fad82cd8fa3b8a748c180a2281552a4))
* document project features ([ac2b65f](https://github.com/engineervix/ubuntu-server-setup/commit/ac2b65f07b420adef2cc43ade327c54e2d9a465c))
* document the project structure ([eff9874](https://github.com/engineervix/ubuntu-server-setup/commit/eff9874abd73e417719eca96a2b65c5c6d6ecfae))
* enable HTML5 writer support ([001cabe](https://github.com/engineervix/ubuntu-server-setup/commit/001cabea90a2efd37f53b0d875af5eefa8676a22))
* follow the official instructions for setting up sphinx-rtd-theme ([d720544](https://github.com/engineervix/ubuntu-server-setup/commit/d72054479d52763cfa62b03cf1b300f27ad3aac2))
* **readme:** make reference to 8b18b7 ([0cd6045](https://github.com/engineervix/ubuntu-server-setup/commit/0cd60456aced1226f6d9525cd6470b31334ba096))
* **readme:** replace Travis CI badge with Github Actions badge ([100e643](https://github.com/engineervix/ubuntu-server-setup/commit/100e64300f9ec5dfcd1ba7a1ad23206e4b63e9bb))
* use Hlists for better presentation of long lists ([c538f02](https://github.com/engineervix/ubuntu-server-setup/commit/c538f02d0b416d944a84a65d4f6699a0e7ebfb4a))


### 👷 CI/CD

* adapt `get_release_notes.py` for GitHub Actions ([3ab3883](https://github.com/engineervix/ubuntu-server-setup/commit/3ab388310517d7093b59c16e0d65069575db09e9))
* add some notes, npm `new_release` script & let Travis create draft releases ([bd0e2d4](https://github.com/engineervix/ubuntu-server-setup/commit/bd0e2d47ebdc09151b19ea0421b2990140d8f777))
* switch to Github Actions ([1944bd5](https://github.com/engineervix/ubuntu-server-setup/commit/1944bd53db43cadc594cbaa75464c7cf640c56b9))
* update GitHub Actions workflow to include automatic GitHub Releases ([28c3d7a](https://github.com/engineervix/ubuntu-server-setup/commit/28c3d7a12f8eaeeb84ded4f08549873aff517ac2))

## [v1.1.0](https://github.com/engineervix/ubuntu-server-setup/compare/v1.0.0...v1.1.0) (2021-07-08)


### Bug Fixes

* add a `-p` flag when creating directories for the celery config ([a9a0530](https://github.com/engineervix/ubuntu-server-setup/commit/a9a05308ed94b739d6a08442ba63651956e9ac85))
* bugfix due to GPG error: NO_PUBKEY 9DE922F1C2FDE6C4 when installing lynis ([f4ae37e](https://github.com/engineervix/ubuntu-server-setup/commit/f4ae37e05b7701eed15a54a13a0e74c727ea87fd))
* change ownership of `.pgpass` from root to newly created user ([574a164](https://github.com/engineervix/ubuntu-server-setup/commit/574a16456492c4847187ec2fc1af92df1aea071e))
* correct the directory for uwsgi project configurations ([02c594f](https://github.com/engineervix/ubuntu-server-setup/commit/02c594f0817d1fbe1683e87e2e899699ca9f8d8b))
* rename configuration_files/origin-pull-ca.pem.ca to configuration_files/origin-pull-ca.pem ([3e8a6b4](https://github.com/engineervix/ubuntu-server-setup/commit/3e8a6b4e8f05b7347e7db6133461b7e2b4affd7a))
* repair broken setupGit function and deal with 404 on origin-pull-ca.pem ([b18c8f9](https://github.com/engineervix/ubuntu-server-setup/commit/b18c8f918069814a3623199cb3976bcc970c5074))
* use the correct format for Cloudflare's Authenticated Origin Pulls feature ([9148cae](https://github.com/engineervix/ubuntu-server-setup/commit/9148caef483256f3d1108aca09bfcd48a8e93a07))


### Code Refactoring

* include system update and fix git config ([#2](https://github.com/engineervix/ubuntu-server-setup/issues/2)) ([6ecb2b3](https://github.com/engineervix/ubuntu-server-setup/commit/6ecb2b3f490a063a8a64b076d71b9b20002c04f6))


### Docs

* add readthedocs badge ([a25c61d](https://github.com/engineervix/ubuntu-server-setup/commit/a25c61d9af66b8ad992120787c51f6644aecf5d3))
* write detailed docs for hosting on readthedocs ([93eacc9](https://github.com/engineervix/ubuntu-server-setup/commit/93eacc93ac8f31a06f40056bf8cfeb8a825853a8))
* **contributing:** add contribution guidelines ([a0037dc](https://github.com/engineervix/ubuntu-server-setup/commit/a0037dc1a0d132fc2f60be46bb100fca97625e59))
* **readme:** add example usage of certbot-dns-cloudflare ([900032c](https://github.com/engineervix/ubuntu-server-setup/commit/900032c9757954781281ede0f918e18ab20df109))
* **readme:** reorganize README after incorporation of all-contributors ([518c26a](https://github.com/engineervix/ubuntu-server-setup/commit/518c26a91c907245d5989cba06589b4d0dc063f7))
* add muse-sisay as a contributor for code, bug ([#3](https://github.com/engineervix/ubuntu-server-setup/issues/3)) ([caced93](https://github.com/engineervix/ubuntu-server-setup/commit/caced9392fb796f07de853ad92cf3e273843adf8))
* **readme:** add section on contributing, add all-contributors info and badge ([b19b65a](https://github.com/engineervix/ubuntu-server-setup/commit/b19b65a9dbb3e3e21d8f2e1d2682ccd6a9223a68))


### Others

* change ownership of ~/bin/ directory to the new user ([0813e72](https://github.com/engineervix/ubuntu-server-setup/commit/0813e7201ab12dff1013f51258d041476d15438f))
* customization of changelog generation ([1d3f4ed](https://github.com/engineervix/ubuntu-server-setup/commit/1d3f4ed1050f17abbcd8251c7f2b8ca37159b9e7))
* install apt-clone ([c629712](https://github.com/engineervix/ubuntu-server-setup/commit/c629712cf64c10cfddba438a81da5d40d4242aaf))
* regenerate and reformat changelog using standard version ([7bba42a](https://github.com/engineervix/ubuntu-server-setup/commit/7bba42adcbbc801c2dcd2e85a3187f448a6ff8ed))
* remove standard-version release-as ... scripts ([bedcc1f](https://github.com/engineervix/ubuntu-server-setup/commit/bedcc1f51044edb6967b0ed4e30c7811b4388d08))
* **docs:** add some cool sphinx extensions ([1bbca24](https://github.com/engineervix/ubuntu-server-setup/commit/1bbca24742056bbfc7b2033862e937a59f95403e))
* **package.json:** add shellcheck script ([3080dcc](https://github.com/engineervix/ubuntu-server-setup/commit/3080dcce92725f8cef3d2c1c8e7eb165e92aff10))


### CI

* automation of release process ([80a5d76](https://github.com/engineervix/ubuntu-server-setup/commit/80a5d76847c56b5c8df7d64a3f85040f6c21bd0e))

## [v1.0.0](https://github.com/engineervix/ubuntu-server-setup/compare/v0.0.2...v1.0.0) (2021-06-09)


### Features

* add configuration files ([ec05acc](https://github.com/engineervix/ubuntu-server-setup/commit/ec05acc37602414586366bee8f26f34eed4d49e9))
* add custom scripts ([660f255](https://github.com/engineervix/ubuntu-server-setup/commit/660f2554a4f4fbd22dcda454239031d04432d337))
* automate a lot of mundane tasks ([4ad6ead](https://github.com/engineervix/ubuntu-server-setup/commit/4ad6ead5cb751233b70180e30b33f782383a4a6c))
* use latest Node.js LTS version instead of 12.x ([7bb0270](https://github.com/engineervix/ubuntu-server-setup/commit/7bb02701222c453ddcbc57964cbb37938f97dc4a))


### Bug Fixes

* remove the -r option on the Sendgrip API key prompt ([76c6010](https://github.com/engineervix/ubuntu-server-setup/commit/76c6010c71809fa5f7a0c3f49989b01416b82796))


### Code Refactoring

* reorganize files ([8d275e7](https://github.com/engineervix/ubuntu-server-setup/commit/8d275e7d8f4d2e3c6bd1dce71610daf2daac74fb))


### Tests

* fix broken test ([7976e38](https://github.com/engineervix/ubuntu-server-setup/commit/7976e382aaa1914bed7c96ea827ea7d2f685d573))


### CI

* update build config ([d84e4c7](https://github.com/engineervix/ubuntu-server-setup/commit/d84e4c72ad855a5d165d1f4587757f2b26a3398d))
* update build config again ([f725359](https://github.com/engineervix/ubuntu-server-setup/commit/f7253592d80e6126df0ffb7599b776100854124a))
* use bionic instead of xenial ([a51ed63](https://github.com/engineervix/ubuntu-server-setup/commit/a51ed632465504273399747dc3d262177da9e82f))


### Docs

* update docs ([5e2bd82](https://github.com/engineervix/ubuntu-server-setup/commit/5e2bd823774aafdfb5987f0d4212457b01bfd892))
* update documentation ([7aa25dd](https://github.com/engineervix/ubuntu-server-setup/commit/7aa25dd94d8f7800ad89cb250045770d0cbfc623))
* update README ([555948f](https://github.com/engineervix/ubuntu-server-setup/commit/555948f8c389b776138412490e148694ffd4012d))
* update README ([b811fae](https://github.com/engineervix/ubuntu-server-setup/commit/b811fae0b359330f5806628261a595201c2678c1))
* update the docs ([57082a3](https://github.com/engineervix/ubuntu-server-setup/commit/57082a31d1a67248866a9a29d071f55e30800a65))


### Others

* **release:** 1.0.0 ([07d631d](https://github.com/engineervix/ubuntu-server-setup/commit/07d631d29f217080325d841218df8f50d5294181))
* add commitizen ([a779c01](https://github.com/engineervix/ubuntu-server-setup/commit/a779c0163a3d89cd5c294eebfaedf8e13dfa528f))
* add configuration specs for standard-version ([83d644e](https://github.com/engineervix/ubuntu-server-setup/commit/83d644ea473e79d96b5eb2f0c20af2e82518a5ad))
* add example for testing email setup ([9c685d3](https://github.com/engineervix/ubuntu-server-setup/commit/9c685d3cb8b3f737b610a7b093a0375f07d8a1cf))
* add standard-version ([011e00e](https://github.com/engineervix/ubuntu-server-setup/commit/011e00e0159a4152049b86a6e1785cd828f1228a))
* create a backup of existing /etc/postfix/main.cf before replacing it with custom config ([99a809a](https://github.com/engineervix/ubuntu-server-setup/commit/99a809a24803b9f77181b3faf97b3e05fa1854dd))
* further enhancements to address shellcheck warnings ([3b48478](https://github.com/engineervix/ubuntu-server-setup/commit/3b48478ed0fe471d0e3e2c200777f4d424a4739d))
* improve user feedback ([329bed8](https://github.com/engineervix/ubuntu-server-setup/commit/329bed8c815a704e0a4b5b56356cd95b58d415b9))
* modify setup to suit DigitalOcean Ubuntu Droplets ([976272a](https://github.com/engineervix/ubuntu-server-setup/commit/976272a1e909944106b70b8cf2aa441e1d9fca13))
* update .zshrc ([9ed7809](https://github.com/engineervix/ubuntu-server-setup/commit/9ed7809530ffbff996613d8e484be983cba040fe))
* update LICENSE ([394fad0](https://github.com/engineervix/ubuntu-server-setup/commit/394fad0b7bc1ae943ee76ef6b7a1605ad62cb0f7))

## [v0.0.2](https://github.com/engineervix/ubuntu-server-setup/compare/v0.0.1...v0.0.2) (2021-02-09)

## [v0.0.1](https://github.com/engineervix/ubuntu-server-setup/compare/6ce63c9e1b58232c993f4fc8bf2ccbac5af6026d...v0.0.1) (2021-02-09)
