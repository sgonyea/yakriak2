class Chat
  include Ripple::Document
   

  property :message, String
  property :name, String
  property :email, String
  property :replyto, String
end
