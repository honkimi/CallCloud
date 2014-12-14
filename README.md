# Call Cloud
すべての企業に自動電話対応システムを。

This product is craeated in [Salesforce's Hack Challenge 2014 in Japan](http://jp.force.com/devzone2014/hackchallenge).

## About
- [Product](https://callcloud.herokuapp.com/)
- [SlideShare](http://www.slideshare.net/honmadayo/call-cloud)
- [YouTube](https://www.youtube.com/watch?v=2K2XR2cXl8w)

## Service
無料で利用できます。  
現在稼働しているサーバでは, 5つの電話番号を提供しています。

オペレータの作成から電話番号の選択がなくなっていた場合は: 

- Github Issue を作っていただく
- 直接お問い合わせ


## Short Terms

- コールクラウドは[Salesforce's Hack Challenge 2014 in Japan](http://jp.force.com/devzone2014/hackchallenge)のために作られたものであり、ビジネスとして有料で提供しているものではございません。
- コールクラウドは本ハックチャレンジ終了後、予告なくサービスを終了することができるものとします。ただし、その後別サービスとして同様のサービスを提供する場合があります。
- 運営者が不正な自動オペレータが作成されたと判断した場合、ユーザー情報と共に該当の自動オペレータを予告なく削除できるものとします。

## Short Privacy Policy
登録いただいたメールアドレスは以下の目的で利用します。その他の目的では利用しません。

- ユーザーを識別する
- サービス利用に必要なメールを送信する

録音内容は組織内でのみ公開されており、第三者には直接のURLを知られない限り取得できません。

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

