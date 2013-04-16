#!/bin/bash

echo ''
echo '======================================================================='
echo 'Copying the settings files for the controller playbooks...'
cp /home/vagrant/playbooks/vagrant/vagrant-settings.yml /home/vagrant/playbooks/config/settings.yml

echo ''
echo '======================================================================='
echo 'Running local dev setup...'
cd /home/vagrant/playbooks/config
ansible-playbook --sudo -c local setup.yml
