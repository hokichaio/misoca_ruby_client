# MisocaRubyClient [![Build Status](https://travis-ci.org/hokichaio/misoca_ruby_client.svg?branch=master)](https://travis-ci.org/hokichaio/misoca_ruby_client)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'misoca_ruby_client'
```

And then execute:

    $ bundle instal

Or install it yourself as:

    $ gem install misoca_ruby_client

## Usage

Because misoca's refresh token live quite a long time. You can save your token somewhere and constantly refresh the token(e.g. Cron) so you don't have to authorize everytime.
```ruby
# Create a proc so that we can save the token to somewhere
update_config = proc { |access_token| 
	SomeModelToSaveToken.update_columns(misoca_access_token: access_token.token, misoca_refresh_token: access_token.refresh_token)
}

# Initialize client
mymisoca = MisocaRubyClient.new(application_id, secret, callback_url, update_config)

# Inject a saved token so that you can skip authentication
mymisoca.inject_access_token(misoca_access_token, misoca_refresh_token) if misoca_access_token && misoca_refresh_token
```
Then you can have a cron which do
```ruby
mymisoca.refresh_access_token
```
at least once everyday.

You can also choose not using `update_config`. For this, you need a callback controller which do.
```ruby
class OauthController < ApplicationController
  def misoca_authorization
    return redirect_to mymisoca.get_authorize_url
  end

  def misoca_callback
    mymisoca.exchange_token(params[:code])
    return redirect_to "/configs"
  end
end
```
Note that `misoca_authorization` redirect you to Misoca's oauth page. `misoca_callback` is the callback which receive `params[:code]` and update access token.

Create an invoice
```ruby
invoice = {
  issue_date: Date.today,
  payment_due_on: Date.today,
  subject: "Pay Me Money",
  recipient_name: "You"
  recipient_title: 'Mr.',
  invoice_body_attributes: {
    recipient_zip_code: "123-4567",
    recipient_address1: "My Address",
    recipient_name1: "Someone",
    recipient_title: 'Chief',
  },
  invoice_items_attributes: [{
  	name: "work",
	quantity: 1,
	unit_price: 100,
  }]
}
mymisoca.access_token.post('/api/v1/invoice', { body: { invoice: invoice } })
```
