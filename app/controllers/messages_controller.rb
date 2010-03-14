require 'time'
class MessagesController < ApplicationController

 CONFIG = YAML.load_file '/usr/local/rails/insidehacdc/config/server-ip-addresses.yml'

 HACDCSPACE_IP = CONFIG['hacdcspace']
 WWWHACDC_IP = CONFIG['webserver'] 

 attr_reader :remoteip, :monthmessages, :twitter, :last_id 

public

  # GET /messages
  # GET /messages.xml
  def index
    @twitter = twitter_client
    time = Time.utc(Time.new.year, Time.new.month)
    @monthmessages =  Message.find(:all, :conditions => ['created_at >= ? AND created_at <= ? ', time.beginning_of_month, time.end_of_month], :order => 'created_at DESC' ) 
    @messages = Message.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @remoteip = request.env["HTTP_X_FORWARDED_FOR"]
    if @remoteip != HACDCSPACE_IP && @remoteip != WWWHACDC_IP then 
        redirect_to(:action => "joinhacdc")    
        return
    end
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @remoteip = request.env["HTTP_X_FORWARDED_FOR"]
    if @remoteip != HACDCSPACE_IP && @remoteip != WWWHACDC_IP then 
        redirect_to(:action => "joinhacdc")    
        return
    end
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

# GET /messages/1/edit
#  def edit
#    @remoteip = request.env["HTTP_X_FORWARDED_FOR"]
#    if @remoteip != HACDCSPACE_IP then 
#        redirect_to(:action => "joinhacdc")    
#        return
#    end
#    @message = Message.find(params[:id])
#  end

  # POST /messages
  # POST /messages.xml
  def create
    @remoteip = request.env["HTTP_X_FORWARDED_FOR"]
    if @remoteip != HACDCSPACE_IP && @remoteip != WWWHACDC_IP then 
        redirect_to(:action => "joinhacdc")    
        return
    end

    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.save

    begin
         raise if twitter_client == nil
          @message = Message.new(params[:message])
         raise if @message == nil
         response = twitter_client.status(:post, @message.plaintext )
    rescue
        redirect_to(twittererr_path)
        return
    end

      @@twitter_client.status(:post, params[:plaintext]);

        flash[:notice] = 'Message was successfully created.'
        format.html { redirect_to(@message) }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

# PUT /messages/1
# PUT /messages/1.xml
# def update
#   @remoteip = request.env["HTTP_X_FORWARDED_FOR"]
#   if @remoteip != HACDCSPACE_IP then 
#       redirect_to(:action => "joinhacdc")    
#       return
#   end
#
#    @message = Message.find(params[:id])
#
#    respond_to do |format|
#      if @message.update_attributes(params[:message])
#        flash[:notice] = 'Message was successfully updated.'
#        format.html { redirect_to(@message) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

# DELETE /messages/1
# DELETE /messages/1.xml
# def destroy
#
#    @remoteip = request.env["HTTP_X_FORWARDED_FOR"]
#    if @remoteip != HACDCSPACE_IP then 
#        redirect_to(:action => "joinhacdc")    
#        return
#    end
#
#    @message = Message.find(params[:id])
#
#    @message.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(messages_url) }
#      format.xml  { head :ok }
#    end
#  end

  def joinhacdc
	@remoteip = request.env["HTTP_X_FORWARDED_FOR"] 

#	redirect_to "http://twitter.com/insidehacdc"
  end

  def twitterfail
  end
end
