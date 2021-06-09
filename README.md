# Bash setup script for Ubuntu servers

[![Build Status](https://travis-ci.com/engineervix/ubuntu-server-setup.svg?branch=master)](https://travis-ci.com/engineervix/ubuntu-server-setup)
[![last commit](https://badgen.net/github/last-commit/engineervix//ubuntu-server-setup)](https://github.com/engineervix/ubuntu-server-setup/commits/)

> This is a fork of <https://github.com/jasonheecs/ubuntu-server-setup> with additional customization, including
>
>
> - setup Hostname
> - setup ZSH and ohmyzsh
> - install node js and yarn
> - pip + some python packages
> - simple git customization
> - ruby
> - VIM (Janus Distribution)

----

This is a setup script to automate the setup and provisioning of Ubuntu servers, primarily biased towards python web applications. It does the following:

- Adds a new user account with sudo access
- Adds a public ssh key for the new user account
- Disables password authentication to the server
- Deny root login to the server
- Setup Uncomplicated Firewall
- Create Swap file based on machine's installed memory
- Setup the timezone for the server (Default to "Africa/Lusaka")
- Install Network Time Protocol
- Install `ruby`
- Install [`python3-pip`](https://packages.ubuntu.com/focal/python3-pip), [`node`](https://nodejs.org/en/) and [`yarn`](https://yarnpkg.com/)
- Setup **ZSH** and [`oh-my-zsh`](https://ohmyz.sh) with the [`powerlevel10k` theme](https://github.com/romkatv/powerlevel10k)
- Setup [Janus](https://github.com/carlhuda/janus) -- a Vim Distribution designed to provide minimal working environment using the most popular plugins and the most common mappings.

## Installation

SSH into your server, update package list and upgrade packages:

> if git isn't installed, install it via `sudo apt-get install git`

```bash
apt-get update && apt-get upgrade -y
```

Clone this repository (& submodules) into your home directory, and run the setup script:

```bash
cd ~
git clone --recurse-submodules https://github.com/engineervix/ubuntu-server-setup.git \
&& cd ubuntu-server-setup \
&& bash setup.sh
```

## Setup prompts

⌨️ When the setup script is run, you will be prompted to enter the username and password of the new user account, as well as Global Git Name and Email Address.

⌨️ Following that, you will then be prompted to add a public ssh key (which should be from your local machine) for the new account. To generate an ssh key from your local machine:

```bash
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub
```

⌨️ You will further be prompted to specify a [timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) for the server. It will be set to 'Africa/Lusaka' if you do not specify a value.

⌨️ You will also be asked to provide a `hostname` for your server.

⌨️ When setting up Postfix and configuring System Updates and Notification Settings, you'll be asked for

- the System Administrator's email address (to **receive** notifications)
- the email address that'll be associated with **send**ing emails. This setup uses [Sendgrid](https://sendgrid.com/), so you need to use a Sendgrid verified email address for this.

⌨️ You will also have to specify some folder names for

- projects directory
- backup directory
- temporary files directory.

⌨️ Towards the end, you might be asked for your password when the script attempts to change the default shell to ZSH as the newly created user.

## Post setup actions

- Reboot and login as the new user
- configure rclone, backup scripts and cron jobs for daily backups
- setup [certbot-dns-cloudflare](https://certbot-dns-cloudflare.readthedocs.io/) plugin and ensure that your SSL certificates automatically renew
- incorporate [Healthchecks.io](https://healthchecks.io/) in your cron jobs
- update `TINYPNG_API_KEY` and `SENDGRID_API_KEY` in `.zshrc`
- setup your projects and deploy

## Supported versions

The upstream version of this setup script has been tested against Ubuntu 14.04, Ubuntu 16.04, Ubuntu 18.04 and Ubuntu 20.04. However, this fork only been tested on:

- official **AWS** Ubuntu 20.04 AMIs (Amazon EC2 Instances)
- Ubuntu 20.04 droplets on **DigitalOcean**

Feel free to try it on Linode and other providers, and see if it works out of the box without any issues. Would appreciate any feedback.

### Important Note

By default, the `master` branch is designed for installation on DigitalOcean's droplets. If you would like to run this on AWS without problems, you might wanna make a few modifications based on the `AWS` branch.

> **The main difference(s) between AWS setup and DigitalOcean setup**:
>
> - **Default user**: on DigitalOcean, the default user is root, while on AWS, the default user is ubuntu. This affects how certain things are installed, for instance, [Janus](https://github.com/carlhuda/janus)
> - **Hostname setup**. on DigitalOcean, you can define the hostname when creating the droplet, and a lot of associated settings come preconfigured. On AWS, this has to be done manually. In this script, the `setupHostname()` function is executed only when installing on AWS. It is totally ignored when installing on a DigitalOcean Droplet.

## Running tests

Tests are run against a set of Vagrant VMs. To run the tests, run the following in the project's directory:  

`./tests/tests.sh`

----

## TODO

- [X] Setup Postfix
- [X] Setup `virtualenvwrapper`
- [X] automatic updates and system notifications (logs, etc.)
- [X] setup nginx
- [X] setup uWSGI
- [ ] Further server hardening to quench any lurking paranoia 🕵🏿‍♀️💣🧨
- [ ] Update this README to reflect all important changes I made on June 8 2021 to make this more robust and automate a bunch of mundane tasks
- [ ] setup [pyenv](https://github.com/pyenv/pyenv-installer)
- [ ] Fix broken tests

## References

### security

- <https://linux-audit.com/ubuntu-server-hardening-guide-quick-and-secure/>
- <https://www.ubuntu.com/security>
- <https://www.ncsc.gov.uk/guidance/eud-security-guidance-ubuntu-1804-lts>
- <https://www.digitalocean.com/community/questions/best-practices-for-hardening-new-sever-in-2017>
