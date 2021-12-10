Project Features
=================

.. note::

    We focus only on the additional features not available in the
    upstream version of this fork. The original features are listed
    in the :ref:`intro` and in the original project's
    `README <https://github.com/jasonheecs/ubuntu-server-setup/blob/master/README.md>`_.

Terminal Enhancements
-----------------------

* `ZSH <https://www.zsh.org/>`_ + `ohmyzsh <https://ohmyz.sh/>`_ + `Powerlevel10k <https://github.com/romkatv/powerlevel10k>`_ = 😎
* includes several cool ZSH plugins, for example:

  - `zsh-autosuggestions <https://github.com/zsh-users/zsh-autosuggestions>`_
  - `zsh-syntax-highlighting <https://github.com/zsh-users/zsh-syntax-highlighting>`_

* colorized ``ls`` output with colour and icons, courtesy of `Color LS <https://github.com/athityakumar/colorls>`_
* fancy Tmux configuration using **powerline** and `Tmux Plugin Manager <https://github.com/tmux-plugins/tpm>`_
* custom ``.zshrc`` configuration, with several useful shell functions

Git Customization
------------------

- minimal global ``git`` configuration with ``user.name``, ``user.email`` and ``color.ui``

Node.js Stack
---------------

* You cannot build modern web applications without using the Node.js tech stack.
  Therefore, the latest LTS version of Node.js is installed, together with Yarn.
* a bunch of useful Node.js global packages:

.. hlist::
    :columns: 2

    - `browser-sync <https://browsersync.io/>`_
    - `caniuse-cmd <https://www.npmjs.com/package/caniuse-cmd>`_
    - `commitizen <https://github.com/commitizen/cz-cli>`_
    - `concurrently <https://www.npmjs.com/package/concurrently>`_
    - `doctoc <https://github.com/thlorenz/doctoc>`_
    - `html-minifier <https://github.com/kangax/html-minifier>`_
    - `grunt-cli <https://gruntjs.com/>`_
    - `gulp-cli <https://gulpjs.com/>`_
    - `lerna <https://github.com/lerna/lerna>`_
    - `lite-server <https://www.npmjs.com/package/lite-server>`_
    - `local-cors-proxy <https://github.com/garmeeh/local-cors-proxy>`_
    - `maildev <http://maildev.github.io/maildev/>`_
    - `mdpdf <https://www.npmjs.com/package/mdpdf>`_
    - `mozjpeg <https://github.com/mozilla/mozjpeg>`_
    - `prettier <https://prettier.io/>`_
    - `sass <https://sass-lang.com/>`_
    - `semantic-release-cli <https://github.com/semantic-release/cli>`_
    - `serve <https://www.npmjs.com/package/serve>`_
    - `standard-version <https://github.com/conventional-changelog/standard-version>`_
    - `svgo <https://github.com/svg/svgo>`_
    - `uglify-js <https://www.npmjs.com/package/uglify-js>`_

Python Stack
-------------

* Python3 and associated build tools
* virtualenvwrapper
* uwsgi
* celery
* TODO: setup pyenv

Ruby
-----

Ruby has to be installed because

* Certain applications need it in order for them to be setup, for example,
  the `Janus Vim distribution <https://github.com/carlhuda/janus>`_
* there are a couple of Ruby gems that we need (``travis`` cli and ``colorls``)

Database Stack
---------------

* Postgres + PostGIS

Webserver
----------

* Nginx, with ready-to-use HTTPS, LetsEncrypt + Cloudflare configuration 

Certbot
----------

* ready to use with Cloudflare, via the `dns_cloudflare <https://certbot-dns-cloudflare.readthedocs.io/en/stable/>`_ plugin
* automatic renewal and custom post-renewal script

Text Editor
------------

* Includes `Janus <https://github.com/carlhuda/janus>`_ – a Vim Distribution designed to provide minimal working environment using the most popular plugins and the most common mappings.

Mail
-----

- The server is configured to send emails using `Postfix <http://www.postfix.org/>`_ and `Sendgrid <https://sendgrid.com/>`_
- includes the `Mutt <http://www.mutt.org/>`_ email Client

System Administration
-----------------------

* Unattended upgrades and automatic reboots when necessary
* Monitoring of server logs and email notifications using `Logwatch <https://help.ubuntu.com/community/Logwatch>`_

Additional Server Hardening
-----------------------------

- restrict access to the server by specifying who is allowed to login
- secure shared memory
- fail2ban
- lynis
- rkhunter

.. _additional_packages:

Additional Packages
--------------------

.. hlist::
    :columns: 2

    - Redis
    - Memcached
    - TeX-Live
    - openjdk-8-jdk
    - travis cli
    - wkhtmltopdf
    - pdftk
    - ffmpeg
    - youtube-dl
    - rclone
    - volta
    - pngquant
    - ocrmypdf
    - xvfb
    - rdiff-backup
    - apt-clone
    - firefox
    - pandoc
    - sqlite3
    - poppler-utils
    - ncdu
    - libtool
    - dos2unix
    - scour
    - shellcheck
    - `jq <https://stedolan.github.io/jq/>`_ and `yq <https://kislyuk.github.io/yq/>`_
    - inkscape
    - libreoffice-common
    - autoconf, automake and autotools-dev
    - aspell and hunspell

Miscellaneous Tasks
--------------------

- custom scripts and tools (e.g. `geckodriver <https://github.com/mozilla/geckodriver>`_) in ``$HOME/bin``
- custom directories for projects, backups and misc/temp