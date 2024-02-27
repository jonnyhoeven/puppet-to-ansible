# Create Ansible Inventory

The [create_inventory.rb](./create_inventory.rb) ruby script
parses puppet roles, profile files and generates an Ansible inventory file.

## Requirements

### Ruby script

Ruby is included in any modern Linux distribution.

```bash
sudo apt install ruby
```

If you're using Windows, you can install Ruby from [rubyinstaller.org](https://rubyinstaller.org/).

All Puppet agents include [Ruby AIO](https://community.theforeman.org/t/puppet-s-aio-packages-and-smart-proxy/4711)
which is a Ruby runtime environment that includes the Ruby language, the Puppet libraries, and a set of Puppet-specific
gems.

## Usage

Put this script in the root of your puppet environments, change to the directory and run:

```bash
ruby create_inventory.rb > inventory.yaml
```

A new [inventory.yaml](./inventory.yaml) file will be created.

## What now?

You can use this inventory file to run Ansible playbooks.
