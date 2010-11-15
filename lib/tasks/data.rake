namespace :data do

  # Ripped from Tim Dysinger's CouchDB import script
  desc 'import the email to riak search'
  task :load => :environment do
    require 'riak/search'
    solr      = RSolr.connect :url => "http://localhost:8098/solr/enron"
    riak      = Riak::Client.new :solr => "/solr"
    not_b4    = Time.parse("1999-01-01")
    enron     = riak["enron"]
    mail_root = File.expand_path('tmp/.maildir', Rails.root)
    grrr      = Proc.new{|_var|
                  case _var
                  when String then _var
                  when Array  then _var.join
                  when nil    then ""
                  else
                    (_var.respond_to?(:to_s)) ? _var.to_s : ""
                  end
                }

    Find.find(mail_root) do |path|
      next if FileTest.directory?(path)
      next if path =~ /DS_Store/ # Damn it, Apple

      begin
        msg       = Mail.read(path)
        next if msg.date < not_b4

        doc       = Riak::RObject.new(enron, msg.message_id.to_s)
        doc.data  = {
          :id           => msg.message_id,
          :mail_date    => msg.date,
          :from         => grrr.call(msg.from), #.join,     # A hack?
          :to           => grrr.call(msg.to), # (msg.to.nil?   ? "" : msg.to.join)
          :cc           => grrr.call(msg.cc), # (msg.cc.nil?   ? "" : msg.cc.join),
          :bcc          => grrr.call(msg.bcc),# (msg.bcc.nil?  ? "" : msg.bcc.join),
          :subject      => msg.subject,
          :body         => msg.body,
          :folder       => msg["X-Folder"],
          :origin       => msg["X-Origin"],
          :nsf          => msg["X-Filename"],
          :mail_content_type => msg.content_type
        }
        doc.content_type = "application/json"

        doc.store
#        next unless docs.size > 10
        
#        solr.add docs
#        docs = []
      rescue Interrupt
        exit(1)
      rescue Exception => ex
        puts "#{path} #{ex.inspect}"
      end
    end
#    solr.add docs
  end # task(:load => 'maildir')
end # namespace :data
