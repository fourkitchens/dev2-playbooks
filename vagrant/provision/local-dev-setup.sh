#!/bin/bash

echo ''
echo '======================================================================='
echo 'Running local dev setup...'
cd /home/vagrant/playbooks
ansible-playbook --sudo -c local site.yml
ansible-playbook --sudo -c local vagrant.yml
