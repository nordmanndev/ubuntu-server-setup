.. _funcs:

Functions
==========

.. note::

    We focus only on the additional functions not available in the
    upstream version of this fork.
    
    You may find this section particularly useful if you would like to
    customize the existing features or add other features of your own.

    In ``setup.sh``, where these functions live, there's also a ``main()`` function
    which, as the name implies, is the main function. All these functions are called
    inside this ``main()`` function. If you write your own function, you'll wanna find
    somewhere within the ``main()`` function to call it.

extraHardening
    Here we restrict access to the server and secure shared memory

setupHostname
    At the time of developing this script, I was dealing primarily with AWS EC2 deployments,
    where you have to update the hostname and the ``/etc/hosts`` file, plus made some changes
    to the ``/etc/cloud/cloud.cfg``. I realized that this was not required for other cloud service
    providers (e.g. Digital Ocean droplets and Hetzner Cloud servers).
    Therefore, by default, the call to this function is commented out in the ``main()`` function.
    You might wanna uncomment if deploying on AWS.

setupNodeYarn
    Install Node.js, yarn and some important global node packages

setupGit
    Global git configuration involving setting up of ``user.name``, ``user.email`` and ``color.ui true``

setupZSH
    Here we install and configure `zsh <https://www.zsh.org/>`_, `Oh My Zsh <https://ohmyz.sh/>`_ and
    the `powerlevel10k <https://github.com/romkatv/powerlevel10k>`_ theme.

setupRuby
    Simple ruby setup. Ruby is needed for the `Janus Vim distribution <https://github.com/carlhuda/janus>`_,
    `colorls <https://github.com/athityakumar/colorls>`_ and the
    `Travis CI Client <https://github.com/travis-ci/travis.rb>`_, among others.

setupTmux
    Tmux comes already installed with Ubuntu, and so there's no need to install it.
    Here we just install the `Tmux Plugin Manager https://github.com/tmux-plugins/tpm`_ 
    and add some configurations and styling (using `Powerline <https://packages.ubuntu.com/focal/powerline>`_)

setupPythonDev
    First and foremost, we install python, pip and related dev / build tools.
    Then, we install and configure virtualenvwrapper and uWSGI. Lastly, but not the least,
    we prepare the server for `Celery <https://docs.celeryproject.org/>`_,
    based on `this blog post <https://importthis.tech/djangocelery-from-development-to-production>`_.

setupVim
    Install and configure Vim & related plugins, courtesy of the `Janus Vim Distribution <https://github.com/carlhuda/janus>`_.

setupDatabases
    Install and configure PostgreSQL, PostGIS, Redis and Memcached.

setupWebServer
    Install and configure Nginx and Certbot (plus the ``certbot-dns-cloudflare`` plugin).
    This includes adding a cron job whith a **Let's Encrypt** renewal hook. Also generate
    a strong set of 4096 bit DH (Diffie-Hellman) parameters using openSSL.

setupMail
    Install and configure Postfix and related mail utilities. The setup assumes you're
    using `Sendgrid <https://sendgrid.com/>`_'s SMTP server/relay, but this can easily be customized to use
    other providers such as `Mailjet <https://www.mailjet.com/>`_, for instance.

configureSystemUpdatesAndLogs
    Updates notification, unattended upgrades, logs and other necessary System Administration stuff.

furtherHardening
    Install and configure ``fail2ban``, `lynis <https://cisofy.com/lynis/>`_ and
    `rkhunter <https://packages.ubuntu.com/source/focal/rkhunter>`_.

miscellaneousTasks
    Setup some folders for common operations, copy the custom scripts to the ``~/bin`` directory
    and install `geckodriver <https://github.com/mozilla/geckodriver/releases>`_
    (for use with `selenium <https://selenium-python.readthedocs.io/>`_).

installExtraPackages
    Here we install a bunch of other packages that I find to be very useful. See :ref:`additional_packages:`
    for the details of these extra packages. Note that the list includes ``texlive-full``, which may take
    a while to download and install. So if you're in a hurry and don't really need a
    full TeX distribution, then perhaps you might wanna comment it out.
