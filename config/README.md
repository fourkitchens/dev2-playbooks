Dev2: Ubuntu 12.04 Development Server
-------------------------------------

Use `ansible-playbook setup.yml` to run all the tags, otherwise directly run the parts you
need using:

    ansible-playbook --tags="common,..." setup.yml

Tags:

    +--------------------------------------------------------------+
    | css-tools   | SASS, Susy, Compass, Respond-to                |
    +--------------------------------------------------------------+
    | dotcloud    | CLI for working with dotcloud hosting          |
    +--------------------------------------------------------------+
    | drush       | Drupal shell.                                  |
    +--------------------------------------------------------------+
    | etckeeper   | Store /etc in git repo                         |
    +--------------------------------------------------------------+
    | lamp        | Apache, MySQL, APC cache, PHP.                 |
    +--------------------------------------------------------------+
    | tty         | Remove extra tty terminals                     |
    +--------------------------------------------------------------+
    | memcache    | memcache daemon and PHP extension              |
    +--------------------------------------------------------------+
    | motd        | Message of the day                             |
    +--------------------------------------------------------------+
    | sendmail    | Mailing daemon                                 |
    +--------------------------------------------------------------+
    | nodejs      | node.js and npm (latest from ppa)              |
    +--------------------------------------------------------------+
    | redis       | redis server                                   |
    +--------------------------------------------------------------+
    | users       | Bender user config                             |
    +--------------------------------------------------------------+
    | redis       | redis server                                   |
    +--------------------------------------------------------------+
    | ssh         | SSH configuration                              |
    +--------------------------------------------------------------+

