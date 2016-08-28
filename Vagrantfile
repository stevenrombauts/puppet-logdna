machines = {
    :'centos66' => { :memory => '256', :ip => '10.1.2.10', :box => 'puppetlabs/centos-6.6-64-puppet',   :domain => 'logdna.local' },
    :'centos72' => { :memory => '256', :ip => '10.1.2.11', :box => 'puppetlabs/centos-7.2-64-puppet',   :domain => 'logdna.local' },
    :'trusty'   => { :memory => '256', :ip => '10.1.2.20', :box => 'puppetlabs/ubuntu-14.04-64-puppet', :domain => 'logdna.local' },
    :'xenial'   => { :memory => '256', :ip => '10.1.2.22', :box => 'puppetlabs/ubuntu-16.04-64-puppet', :domain => 'logdna.local' },
    :'squeeze'  => { :memory => '256', :ip => '10.1.2.30', :box => 'puppetlabs/debian-6.0.9-64-puppet', :domain => 'logdna.local' },
    :'wheezy'   => { :memory => '256', :ip => '10.1.2.31', :box => 'puppetlabs/debian-7.5-64-puppet',   :domain => 'logdna.local' }
}

Vagrant.configure("2") do |config|
  machines.each_pair do |name, opts|
      config.vm.define name do |machine|
          config.vm.provider :virtualbox do |vb|
              vb.customize ["modifyvm", :id, "--memory", opts[:memory] ]
              vb.customize ["modifyvm", :id, "--name", "#{name}" + "." + opts[:domain]]
          end

          machine.vm.network "private_network", ip: opts[:ip]
          machine.vm.box = opts[:box]
          machine.vm.host_name = "#{name}" + "." + opts[:domain]
          machine.vm.synced_folder "./", "/opt/puppetlabs/puppet/modules/logdna"

          machine.vm.provision :shell, :inline => "gem install puppet facter --no-ri --no-rdoc" if name == "trusty"
          machine.vm.provision :shell, :inline => "puppet module install puppetlabs-stdlib --modulepath=/opt/puppetlabs/puppet/modules/"
          machine.vm.provision :shell, :inline => "puppet module install puppetlabs-apt --modulepath=/opt/puppetlabs/puppet/modules/"

          machine.vm.provision :puppet do |puppet|
            puppet.environment_path = "environments"
            puppet.environment = "tests"
          end
      end
  end
end