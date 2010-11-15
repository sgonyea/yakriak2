namespace :riak do
  desc 'start the riak search nodes + load balancer'
  task :start => :environment do
    
    ["dev1", "dev2", "dev3"].each do |node|
      node_exec = File.join(Rails.root, "db", "riak_search", "dev", node, "bin", "riaksearch")
      print `#{node_exec} start`
      sleep 1
      print `#{node_exec}-admin join dev1@127.0.0.1` unless node == "dev1"
    end

    pen_exec  = File.join(Rails.root, "db", "pen", "pen")
    tmp_pid   = File.join(Rails.root, "tmp", "pids", "pen-8098.pid")
    print `#{pen_exec} -x 500 -p #{tmp_pid} localhost:8098 8098 localhost:8091 localhost:8092 localhost:8093`
  end

  desc 'start the riak search nodes'
  task :stop => :environment do
    ["dev1", "dev2", "dev3"].each do |node|
      node_exec = File.join(Rails.root, "db", "riak_search", "dev", node, "bin", "riaksearch")
      print `#{node_exec} stop`
    end

    tmp_pid   = File.read(File.join(Rails.root, "tmp", "pids", "pen-8098.pid")).chomp
    print `kill #{tmp_pid}`
  end
end