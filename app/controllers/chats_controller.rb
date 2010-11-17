class ChatsController < ApplicationController
  # GET /chats
  def index
    
  end

  def show
    
  end

  # GET /chats/new
  def new
    
  end

  def edit
    
  end

  # POST /chats
  def create
    @item         = Chat.new
    @item.name    = cookies[:name]
    @item.email   = cookies[:email]
    @item.message = params[:message]
    @item.replyto = params[:replyto]

    render :error unless @item.save({:return_body => true})

    @attrs = @item.attributes.merge({:key => @item.key})
  end

  def destroy
    
  end

  def login
    cookies[:name]  = params[:name]   unless params[:name].blank?
    cookies[:email] = params[:email]  unless params[:email].blank?
    redirect_to chats_path
  end

  def welcome
    
  end
end