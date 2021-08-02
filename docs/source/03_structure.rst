Project Structure
==================

The project structure is as follows:

.. code-block:: text

    ├── .janus
    │   ├── jellygrass.vim
    │   ├── vim
    │   └── vim-kolor
    ├── configuration_files
    │   ├── apticron.conf
    │   ├── nginx
    │   │   ├── letsencrypt.conf
    │   │   └── ssl.conf
    │   ├── origin-pull-ca.pem
    │   ├── postfix_main.cf
    │   ├── .tmux.conf
    │   ├── uwsgi.service
    │   ├── .vimrc.after
    │   └── .zshrc
    ├── custom_scripts
    │   ├── create_db
    │   ├── get_release_notes.py
    │   ├── janus_setup.sh
    │   ├── release.py
    │   └── shrinkpdf
    ├── docs
    │   ├── build
    │   ├── make.bat
    │   ├── Makefile
    │   ├── requirements.in
    │   ├── requirements.txt
    │   └── source
    │       ├── 01_introduction.rst
    │       ├── 02_features.rst
    │       ├── 03_structure.rst
    │       ├── 04_functions.rst
    │       ├── 05_roadmap.rst
    │       ├── 06_contributing.rst
    │       ├── conf.py
    │       ├── index.rst
    │       ├── _static
    │       └── _templates
    ├── tests
    │   ├── lib
    │   ├── results
    │   │   └── .gitkeep
    │   ├── tests.sh
    │   ├── unit-tests.sh
    │   └── Vagrant
    │       ├── Vagrantfile.bionic64
    │       ├── Vagrantfile.focal64
    │       ├── Vagrantfile.trusty32
    │       ├── Vagrantfile.trusty64
    │       ├── Vagrantfile.xenial32
    │       └── Vagrantfile.xenial64
    ├── .all-contributorsrc
    ├── .gitattributes
    ├── .gitignore
    ├── .gitmodules
    ├── .readthedocs.yaml
    ├── .travis.yml
    ├── .versionrc
    ├── CHANGELOG.md
    ├── CONTRIBUTING.md
    ├── LICENSE
    ├── package.json
    ├── package-lock.json
    ├── README.md
    ├── setup.sh
    └──setupLibrary.sh

Directories
------------

.janus
    This directory contains custom janus configuration files. It
    gets copied into the ``$HOME`` directory

configuration_files
    Cloudflare, Vim, TMUX, Nginx, uwsgi, Postfix, apticron, ``.zshrc``

custom_scripts
    ``shrinkpdf`` and ``create_db`` are copied to  ``$HOME/bin``. ``janus_setup.sh``
    is used during installing, while ``get_release_notes.py`` and ``release.py`` are
    used during development of this project to automate releases.

docs
    `Sphinx  <https://www.sphinx-doc.org/en/master/>`_, documentation for the project.
    This is what you are currently reading!

tests
    Project test suite. Tests are run against a set of Vagrant VMs.

Files
------

.. note::

   We'll not go through each and every file here, the assumption is that certain files
   are pretty obvious, for example, the git-related files such as ``.gitignore`` and
   ``.gitattributes``, CI files like ``.travis.yml``, etc.

.all-contributorsrc
    This project uses the `all-contributors <https://allcontributors.org/>`_ specification.
    The data used to generate the contributors list is stored in here.

.readthedocs.yaml
    The project documentation is hosted on `Read the Docs <https://readthedocs.org/>`_.
    The configuration for the documentation builds is defined in here.

.versionrc
    This project uses `standard-version <https://github.com/conventional-changelog/standard-version>`_.
    for versioning using `semver <https://semver.org/>`_ and CHANGELOG generation powered by
    `Conventional Commits <https://conventionalcommits.org/>`_.
    The ``standard-version`` configuration is defined in here, based on the
    `conventional-changelog-config-spec <https://github.com/conventional-changelog/conventional-changelog-config-spec/>`_.

CONTRIBUTING.md
    Guidelines on how to contribute to this project.

setup.sh
    This is the **core** of this project. This is the script that we actually run when setting
    up a new Ubuntu server. If you want to add additional features, you'll probably wanna
    edit this file.

setupLibrary.sh
    Contains the initial setup functions plus a couple of helper functions that are "imported" in ``setup.sh`` above
