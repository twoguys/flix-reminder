web:      bundle exec thin start -p $PORT
worker:   QUEUE=* bundle exec rake environment resque:work