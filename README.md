1. First You have to set up DB whose name is task and migrate all migration files.
2. Then you have to load all gem dependencies by running this command bundle install.
3. Then run the sidekiq server by running this command bundle exec sidekiq.
4. Then you will have to create an Invoice record from the rails console.
5. Then you can check your task on the sidekiq server, The message shown will be "worker is working!".
6. Then you will update the record which you created on the 4th step.
7. Then you can check your task again on the sidekiq server, The message shown will be "worker is working!".
8. You can check the RSpec test cases by running this command bundle exec rspec spec.
