# Four Kitchens: Ubuntu 14.04 Development Server

The Four Kitchens development server uses ansible for using our bespoke development environment as a VM or in the cloud. You have a great amount of configuration options available to you via yml files but by default, after installing the latest virtual box (unless you have mavericks -then use 4.2.22) and the latest version of vagrant you should be only a few steps away from a robust and comprehensive environment.

## Requirements

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](http://downloads.vagrantup.com/)
* [Ansible](http://docs.ansible.com/)
    * [nodesource.node](https://github.com/nodesource/ansible-nodejs-role)
    * [zzet.rbenv](https://galaxy.ansible.com/list#/roles/102)

## Installation

### Local (OS X)

Start by installing [Homebrew](http://brew.sh/), a package manager for OS X. Additional instructions can be found in the [Homebrew documentation](https://github.com/Homebrew/homebrew/tree/master/share/doc/homebrew#readme).

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Next, install [VirtualBox](https://www.virtualbox.org/wiki/Downloads), the virtualization platform.

    brew cask install virtualbox

Then, install [Vagrant](http://downloads.vagrantup.com/), which creates and configures virtual environments.

    brew cask install vagrant

Optionally, install [Vagrant Manager](http://vagrantmanager.com/) to manage your VMs.

    brew cask install vagrant-manager

Next, install [Ansible](http://docs.ansible.com/intro_installation.html), an automation tool for configuration, deployment and other IT tasks.

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

### Local (Linux)

Install [VirtualBox](https://www.virtualbox.org/wiki/Linux_Downloads), the virtualization platform.

Then, install [Vagrant](https://www.vagrantup.com/downloads.html), which creates and configures virtual environments. Must be version 1.5.* or greater. Do not use the version provided by apt-get as it is not supported.

Next, install [Ansible](http://docs.ansible.com/intro_installation.html), an automation tool for configuration, deployment and other IT tasks.

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

_Pro Tip:_ If you have trouble mounting shared folders with NFS, which is a [known issue](http://serverfault.com/questions/200759/exportfs-warning-home-user-share-does-not-support-nfs-export) for directories encrypted with ecryptfs, see the VagrantFile at the root of this repository for alternative options.

#### Usage

To access the shell, run:

    vagrant ssh

To update your machine, pull the latest within the repository, then run:

    vagrant provision

If you want to customize any of the settings within the playbooks, create a host_vars/vagrant file, with any settings overrides you need.

### Remote

* Create a hosts file
* `ansible-playbooks -i hosts playbook.yml`
* Magic.
