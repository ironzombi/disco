#!/usr/bin/env ruby
#
##
#
require 'socket'
require 'timeout'

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
