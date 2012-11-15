Dev2: Ubuntu 12.04 Development Server
-------------------------------------

Deployment tasks.

Usage
-----

Deploy a trunk site with the address 'test.webchef2.com':

    ansible-playbook --extra-vars="repo=git@github.com:fourkitchens/trainingwheels-drupal-files-example.git domain_name=test.webchef2.com db_name=test db_user=test db_pass=test" drupal-trunk-site-deploy.yml

Remove the same trunk site:

    ansible-playbook --extra-vars="domain_name=test.webchef2.com db_name=test db_user=test" drupal-trunk-site-remove.yml

Dev site deploy, for user 'mark', name of the site 'test'.

    ansible-playbook --extra-vars="repo=git@github.com:fourkitchens/trainingwheels-drupal-files-example.git user_name=mark site_name=test db_name=mark_test db_user=mark_test db_pass=password" drupal-dev-site-deploy.yml

Dev site remove:

    ansible-playbook --extra-vars="user_name=mark site_name=test db_name=mark_test db_user=mark_test" drupal-dev-site-remove.yml

Drush sync:

drush sa
drush sql-sync @alias-of-main-site
