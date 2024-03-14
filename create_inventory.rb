# This script is used to create your Ansible inventory from YAML files in puppet filesystems.
# It reads YAML files from the `data/nodes` and `data/roles` directories of each environment,
# and builds `inv` representing your updated Ansible inventory.

require 'psych'

# Initialize the inventory hash
inv = {}

# Include some information about the script in output
puts "# This file is created automatically"
puts "# Please do not modify this file manually it's contents are sourced from any puppet repository"
puts "# It iterates over environments and lists contents from data/nodes/*.yaml and data/roles/*.yaml directories"
puts "# See https://github.com/jonnyhoeven/puppet-to-ansible/"

# Iterate over each `dir` in current directory
Dir.glob('./*/') do |dir|

  # Get the environment name from the directory name
  environment = File.basename(dir)

  # Initialize the environment hash in the inventory
  inv[environment] = {}
  inv[environment]["children"] = {}

  # Iterate over each YAML file in the `data/nodes` directory of the current environment
  Dir.glob("#{dir}data/nodes/*.yaml") do |file|
    begin
      # Load the node file
      node_file = Psych.load_file(file)

      # Get the hostname from the file name
      hostname = File.basename(file, ".yaml")

      # Get the role name from the node file
      role_name = node_file["role"].gsub('-', '_')

      # Define the path to the role file
      role_file_path = "#{dir}data/roles/#{role_name}.yaml"

      # Load the role file if it exists, otherwise set it to nil
      if File.exist?(role_file_path)
        role_file = Psych.load_file(role_file_path)
      else
        role_file = nil
      end

      # Initialize the role hash in the environment hash if it doesn't exist
      if inv[environment]["children"][role_name].nil?
        inv[environment]["children"][role_name] = {}
        inv[environment]["children"][role_name]["hosts"] = {}
        inv[environment]["children"][role_name]["vars"] = {}
      end

      # If the role file exists, iterate over its keys
      unless role_file.nil?
        role_file.each_key do |key|
          inv[environment]["children"][role_name]["vars"][key] = role_file[key]
        end
      end

      # Initialize the host hash in the role hash if it doesn't exist
      if inv[environment]["children"][role_name]["hosts"][hostname].nil?
        inv[environment]["children"][role_name]["hosts"][hostname] = {}
        inv[environment]["children"][role_name]["hosts"][hostname]["vars"] = {}
      end

      # If the node file exists, iterate over its keys
      unless node_file.nil?
        node_file.each_key do |key|
          k_prefix = key.split("::")[0]
          # If the key prefix is 'profile', add it to the host variables
          if k_prefix === "profile"
            inv[environment]["children"][role_name]["hosts"][hostname]["vars"][key] = node_file[key]
          end
        end
      end

    rescue Psych::SyntaxError => e
      # If syntax error in the YAML file, print error message
      STDERR.puts "# Failed to parse #{file}: #{e.message}"
    end
  end
end

# Print the inventory hash in YAML format
puts Psych.dump(inv)
