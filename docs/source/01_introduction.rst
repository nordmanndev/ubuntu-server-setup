.. _intro:

Introduction
=============

You have finished developing your awesome web application -- everything works
perfectly on your computer, but you now need to put it out there so that
others can use it and enjoy it. For Python web applications, moving from
development to production can be quite a daunting task, especially given the
fact that there are `many options available <https://mattsegal.dev/django-prod-architectures.html>`_.

Well, the "traditional" approach to deploying web applications is to use a
GNU/Linux server in "the cloud". This entails

* setting up a GNU/Linux server (`Digital Ocean <https://www.digitalocean.com/>`_,
  `Linode <https://www.linode.com/>`_, `AWS EC2 <https://aws.amazon.com/ec2/>`_, etc.),
  preferably using the latest Ubuntu LTS version.
* Securing your server
* Installing and configuring `Nginx <https://www.nginx.com/>`_, `PostgreSQL <https://www.postgresql.org/>`_,
  `uWSGI <https://uwsgi-docs.readthedocs.io/en/latest/>`_/`Gunicorn <https://gunicorn.org/>`_, `Redis <https://redis.io/>`_,
  `Certbot <https://certbot.eff.org/>`_ and any other dependencies

As a developer, you don't want to spend so much time configuring servers instead
of focusing on building your application. Because setting up servers can be a
tedious task, it is better to automate this process. Again, there are so many approaches
towards automation of infrastructure deployments (e.g. `Ansible <https://www.ansible.com/>`_,
`Salt <https://saltproject.io/>`_, `Chef <https://www.chef.io/>`_,
`Puppet <https://puppet.com/>`_, `Terraform <https://www.terraform.io/>`_,
`Docker <https://docs.docker.com/engine/swarm/>`_, `Kubernetes <https://kubernetes.io/>`_, etc.), 
these have been evolving over the years, and continue to evolve.

A good old approach is simply writing a bash script to bootstrap your server and
get things up and running quickly. Rather than starting something completely new,
why not check what others have done and see if you could find something to use?
Well, this is what I did, and I stumbled upon
`Jason Hee's awesome setup script <https://github.com/jasonheecs/ubuntu-server-setup>`_.

Jason Hee's setup script automates the setup and provisioning of Ubuntu servers.
According to the project's README, it does the following:

* Adds a new user account with sudo access
* Adds a public ssh key for the new user account
* Disables password authentication to the server
* Deny root login to the server
* Setup Uncomplicated Firewall
* Create Swap file based on machine's installed memory
* Setup the timezone for the server (Default to "Asia/Singapore")
* Install Network Time Protocol

This provides an excellent starting point for provisioning Ubuntu Servers. 
I decided to fork the project and build on top of this strong foundation
to develop a heavily opinionated setup for **deploying python web applications**. 
The idea is to be able to quickly setup a Linux box and deploy a
Python web application without much of a hassle.

In the next section, I will highlight the additional features that I introduced
and the rationale behind them.