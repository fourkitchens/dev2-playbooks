# Four Kitchens: Ubuntu 14.04 Development Server

The Four Kitchens development server uses ansible for using our bespoke development environment as a VM or in the cloud. You have a great amount of configuration options available to you via yml files but by default, after installing the latest virtual box (unless you have mavericks -then use 4.2.22) and the latest version of vagrant you should be only a few steps away from a robust and comprehensive environment.

## Requirements

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](http://downloads.vagrantup.com/)
* [Ansible](http://docs.ansible.com/)
    * [nodesource.node](https://github.com/nodesource/ansible-nodejs-role)
    * [zzet.rbenv](https://galaxy.ansible.com/list#/roles/102)

## Installation

### Local

Start by installing [Homebrew](http://brew.sh/), a package manager for OS X. Additional instructions can be found in the [Homebrew documentation](https://github.com/Homebrew/homebrew/tree/master/share/doc/homebrew#readme).

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Next, install [VirtualBox](https://www.virtualbox.org/wiki/Downloads), the virtualization platform.

    brew cask install virtualbox

Then, install [Vagrant](http://downloads.vagrantup.com/), which creates and configures virtual environments.

    brew cask install vagrant

Optionally, install [Vagrant Manager](http://vagrantmanager.com/) to manage your VMs.

    brew cask install vagrant-manager

The last steps are to install [Ansible](http://docs.ansible.com/intro_installation.html), an automation tool for configuration, deployment and other IT tasks.

    brew install ansible

Two [Ansible Galaxy Roles](https://galaxy.ansible.com/intro) (bundled automation content) are required; [nodesource.node](https://github.com/nodesource/ansible-nodejs-role) and  [zzet.rbenv](https://galaxy.ansible.com/list#/roles/102).

    ansible-galaxy install nodesource.node
    ansible-galaxy install zzet.rbenv

Change directory to where you want to store your project configuration and clone this repository.

    cd ~/projects
    PROJECT_NAME=dev2-playbooks
    git clone git@github.com:fourkitchens/dev2-playbooks.git $PROJECT_NAME
    cd $PROJECT_NAME

Within the project, run a single, magical command:

    vagrant up

The virtual machine will be created and configured for you.

#### Usage

To access the shell, run:

    vagrant ssh

To update your machine, pull the latest within the repository, then run:

    vagrant provision

If you want to customize any of the settings within the playbooks, create a host_vars/vagrant file, with any settings overrides you need.

Ansible Scripts:
--

Ansible deployment scripts, located in the ```deploy``` directory can be used for common deployment tasks. Deployment commands can be run on a development server using the following syntax, however to use them in a Vagrant virtual machine you'll need to use the bash script located below.

    ansible-playbook -i hosts deploy/user-add.yml

Fill out the prompts or include them in the extra-vars ```-e``` argument

    ansible-playbook -i hosts -e="user_name=bender github=fkbender" deploy/user-add.yml

A special bash script is available that makes it possible to run deployment scripts locally.

    ./vagrant-playook deploy/user-add.yml

The following commands will work on the vagrant machine and on the dev server:

### Databases
- Create MySQL database

        ./vagrant-playbook deploy/database/mysql-db-create.yml

### Solr Cores

- Add Solr Core  

        ./vagrant-playbook deploy/solr-cores/solr-core-add.yml

- Delete Solr Core  

        ./vagrant-playbook deploy/solr-cores/solr-core-delete.yml

### Users

- Add User

        ./vagrant-playbook deploy/users/user-add.yml

- Delete User

        ./vagrant-playbook deploy/users/user-delete.yml

The following commands only work on a remote dev server:

### Drupal Sites

- Deploy Drupal dev site

        deploy/drupal-sites/drupal-dev-site-deploy.yml

- Remove Drupal dev site

        deploy/drupal-sites/drupal-dev-site-remove.yml

- Deploy Drupal trunk site

        deploy/drupal-sites/drupal-trunk-site-deploy.yml

- Remove Drupal trunk site

        deploy/drupal-sites/drupal-trunk-site-remove.yml

Dev Server Features
--
In addition to the easy execution of common tasks, and parity between our Development and local environments the playbooks provide a number of features.

### Standard Stuff
* The www folder in your home folder will serve all content in subfolders at easy to use URLs. For example: ```/home/vagrant/www/drupal``` will be available at the URL http://vagrant.drupal.local.dev/ on a vagrant box and http://username.drupal.example.com/ on a dev server.
* All sites created with the deploy scripts have drush aliases created. Try ```drush sa``` from inside the vm to see a list.
* [Xdebug](http://xdebug.org/) is available for PHP debugging.
* [rvm](http://rvm.io/) is used to manage ruby gems.
* [Apache SOLR](https://lucene.apache.org/solr/index.html) cores can be created using the Ansible script or a Jenkin's Job. The core can be used by Drupal at (http://localhost:8888/solr/core_name) and the SOLR admin is available at (http://hostname.tld:8888/solr/core_name/admin)

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

### Remote

* Create a hosts file
* `ansible-playbooks -i hosts playbook.yml`
* Magic.
