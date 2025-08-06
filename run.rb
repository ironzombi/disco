#!/usr/bin/env ruby
#Run the scan    #
#                #
# iz             #
##################
require 'ipaddr'
require_relative 'scan'

FP = File.open("scan_results.log", "w+")

subnet = "165.118.134.0/24"
port = 22

def scan_subnet(subnet, port)
  IPAddr.new(subnet).to_range.each do |ip|
    next if ip.to_s.end_with?('.0') || ip.to_s.end_with?('.255') # skip network/broadcast
    print "Scanning #{ip}:#{port}... "
    if port_open?(ip.to_s, port)
      puts "OPEN"
      FP.puts("#{ip}")
    else
      puts "closed"
    end
  end
end

def ping_subnet(subnet)
  IPAddr.new(subnet).to_range.each do |ip|
    next if ip.to_s.end_with?('0') || ip.to_s.end_with?('255')
    print "Pinging #{ip} "
    if host_alive?(ip.to_s)
      puts "ALIVE"
      FP.puts("#{ip}")
    else
      puts "unreachable"
    end
  end
end

begin
  ping_subnet(subnet)
  #scan_subnet(subnet, port)
rescue Interrupt
  puts ":"
  puts "Stopping Scan"
  exit
end
