# README

To run classlion project at the first time.

* go to @evaluation.rb and comment line 12 to seed
* rails db:drop
* rails db:migrate
* bundle exec rake sunspot:solr:start
* rails db:seed
* redis-server
* bundle exec sidekiq --environment development -C config/sidekiq.yml 

* #TODO CAPTCHA

* cheat
* rails c
* depending on your user_id,
* User.find(user_id).update_attribute(:point, 1000)