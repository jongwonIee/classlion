# README

To run classlion project at the first time.

* rails db:drop
* rails db:migrate
* bundle exec rake sunspot:solr:start
* rails db:seed
* redis-server
* bundle exec sidekiq --environment development -C config/sidekiq.yml 

* #TODO CAPTCHA

* cheat
* current_user.update_attribute(:point, 1000)