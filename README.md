# Bash setup script for Ubuntu servers

[![Build Status](https://travis-ci.com/github/engineervix/ubuntu-server-setup.svg?branch=master)](https://travis-ci.org/engineervix/ubuntu-server-setup)

> This is a fork of <https://github.com/jasonheecs/ubuntu-server-setup> with additional customization especially targetted towards AWS AMIs
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

This is a setup script to automate the setup and provisioning of Ubuntu servers. It does the following:

- Adds a new user account with sudo access
- Adds a public ssh key for the new user account
- Disables password authentication to the server
- Deny root login to the server
- Setup Uncomplicated Firewall
- Create Swap file based on machine's installed memory
- Setup the timezone for the server (Default to "Africa/Lusaka")
- Install Network Time Protocol
- Setup **ruby** using [`rbenv`](https://github.com/rbenv/rbenv)
- Install [`python3-pip`](https://packages.ubuntu.com/focal/python3-pip), [`node`](https://nodejs.org/en/) and [`yarn`](https://yarnpkg.com/)
- Setup **ZSH** and [`oh-my-zsh`](https://ohmyz.sh) with the [`powerlevel10k` theme](https://github.com/romkatv/powerlevel10k)
- Setup [Janus](https://github.com/carlhuda/janus) -- a Vim Distribution designed to provide minimal working environment using the most popular plugins and the most common mappings.

## Installation

SSH into your server, update package list and upgrade packages:

> if git isn't installed, install it via `sudo apt-get install git`

```bash
sudo apt-get update && sudo apt-get upgrade -y
```

Clone this repository (& submodules) into your home directory, and run the setup script:

```bash
cd ~
git clone --recurse-submodules https://github.com/engineervix/ubuntu-server-setup.git \
&& cd ubuntu-server-setup \
&& bash setup.sh
```

## Setup prompts

When the setup script is run, you will be prompted to enter the username and password of the new user account, as well as Global Git Name and Email Address.

Following that, you will then be prompted to add a public ssh key (which should be from your local machine) for the new account. To generate an ssh key from your local machine:

```bash
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub
```

You will further be prompted to specify a [timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) for the server. It will be set to 'Asia/Singapore' if you do not specify a value.

You will also be asked to provide a `hostname` for your server.

Finally, you might be asked for your password towards the end when the script attempts to change the default shell to ZSH as the newly created user.

## Post setup actions

- Reboot and login as the new user
- change default shell to ZSH (if ZSH isn't already default)
- delete the `ubuntu` account and all associated files.

```sh
chsh -s $(which zsh) \
&& sudo userdel -r ubuntu
```

## Supported versions

The upstream version of this setup script has been tested against Ubuntu 14.04, Ubuntu 16.04, Ubuntu 18.04 and Ubuntu 20.04. However, this fork only been tested on an official AWS Ubuntu 20.04 AMI.

## Running tests

Tests are run against a set of Vagrant VMs. To run the tests, run the following in the project's directory:  

`./tests/tests.sh`

----

## TODO

- [ ] Further server hardening
- [ ] Setup Postfix
- [ ] automatic updates and system notifications (logs, etc.)

### references

#### security

- <https://linux-audit.com/ubuntu-server-hardening-guide-quick-and-secure/>
- <https://www.ubuntu.com/security>
- <https://www.ncsc.gov.uk/guidance/eud-security-guidance-ubuntu-1804-lts>
- <https://www.digitalocean.com/community/questions/best-practices-for-hardening-new-sever-in-2017>
