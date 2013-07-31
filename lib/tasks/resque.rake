namespace :resque do
  task :setup => :environment do
    require "resque_scheduler"
    require "resque/scheduler"

    if ENV["REDISTOGO_URL"]
      uri = URI.parse(ENV['REDISTOGO_URL'])
      Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)
    else
      Resque.redis = "localhost:6379"
    end
    Resque.schedule = YAML.load_file(Rails.root.join("config", "scheduler.yml"))
  end

end

