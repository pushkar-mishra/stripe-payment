First add the following gems to the gemfile:
```
gem 'devise'
gem 'twitter-bootstrap-rails'
gem 'devise-bootstrap-views'
```
Then run 
```
bundle install --without production
```
Then install devise:
```
rails generate devise:install
rails generate devise User
```

Pull up the migration file that just got created and uncomment the 4 lines under confirmable:
t.string :confirmation_token
t.datetime :confirmed_at
t.datetime :confirmation_sent_at
t.string :unconfirmed_email
Pull up the user.rb model file under app/models and in the line for devise, add in a:
":confirmable,"
after :registerable, entry
Run your migration now to create the users table:
```
rake db:migrate
```
In your application_controller.rb file under app/controllers add in:
before_action :authenticate_user!
In your welcome_controller.rb file under app/controllers add in:
skip_before_action :authenticate_user!, only: [:index]
Run the following generators to install bootstrap themed styling:
```
rails generate bootstrap:install static
rails generate bootstrap:layout application # select Y to force override after hitting enter
rails generate devise:views:locale en
rails generate devise:views:bootstrap_templates
```
In the application.css file under app/assets/stylesheets folder, right above the line that says *= require_tree add in the following line:

```
*= require devise_bootstrap_views
```

Adding Stripe

Guide for basic rails implementation of Stripe checkout:
https://stripe.com/docs/checkout/guides/rails
Note down your test secrety key and your test publishable key
In your gemfile add the stripe gem:
gem 'stripe'
Then 
```
bundle install --without production
```
Create a file named stripe.rb within your config/initializers folder and fill it in:
```ruby
Rails.configuration.stripe = {
:publishable_key => ENV['STRIPE_TEST_PUBLISHABLE_KEY'],
:secret_key => ENV['STRIPE_TEST_SECRET_KEY']
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]
```
Open your .bashrc file and fill in
```
export STRIPE_TEST_SECRET_KEY=yoursecrettestkeyfromstripe
export STRIPE_TEST_PUBLISHABLE_KEY=yourpublishabletestkeyfromstripe
```
Open a new terminal window for these to take effect
Now set these for heroku from your terminal window type in:
```
source ~/.bashrc
heroku config:set STRIPE_TEST_SECRET_KEY=$STRIPE_TEST_SECRET_KEY
heroku config:set STRIPE_TEST_PUBLISHABLE_KEY=$STRIPE_TEST_PUBLISHABLE_KEY
```




