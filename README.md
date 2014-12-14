# Call Cloud
すべての企業に自動電話対応システムを。

This product is craeated in [Salesforce's Hack Challenge 2014 in Japan](http://jp.force.com/devzone2014/hackchallenge).

## About
- [Product](https://callcloud.herokuapp.com/)
- [SlideShare](http://www.slideshare.net/honmadayo/call-cloud)
- [YouTube](https://www.youtube.com/watch?v=2K2XR2cXl8w)

## Technology
- Heroku
- Ruby on Rails
- jCanvas
- Twilio
- jQuery
- PostgreSQL
- Material Design for Bootstrap
- MailGun

## Setup
#### .env 

```
TWILIO_SID=Your Twilio's AccountSID
TWILIO_AUTH_TOKEN=Your Twilio's AuthToken
```

To create operators, you need to buy tel number in Twilio.

#### command

```
bundle install
bundle exec rake db:migrate
bundle exec rails server
```

