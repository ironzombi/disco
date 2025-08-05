#!/usr/bin/ruby
#process results #
#                #
##################
require 'ipaddr'

def group_ips_from_file(filename, subnet_mask = 24)
  subnet_groups = Hash.new { |h, k| h[k] = [] }

  File.readlines(filename).map(&:strip).uniq.each do |line|
    begin
      ip = IPAddr.new(line)
      subnet = IPAddr.new("#{ip.to_s}/#{subnet_mask}").mask(subnet_mask).to_s + "/#{subnet_mask}"
      subnet_groups[subnet] << ip.to_s
    rescue IPAddr::InvalidAddressError
      warn "Invalid IP address: #{line}"
    end
  end

  subnet_groups
end

file_path = "ips.txt"
grouped = group_ips_from_file(file_path)

grouped.each do |subnet, ips|
  puts "Subnet #{subnet}:"
  ips.sort.each { |ip| puts "  #{ip}" }
end

