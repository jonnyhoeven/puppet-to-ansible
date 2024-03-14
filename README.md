# Puppet to Ansible

This Ruby script can be used to create new Ansible inventories from YAML files in Puppet repository filesystems.

Reads YAML files from the `data/nodes` and `data/roles` directories for each environment,
and builds `inv` representing your updated Ansible inventory.

The [create_inventory.rb](./create_inventory.rb) ruby script parses puppet environment filesystems and converts 
each role and host file to a single Ansible compatible inventory file.

## Requirements

### Ruby script

- Ruby is included in any modern Linux distribution.

```bash
sudo apt install ruby
```

- If you're using Windows, you can install Ruby from [rubyinstaller.org](https://rubyinstaller.org/).

- All Puppet agents include [Ruby](https://www.ruby-lang.org/en/)
  The Ruby runtime environment on Puppet includes the Ruby language, some Ruby libraries and a set
  of Puppet specific gems.

## Usage

Put this script in the root of your puppet environments folder, 
then change to the directory and run:

```bash
ruby create_inventory.rb > inventory.yaml
```

A new [inventory.yaml](./inventory.yaml) file will be created.

## What now?

You can use this inventory file to run Ansible playbooks on your environments, roles and nodes.
