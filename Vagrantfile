# -*- mode: ruby -*-
# vi: set ft=ruby :

HOSTNAME = "local.dev"
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define :vagrant do |dev_config|

    dev_config.ssh.forward_agent = true

    dev_config.vm.box = "ubuntu/trusty64"
    dev_config.vm.hostname = HOSTNAME

    # VirtualBox specific configuration.
    dev_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
    end

    # Synced Folders.
    dev_config.vm.network :private_network, ip: "10.1.0.10"
    dev_config.vm.synced_folder "~/www", "/home/vagrant/www",
      create: true,
    # Choose a synced folder type and make sure it is uncommented below.
    # - NFS: This is supported on Mac. Linux and Windows may have issues.
    # - VirtualBox: This is supported on all systems if you are using VirtualBox
    #   as the provider.
    #   NOTE: You will want to disable sendfile in Nginx and Apache config.
    #   http://docs.vagrantup.com/v2/synced-folders/virtualbox.html
    ########## UNCOMMENT A SINGLE TYPE BELOW. #####################
      type: "nfs"
    #  type: "virtualbox"

    # Sync individual directories (for a single Drupal site, for instance) using
    # rsync instead instead of NFS or vboxfs. Uncomment and modify to your
    # needs. Once the initial sync is completed you will need to run
    # "vagrant rsync-auto" when editing files locally.
    # https://docs.vagrantup.com/v2/synced-folders/rsync.html
    ########## UNCOMMENT BELOW. #####################
    #dev_config.vm.synced_folder "~/www/{directory}", "/home/vagrant/www/{directory}",
    #  type: "rsync", rsync__exclude: ".git/"


    dev_config.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbooks.yml"
      ansible.groups = {
        "vagrant" => ["vagrant"],
      }
      # Hint: If you want to test playbooks from a certin task
      # use the following pattern.
      #ansible.start_at_task = "Imagemagick | Download sources"
    end

    if Vagrant.has_plugin?("vagrant-dnsmasq")
      # set domain ending (required)
      # adding this line enables dnsmasq handling
      config.dnsmasq.domain = '.dev'
      # this plugin runs 'hostname -I' on the guest machine to obtain
      # the guest ip address. you can overwrite this behaviour.
      config.dnsmasq.ip = '127.0.0.1'
      # overwrite default location for /etc/dnsmasq.conf
      brew_prefix = '/usr/local'
      dev_config.dnsmasq.dnsmasqconf = brew_prefix + '/etc/dnsmasq.conf'

      # command for reloading dnsmasq after config changes
      dev_config.dnsmasq.reload_command = 'sudo launchctl unload /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist; sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist'
    end

    # Load a local setup file if it exists, so you can use it to
    # provide additional provisioning steps.
    if File.exist?(File.join(File.dirname(__FILE__), "setup.local.sh"))
      dev_config.vm.provision :shell, :path => "setup.local.sh"
    end
  end
end
