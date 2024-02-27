# Puppet to Ansible

The [create_inventory.rb](./create_inventory.rb) ruby script
parses puppet environments, roles and hosts to generates an Ansible compatible inventory file.

The mapping of the puppet environment to the Ansible inventory is as follows:
For each environment folder, the script will look for a `data/nodes` folder and looks up the role in `data/roles`.
And collects all the variables from the `data/nodes` folder and the `data/roles` folder respectively.

```
environment A
├─ children
│  ├─ role name x
│  │  ├─ hosts
│  │  │  ├─ hostname A
│  │  │  │  ├─ vars
│  │  │  │  │  ├─ puppet::key::host-var-y
│  │  │  │  │  ├─ puppet::key::host-var-z
│  │  │  ├─ hostname B
│  │  │  │  ├─ vars
│  │  │  │  │  ├─ puppet::key::host-var-x
│  │  │  │  │  ├─ puppet::key::host-var-y
│  │  │  │  │  ├─ puppet::key::host-var-z
│  │  ├─ vars
│  │  │  ├─ puppet::key::role-var-x
│  │  │  ├─ puppet::key::role-var-y
│  │  │  ├─ puppet::key::role-var-z
```

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

Put this script in the root of your puppet environments folder, 
then change to the directory and run:

```bash
ruby create_inventory.rb > inventory.yaml
```

A new [inventory.yaml](./inventory.yaml) file will be created.

## What now?

You can use this inventory file to run Ansible playbooks.
