Vagrant.configure("2") do |config|
  config.vm.box = "debian/bullseye64"

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/playbook-nix.yaml"
  end
end
