Contributing
============

Contributions of any kind welcome! 🎉

When contributing to
`ubuntu-server-setup <https://github.com/engineervix/ubuntu-server-setup>`__,
please first create an
`issue <https://github.com/engineervix/ubuntu-server-setup/issues>`__ to
discuss the change you wish to make before making a change.

Before making a pull request
----------------------------

.. note::

   This repo uses some Node.js-based tools
   (`commitizen <https://github.com/commitizen/cz-cli>`__ and
   `standard-version <https://github.com/conventional-changelog/standard-version>`__)
   as part of the dev workflow. So, before you proceed, you’ll need to
   ensure that `Node.js <https://nodejs.org>`__ is installed on your
   machine, and you are able to use ``npm`` to install Node.js packages

1. First, install the
   `Commitizen <https://github.com/commitizen/cz-cli>`__ cli tool if you
   don’t already have it on your system:
   ``sudo npm install commitizen -g``
2. Fork `the
   repository <https://github.com/engineervix/ubuntu-server-setup>`__.
3. Clone the repository from your GitHub.
4. Run ``npm install`` to install local Node.js packages
5. Update ``.git/hooks/prepare-commit-msg`` with the following code:

.. code:: bash

   #!/bin/bash
   exec < /dev/tty && node_modules/.bin/cz --hook || true

6.  Check out a new branch and add your modification.
7.  Run `shellcheck <https://www.shellcheck.net/>`__:
    ``npm run shellcheck`` and ensure that it completes with an
    ``exit 0`` status. If your changes have introduced some warnings,
    please try and address them. If you have good reason to ignore some
    of them, then mention this in the “longer description” portion of
    your commit.
8.  Update ``README.md`` for your changes.
9.  Commit your changes via ``git commit``, following the prompts to
    appropriately categorize your commit.
10. Send a `pull
    request <https://github.com/engineervix/ubuntu-server-setup/pulls>`__
    🙏
