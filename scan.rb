#!/usr/bin/env ruby
#   DISCOvery     #
#                 #
###################
require 'socket'
require 'net/ping'
require 'timeout'

def host_alive?(ip)
  ping = Net::Ping::External.new(ip)

  if ping.ping?
    true
  else
    false
  end
end

def port_open?(ip, port, timeout = 2)
  Timeout.timeout(timeout) do
    begin
      TCPSocket.new(ip, port).close
      true
    rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH, SocketError
      false
    end
  end
rescue Timeout::Error
  false
end
