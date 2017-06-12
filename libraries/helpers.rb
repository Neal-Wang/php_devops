#
# Cookbook Name:: php_devops
# Recipe:: database
#
# Copyright (c) 2017 Sarah Ma, All Rights Reserved.

module Wordpress
  module Helpers
    def is_local_host?(host)
      if host == 'localhost' || host == '127.0.0.1' || host == '::1'
        true
      else
        require 'socket'
        require 'resolv'
        Socket.ip_address_list.map { |a| a.ip_address }.include? Resolv.getaddress host
      end
    end

    def self.make_db_query(user, pass, query)
      %< --user=#{user} --password="#{pass}" --execute="#{query}">
    end
  end
end
