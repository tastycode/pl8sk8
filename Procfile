web: bundle exec rails server -p $PORT -e $RACK_ENV
scheduler: bundle exec rake resque:scheduler
worker: QUEUE=* bundle exec rake resque:work
