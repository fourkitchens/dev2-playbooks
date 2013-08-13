Dev2: Ubuntu 12.04 Development Server
-------------------------------------

All Ansible scripts for configuring and doing deployment on dev2.

See: https://fourkitchens.atlassian.net/wiki/display/FK/Dev2+on+Rackspace+Cloud

## Using Vagrant

### 1) Install the latest Vagrant and VirtualBox.

### 2) Clone this Repo and then Modify the vagrant settings file within this repo.

Copy the vagrant/vagrants-settings.yml file to vagrant/settings.yml

In the repo's vagrant/settings.yml:
* Set the hostname correctly, for example local.dev.
* Set memory requirements, etc.

In etc/hosts:
* Add your new hostname with the IP address you find in vagrant/VagrantFile

### 3) Start vagrant

    vagrant up

## Using deploy scripts

Deploy a trunk site with the address 'test.webchef2.com':

    ansible-playbook --extra-vars="repo=git@github.com:fourkitchens/trainingwheels-drupal-files-example.git domain_name=test.webchef2.com db_name=test db_user=test db_pass=test" drupal-trunk-site-deploy.yml

Remove the same trunk site:

    ansible-playbook --extra-vars="domain_name=test.webchef2.com db_name=test db_user=test" drupal-trunk-site-remove.yml

Dev site deploy, for user 'mark', name of the site 'test'.

    ansible-playbook --extra-vars="repo=git@github.com:fourkitchens/trainingwheels-drupal-files-example.git user_name=mark site_name=test db_name=mark_test db_user=mark_test db_pass=password" drupal-dev-site-deploy.yml

Dev site remove:

    ansible-playbook --extra-vars="user_name=mark site_name=test db_name=mark_test db_user=mark_test" drupal-dev-site-remove.yml


SOLR core create (in deploy/solr-cores):

    ansible-playbook --extra-vars="core_name=test_dd" solr-core-add.yml

SOLR core remove (in deploy/solr-cores):

    ansible-playbook --extra-vars="core_name=test_dd" solr-core-delete.yml
    
Drush sync:

    drush sa
    drush sql-sync @alias-of-main-site

## Manual Server How-to Guide

### 1) Obtain a fresh, up-to-date Ubuntu 12.04 installation.

### 2) Open a root terminal.

If you are doing this via a VM, and SSH isnt enabled, run this:

    sudo apt-get install openssh-server

### 3) Install and setup Ansible:

Install full release.

```
aptitude -y install git python-jinja2 python-yaml python-paramiko python-software-properties
add-apt-repository -y ppa:rquillo/ansible/ubuntu
aptitude update
aptitude install ansible
echo "localhost" > /etc/ansible/hosts
```

Install dev release.
```
mkdir /usr/local/src/ansible
git clone https://github.com/ansible/ansible.git /usr/local/src/ansible
cd /usr/local/src/ansible
git checkout devel
aptitude install build-essential
make install
echo "localhost" > /etc/ansible/hosts
```

### 4) Grab the repository

    git@github.com:fourkitchens/dev2-playbooks.git

(Special note: if you don't have your key either on your VM or have key forwarding enabled, this will fail. It will also fail if you are doing a 'sudo su -' to be root. I fixed this by copying my authorized_keys file to root, and then ssh-ing directly to that.

    cp /home/{username}/.ssh/authorized_keys /root/.ssh/


### 5) Setup the server!

    cd dev2-playbooks/config/
    ansible-playbook setup.yml

or:

    ansible-playbook --tags="common,..." setup.yml
