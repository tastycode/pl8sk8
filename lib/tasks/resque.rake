namespace :resque do
  task :setup => :environment do
    require "resque_scheduler"
    require "resque/scheduler"

    Resque.redis = 'localhost:6379'
    Resque.schedule = YAML.load_file(Rails.root.join("config", "scheduler.yml"))
  end

end

