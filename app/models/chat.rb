class Chat
  include Ripple::Document

  property :message,    String, :presence => true
  property :name,       String, :presence => true
  property :email,      String
  property :replyto,    String
  property :timestamp,  Time,   :default => proc { Time.now }

  
  Ripple.client[bucket_name].enable_index!

  def self.search(*args)
    Ripple.client.search bucket_name, args
  end
end
