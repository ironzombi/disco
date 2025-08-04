#!/usr/bin/env ruby
require_relative 'scan'

ip = "165.118.134.135"
port = 22

puts(port_open?(ip, port))
