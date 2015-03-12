Basic Install Summary:
--
* Install Vagrant (http://downloads.vagrantup.com/)
* Install Virtual Box
* Install ansible
* Install the following ansbile galaxy roles
  * zzet.rbenv
* Clone repo
* Run vagrant commands to provision environment.


Basic Set up:
--
A) Install Vagrant

B) Install Virtual Box

C) Install Ansible


C) Clone this Repo in your /home/{user} folder.

    ```
    cd ~
    git clone {repo clone info}
    ```

D) Provision the environment
Go to the vagrant folder within the repo in your terminal:

    ``cd /home/{user}/dev2-playbooks/vagrant``

Type the following in your terminal:


   ``vagrant up``


Following the instructions, if prompted for your password, that will be your local machine password.

If you have issues, specifically with "Guest Additions" you may need to install a guest additions package on your local machine.  (see: https://github.com/dotless-de/vagrant-vbguest ``vagrant plugin install vagrant-vbguest``)

Ansible and virtual box will work together to download your VM image and then install and configure your environment. It will take some time.

Post Set up options:
--
* After installation you can use: "vagrant ssh" to ssh into the box from there you can copy your public key into the vagrant user's .ssh authorized_keys. This will allow you to connect to your VM with your own key (if desired).

Custom Set up:
--
Take a few extra actions on item C above:
C) Clone this Repo in your /home/{user} folder.

    ```
    cd ~
    git clone {repo clone info}
    ```

Provide customized settings (advanced).

Change the default file synced folder behavior. Edit ``/home/{user}/{repofolder}/vagrant/VagrantFile``
and change the ``synced_folder`` settings to meet your needs. By default the synced folders
will be mounted using NFS. For users on OSX 10.8+ this is usually sufficient but you can see
all the options for configuring synced folders in the [vagrant documentation](http://docs.vagrantup.com/v2/synced-folders/). Note that any changes you make to this file will be captured as diffs
in git so be sure to stash changes that you don't intend to push upstream if you've alterd
the file and plan to push new features upstream.

Provide customized settings (advanced). Type the following on your terminal:

  1. Create a custom host vars file called ``development`` in ``/home/{user}/{repofolder}/vagrant/group_vars``
  2. Assign variables as needed for your local host, i.e.

    ```
    ---
    foo: 'bar'
    php_xdebug_remote_enable: 1
    ```

(proceed to step D in Basic Set up)


Ansible Scripts:
--
All Ansible scripts for configuring and doing deployment on dev2.

See: https://fourkitchens.atlassian.net/wiki/display/FK/Dev2+on+Rackspace+Cloud

Deployment Scripts:
--
Deploy a trunk site with the address 'test.webchef2.com':

    ``ansible-playbook --extra-vars="repo=git@github.com:fourkitchens/trainingwheels-drupal-files-example.git domain_name=test.webchef2.com db_name=test db_user=test db_pass=test" drupal-trunk-site-deploy.yml``

Remove the same trunk site:

    ``ansible-playbook --extra-vars="domain_name=test.webchef2.com db_name=test db_user=test" drupal-trunk-site-remove.yml``

Dev site deploy, for user 'mark', name of the site 'test'.

    ``ansible-playbook --extra-vars="repo=git@github.com:fourkitchens/trainingwheels-drupal-files-example.git user_name=mark site_name=test db_name=mark_test db_user=mark_test db_pass=password" drupal-dev-site-deploy.yml``

Dev site remove:

    ``ansible-playbook --extra-vars="user_name=mark site_name=test db_name=mark_test db_user=mark_test" drupal-dev-site-remove.yml``


SOLR core create (in deploy/solr-cores):

    ``ansible-playbook --extra-vars="core_name=test_dd" solr-core-add.yml``

SOLR core remove (in deploy/solr-cores):

    ``ansible-playbook --extra-vars="core_name=test_dd" solr-core-delete.yml``

Drush sync:

    ```
    drush sa
    drush sql-sync @alias-of-main-site
    ```


Multiple Webservers
--
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

XHProf
--
You can utilize XHProf with mongodb xhprof which will provide you with a Drupal interface to view the XHProf results without using devel.


Manual Server How-to Guide (Legacy)
--
### 1) Obtain a fresh, up-to-date Ubuntu 12.04 installation.

### 2) Open a root terminal.

If you are doing this via a VM, and SSH isnt enabled, run this:

    ``sudo apt-get install openssh-server``

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

    ``git@github.com:fourkitchens/dev2-playbooks.git``

(Special note: if you don't have your key either on your VM or have key forwarding enabled, this will fail. It will also fail if you are doing a 'sudo su -' to be root. I fixed this by copying my authorized_keys file to root, and then ssh-ing directly to that.

    ``cp /home/{username}/.ssh/authorized_keys /root/.ssh/``


### 5) Setup the server!

    ```
    cd dev2-playbooks/config/
    ansible-playbook setup.yml
    ```

or:

    ``ansible-playbook --tags="common,..." setup.yml``
