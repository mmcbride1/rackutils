#!/usr/bin/env ruby

require 'yaml'

class Configuration

   # Instance vars #
   @user
   @passwd
   @serverlist

   # Initialize #
   def initialize(section)
      get_configuration(section)
   end

   # Get configuration 
   # as specified by the section
   # in the YAML file
   def get_configuration(section)
      this_dir = '/powercontrol/'
      conf_home = ENV['RACK_HOME'] + this_dir
      config = YAML.load_file(conf_home + "hosts.yaml")
      out = config[section]
      @user = out['user']
      @passwd = out['pass']
      @serverlist = out['servers']
   end

   # Get server list property
   def get_serverlist
      return @serverlist.split(',')
   end

   # Get user property
   def get_user
      return @user
   end

   # Get password property
   def get_passwd
      return @passwd
   end
 
end
