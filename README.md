Dev2: Ubuntu 12.04 Development Server
-------------------------------------


Make some configuration changes to the playbooks
--
Copy your public key to the vagrant user -
cp ~/.ssh/id_rsa.pub ~/dev2-playbooks/roles/common/files/home/vagrant/.ssh/authorized_keys
go to roles/common/files/home/vagrant/.ssh/

Copy the file roles/common/vars/example.txt to roles/common/var/main.yml

cd vagrant

type: vagrant up

When prompted for the password by your cli - please use your machine password.

(possibly adjust your mongo_db_restart)

All Ansible scripts for configuring and doing deployment on dev2.

See: https://fourkitchens.atlassian.net/wiki/display/FK/Dev2+on+Rackspace+Cloud

## Using Vagrant

### 1) Install the latest Vagrant (http://downloads.vagrantup.com/) and VirtualBox (https://www.virtualbox.org/wiki/Downloads).

### 2) Clone this Repo in your home/{user} folder.

### 3) If you need specific settings - other than the defaults, copy the file at roles/common/vars/example.txt to roles/common/vars/main.yml and make any needed changes.

### 4) Start vagrant

    vagrant up

### 5) After vagrants starts you can use: "vagrant ssh" to ssh into the box from there you can copy your public key into the vagrant user's .ssh authorized_keys.

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

## Multiple Webservers

The dev2 playbooks now install both apache and nginx. This will allow us to more closely emulate Pantheon (nginx+php-fpm), or more common (apache) application server environments. You can switch between the two by sending either a GET argument (```varnish_backend``` by default) or by setting a request header (```X-varnish-backend``` by default).

For example, the following requests would hit the respective servers:

* apache
 * http://fpl.local.dev?varnish_backend=apache
 * http://fpl.local.dev (X-varnish-backend: apache)
* nginx
 * http://fpl.local.dev?varnish_backend=nginx
 * http://fpl.local.dev (X-varnish-backend: nginx)

The default webserver can be set from your settings file before running the playbooks but will be set to apache by default.

Protip: you can use the chrome extension [ModHeader](https://chrome.google.com/webstore/detail/modheader/idgpnmonknjnojddfkpgkljpfnnfcklj) to send custom headers and avoid needing to use GET arguments on every request.

## XHProf

XHProf is available for your use on the server; however, there is a little bit of config that
you'll need to do if you're using it with Drupal.

1. Download the latest XHProf [source](https://github.com/facebook/xhprof/archive/master.zip dest=/tmp/master.zip) to ~/www.
1. In your Drupal site's devel settings set the XHProf path to /home/YOU/www/xhprof-master and the
site to http://xhprof-master.local.dev (if working locally).

