Dev2: Ubuntu 12.04 Development Server
-------------------------------------

All Ansible scripts for configuring and doing deployment on dev2.

See: https://fourkitchens.atlassian.net/wiki/display/FK/Dev2+on+Rackspace+Cloud


## The How-to Guide (Because I keep re-doing this)

1. Obtain a fresh, up-to-date Ubuntu 12.04 installation.

2. Open a root terminal.
    * If you are doing this via a VM, and SSH isnt enabled, run this:
    ``` sudo apt-get install openssh-server```

3. Install and setup Ansible:

  * ```
  aptitude -y install git python-jinja2 python-yaml python-paramiko python-software-properties
  add-apt-repository -y ppa:rquillo/ansible/ubuntu
  aptitude update
  aptitude install ansible
  echo "localhost" > /etc/ansible/hosts
  ```

4. Grab the repository

  * ```
  git@github.com:fourkitchens/dev2-playbooks.git
  ```
  * (Special note: if you don't have your key either on your VM or have key forwarding enabled, this will fail. It will also fail if you are doing a 'sudo su -' to be root. I fixed this by copying my authorized_keys file to root, and then ssh-ing directly to that.
  * ```cp /home/{username}/.ssh/authorized_keys /root/.ssh/```

5. Setup the server!

  * ```
  cd dev2-playbooks/config/
  ansible-playbook setup.yml
  ```

6. Use the development version!

  * So, currently Ansible is v. 1.0. I want to do things that use 1.1, how do I do that? Simple! From your root directory:
  * ```
  git clone git://github.com/ansible/ansible.git
  $ cd ./ansible
  $ source ./hacking/env-setup
  ```

