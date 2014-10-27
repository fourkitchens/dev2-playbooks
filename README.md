Four Kitchens: Ubuntu 14.04 Development Server
-------------------------------------

Hello and welcome to the Four Kitchens development server README.  This repo uses ansible to allow you to spin up our bespoke development environment as a VM or in the cloud. A list of features is available at the bottom of this document.

You have a great amount of configuration options available to you via yml files but by default, after installing the latest virtual box (unless you have mavericks -then use 4.2.22) and the latest version of vagrant you should be only a few steps away from a robust and comprehensive environment.

## Requirements

* Mac / nix based environment
* Ansible (http://docs.ansible.com/intro_installation.html)
* The following Ansible Galaxy Roles
  * nodesource.node (https://github.com/nodesource/ansible-nodejs-role)
  * zzet.rbenv (https://galaxy.ansible.com/list#/roles/102)

## Use for Vagrant Machine

* Install Vagrant (http://downloads.vagrantup.com/)
* VirtualBox (https://www.virtualbox.org/wiki/Downloads) to your local machine.
* Install Ansible (http://docs.ansible.com/intro_installation.html)
* Install Ansible Galaxy Roles ```ansible-galaxy install nodesource.node zzet.rbenv```
* Clone this repo ```git clone git@github.com:fourkitchens/dev2-playbooks.git```
* Go into the repo ```cd dev2-playbooks```
* run ```vagrant up```

Vagrant and Ansible will then create your machine for you, and provision all of the pieces you need.

To update your machine, pull the latest within the repository, and run ```vagrant provision```.

To then access your machine, run ```vagrant ssh```.



### Troubleshooting Vagrant
* If prompted for your password, that will be your local machine password.
* If you have issues, specifically with "Guest Additions" you may need to install a guest additions package on your local machine.  (see: https://github.com/dotless-de/vagrant-vbguest ``vagrant plugin install vagrant-vbguest``)

### Advanced Vagrant Options
* If you want to customize any of the settings within the playbooks, create a host_vars/vagrant file, with any settings overrides you need.

* After installation you can copy your public key into the vagrant user's .ssh authorized_keys. This will allow you to connect to your VM with your own key (if desired).

* To Change the default file synced folder behavior. Edit ``/home/{user}/{repofolder}/vagrant/VagrantFile``
and change the ``synced_folder`` settings to meet your needs. By default the synced folders
will be mounted using NFS. For users on OSX 10.8+ this is usually sufficient but you can see
all the options for configuring synced folders in the [vagrant documentation](http://docs.vagrantup.com/v2/synced-folders/). Note that any changes you make to this file will be captured as diffs
in git so be sure to stash changes that you don't intend to push upstream if you've alterd
the file and plan to push new features upstream.

## Use for remote machines

* Provision an Ubuntu Trusty Server on your favorite Host.
* Create a inventory file called ```hosts``` (http://docs.ansible.com/intro_inventory.html)
* Run ```ansible-playbooks -i hosts playbook.yml```
* Magic.

Ansible Scripts:
--

Ansible deployment scripts, located in the ```deploy``` directory can be used for common deployment tasks.
```
$ ansible-playbook -i hosts deploy/user-add.yml
```
Fill out the prompts or include them in the extra-vars ```-e``` argument
```
$ ansible-playbook -i hosts -e="user_name=bender github=fkbender" deploy/user-add.yml
```
### Vagrant Ansible Scripts:
To use the Ansible scripts locally use the included ```vagrant-playbook``` command
```
$ bash ./vagrant-playbook deploy/users/user-add.yml
```

### Available Vagrant Scripts

#### Drupal Sites
- Deploy Drupal dev site ```deploy/drupal-sites/drupal-dev-site-deploy.yml```
- Remove Drupal dev site ```deploy/drupal-sites/drupal-dev-site-remove.yml```
- Deploy Drupal trunk site ```deploy/drupal-sites/drupal-trunk-site-deploy.yml```
- Remove Drupal trunk site  ```deploy/drupal-sites/drupal-trunk-site-remove.yml```

#### Solr Cores
- Add Solr Core  ```deploy/solr-cores/solr-core-add.yml```
- Delete Solr Core  ```deploy/solr-cores/solr-core-delete.yml```

#### Users
- Add User ```deploy/users/user-add.yml```
- Delete User ```deploy/users/user-delete.yml```

Dev Server Features
--
In addition to the easy execution of common tasks, and partiy between our Development and local enviroments the playbooks provide a number of features.

### Standard Stuff
* The wwww folder in your home folder will serve all content in subfolders at easy to use URLs. For example: ```/home/vagrant/www/drupal``` will be available at the URL http://vagrant.drupal.local.dev/ on a vagrant box and http://username.drupal.example.com/ on a dev server.
* All sites created with the deploy scripts have drush aliases created. Try ```drush sa``` to see a list.
* [Xdebug](http://xdebug.org/) is available for PHP debugging.
* [rvm](http://rvm.io/) is used to manage ruby gems.

### Multiple Webservers

The dev2 playbooks now install both apache and nginx. This will allow us to more closely emulate Pantheon (nginx+php-fpm), or more common (apache) application server environments. You can switch between the two by sending either a GET argument (``varnish_backend`` by default) or by setting a request header (``X-varnish-backend`` by default).

For example, the following requests would hit the respective servers:

* apache
 * http://fpl.local.dev?varnish_backend=apache
 * http://fpl.local.dev (X-varnish-backend: apache)
* nginx
 * http://fpl.local.dev?varnish_backend=nginx
 * http://fpl.local.dev (X-varnish-backend: nginx)

The default webserver can be set from your settings file before running the playbooks but will be set to apache by default.

Protip: you can use the chrome extension [ModHeader](https://chrome.google.com/webstore/detail/modheader/idgpnmonknjnojddfkpgkljpfnnfcklj) to send custom headers and avoid needing to use GET arguments on every request.

### XHProf

You can utilize XHProf with mongodb xhprof which will provide you with a Drupal interface to view the XHProf results without using devel.
