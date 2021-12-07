Roadmap
=======

The upstream version of this setup script has been tested against Ubuntu 14.04, Ubuntu 16.04, Ubuntu 18.04 and Ubuntu 20.04.
However, this fork primarily targets **Ubuntu 20.04**, and has only been tested on:

* official **AWS** Ubuntu 20.04 AMIs (Amazon EC2 Instances)
* Ubuntu 20.04 droplets on **DigitalOcean**
* Ubuntu 20.04 cloud servers on **Hetzner**

As the author, naturally, I will focus only on select cloud providers of interest, as I do not have the time to test
on all the various platforms. If you have used this script on Azure, or GCP or vultr, Linode, etc, please share some
feedback so that we know how things went!

For now, the focus is on 

* fixing bugs whenever they are spotted
* adding minor features where necessary, with a focus on having a robust and secure server
* seeking to find ways to speed up the setup by minimizing manual input

In the `TODO section of the README on GitHub <https://github.com/engineervix/ubuntu-server-setup#todo>`_, you'll probably find a concrete list of things that need to be done. If you find this project useful, please help improve it by contributing your code! 

.. admonition:: The bottomline
   :class: important

   The idea is to ensure that the script **always works** on the *latest Ubuntu LTS release*.