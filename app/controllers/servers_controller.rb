require 'net/ssh'
require 'net/scp'
require 'timeout'

class ServersController < ApplicationController
  def index
  	@result = Server.all

  end

  def show

  	@server = Server.find(params[:id])

    pass = '#'

    #filename = 'TEST2'

    begin

    @complete_results = Timeout.timeout(15) do

        Net::SSH.start( @server.host, @server.user, :password => pass) do |ssh|
     
        @result = ssh.exec!('cd /images; ls')
        #@result = ssh.exec!("cd //images; rm -rf #{filename}/")

        @result = @result.split(' ')

     end  
    
    
    end
    
    rescue Timeout::Error
      @complete_results = ''
    
    end 

  
  end

  def new

  	@server = Server.new


  end

  def destroy
    Server.find(params[:id]).destroy
    
    flash[:success] = "Server deleted"
    
    redirect_to :action => "index"
  
  end


  def create

    #@server = Server.new(params[:server])

    @server = Server.new(server_params)

    if @server.save

      redirect_to :action => "index"

    else
    	
      render 'new'
    
    end

  end

  def file_delete

    @server = Server.find(params[:id])
    filename = params[:filename]

    pass = '#'

    begin

    @complete_results = Timeout.timeout(10) do

        Net::SSH.start( @server.host, @server.user, :password => pass) do |ssh|
     
        @result = ssh.exec!("cd //images; rm -rf #{filename}/")

        redirect_to :action => "show"

     end  
    
    
    end
    
    rescue Timeout::Error
      @complete_results = ''
    
    end 

  
  end

  def inventory

    @server = Server.find(params[:id])
    

    begin

    @complete_results = Timeout.timeout(20) do

        Net::SSH.start( "#", "#",:password => "#") do |ssh|
     
        @result = ssh.exec!('cd /images; ls')

        @result = @result.split(' ')

     end  
    
    
    end
    
    rescue Timeout::Error
      @complete_results = ''
    
    end 

  
  end


  def sending

    @server = Server.find(params[:id])
    filename = params[:filename]

    pass = '#'

    begin

    @complete_results = Timeout.timeout(10) do

        Net::SSH.start( @server.host, @server.user, :password => pass) do |ssh|
     
        @result = ssh.exec!("cd //; ruby send.rb #{filename}")

        redirect_to :action => "show"

     end  
    
    
    end
    
    rescue Timeout::Error
      @complete_results = ''
    
    end 

  
  end


  private

    def server_params

      params.require(:server).permit(:host, :name, :user, :password, :password_confirmation)
    
    end

    def delete_confirm_params

      params.require(:server).permit(:password)

    end

end
