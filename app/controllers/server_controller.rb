require 'net/ssh'
require 'net/scp'

HOST = '#'
USER = '#'
PASS = '#'

//# code sample














































class ServerController < ApplicationController
  def new
  end

  def show
    
    
  	
  	Net::SSH.start( HOST, USER, :password => PASS ) do |ssh|
  	 
     @result = ssh.exec!('cd /images; ls')

  	end
  

  end

  def delete
  end

  def copy
  end
end
