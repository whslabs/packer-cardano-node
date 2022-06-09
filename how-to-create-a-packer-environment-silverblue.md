# How to create a packer environment (Silverblue)

# Install virtualization (Silverblue)
```sh
rpm-ostree install \
  libguestfs-tools \
  libvirt-daemon-config-network \
  libvirt-daemon-kvm \
  qemu-kvm \
  virt-install \
  virt-manager \
  virt-viewer \
  ;
```

# Create a Debian 11 VM
```sh
(
name=packer
curl -o preseed.cfg https://www.debian.org/releases/bullseye/example-preseed.txt
cat <<EOF >> preseed.cfg
d-i grub-installer/bootdev string default
d-i netcfg/get_hostname string debian11-$name
d-i passwd/root-login boolean false
d-i passwd/user-fullname string whs
d-i passwd/user-password password magic
d-i passwd/user-password-again password magic
d-i passwd/username string whs
d-i preseed/late_command string apt-install openssh-server
popularity-contest popularity-contest/participate boolean false
tasksel tasksel/first multiselect standard
EOF
virt-install \
  --disk size=20 \
  --initrd-inject preseed.cfg \
  --location https://deb.debian.org/debian/dists/bullseye/main/installer-amd64/ \
  --memory 2048 \
  --name debian11-$name \
  --network=bridge:virbr0 \
  --os-variant debian11 \
  --vcpus 2 \
  ;
)
```

# Install cguv (Debian 11)
```sh
sudo apt-get install -y \
  curl \
  git \
  unzip \
  vim \
  ;
```

# Install pip (Debian 11)
```sh
sudo apt-get install -y python3-distutils
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
echo 'export PATH=$PATH:$HOME/.local/bin' >> ~/.bashrc
source ~/.bashrc
```

# Install ansible
```sh
pip install --upgrade ansible
```

# Install packer
https://www.packer.io/downloads
```sh
cat <<EOF > install_packer.yaml
- name: Installer
  hosts: all
  tasks:
  - become: "yes"
    name: Install packer
    unarchive:
      creates: /usr/local/bin/packer
      dest: /usr/local/bin/
      remote_src: "yes"
      src: |-
        https://releases.hashicorp.com/packer/{{ version }}/packer_{{ version }}_linux_amd64.zip
EOF
ansible-playbook -ilocalhost, -clocal -eversion=1.8.1 install_packer.yaml -K
```
