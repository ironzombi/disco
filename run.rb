#!/usr/bin/env ruby
require 'ipaddr'
require_relative 'scan'

subnet = "168.118.134.129/29"
port = 22

def scan_subnet(subnet, port)
  IPAddr.new(subnet).to_range.each do |ip|
    next if ip.to_s.end_with?('.0') || ip.to_s.end_with?('.255') # skip network/broadcast
    print "Scanning #{ip}:#{port}... "
    if port_open?(ip.to_s, port)
      puts "OPEN"
    else
      puts "closed"
    end
  end
end

scan_subnet(subnet, port)