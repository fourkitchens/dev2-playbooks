#!/bin/bash

echo ''
echo '======================================================================='
echo 'Running local dev setup...'
cd /home/vagrant/playbooks/config
ansible-playbook --sudo -c local setup.yml
