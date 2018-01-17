# naas-api
API for notifications service (notfications-as-a-service or NAAS) prototype


## Development

Requirements:

- Ruby 2.0+
- Bundler
- [Ngrok](https://ngrok.com/) or [localtunnel](https://localtunnel.github.io/www/) if you wish to send live messages.
  - Note: these tools are likely not approved for use on any government network. 

### Running the app locally

1. Configure application secrets in `/config/secrets.yml`
  - If you'd like to send live messagse, you will need to register for API credentials and a phone number with [Twilio](https://www.twilio.com/).
2. Bundle application dependencies with `bundle`,
  - Install the latest version of bundler with `gem install bundler`
2. Start the server with `bin/rails s` and your application will be running at http://localhost:3000

### Running the specs

1. To run the suite of specs, simply run `rake`.

### Deploying to cloud.gov

1. Install the CloudFoundry client and authenticate with cloud.gov.
  - For help, visit [Set up the command line](https://cloud.gov/docs/getting-started/setup/#set-up-the-command-line) in the cloud.gov documentation.
2. The name of the application can be defined with the environment variable `APP_NAME`, otherwise, it will be deployed as `naas-api` upon executing `bin/cf_push`.


## API Interaction

### Authenticate
Retrieve API credentials from server:

```
curl -H "Content-Type: application/json" -X POST -d '{"email":"example@mail.com","password":"123123123"}' http://localhost:3000/authenticate

```
This will return the api key to use in future requests:

```
{"auth_token":"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE1MTU3OTUxNzZ9.JN7aLcS1l7PS6GPE0B5KA7iozZ4AIClNa3wtb7yuviI"}
```

### Create Users and Notifications

First let's create a user

```
curl -H "Content-Type: application/json" -H "Authorization:eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE1MTU3OTUxNzZ9.JN7aLcS1l7PS6GPE0B5KA7iozZ4AIClNa3wtb7yuviI" -X POST -d '{"last_name": "Marsh", "email": "fake@veryfake.com", "password":"evenfakerer","password_confirmation":"evenfakerer", "phone": "1234567"}' http://localhost:3000/users
```
The endpoint will return json of the newly created resource if the operation was successful

```
{"id":5,"email":"fake@veryfake.com","first_name":null,"middle_name":null,"last_name":"Marsh","phone":"1234567","created_at":"2018-01-11T22:25:53.282Z","updated_at":"2018-01-11T22:25:53.282Z","password_digest":"$2a$10$OIxhT7T6GzVmVJ/b761zM.GwxD0gcD/y8P.Um8cwI.kTfiIo4yD0e","name":null,"confirmed":null}
```
Now let's create a sample notification.  Agencies can have multiple notifications that multiple users can subscribe to.

```
curl -H "Content-Type: application/json" -H "Authorization:eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE1MTU3OTUxNzZ9.JN7aLcS1l7PS6GPE0B5KA7iozZ4AIClNa3wtb7yuviI" -X POST -d '{ "name": "General Alert", "created_by":"1" }' http://localhost:3001/notifications

```
The created_by column is the id of the Agency user creating the notification

### User Subscribe to Notifications
With users and notifications added to the application we now demonstrate a user subscribing to a 
notification.
```
curl -H "Content-Type: application/json" -H "Authorization:eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE1MTU3OTUxNzZ9.JN7aLcS1l7PS6GPE0B5KA7iozZ4AIClNa3wtb7yuviI" -X POST -d '{ "name": "General Alert", "user_id":"1" }' http://localhost:3001/notifications/3/user_subscriptions
```
This request, in plain language, can be read as the user with id of `1` subscribed to notification 3 (the notification)
we just created), this notification is maintained by its related agency.

### User confirms mobile number
Before a user can receive SMS alerts they must first confirm their mobile phone number, by submitting
their number as follows.

```
curl -H "Content-Type: application/json" -H "Authorization:eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE1MTU3OTUxNzZ9.JN7aLcS1l7PS6GPE0B5KA7iozZ4AIClNa3wtb7yuviI" -X POST -d '{"phone": "8082246036",
                             "body":"A Sample Subscribe Message", "source_app": "my_app_name"}' http://localhost:3001/subscribe
```
The user will then receive a message that they must respond to for confirmation, the language of this message
can be customized at the agencies request.  Once the user responds their profile is marked as confirmed
to receive SMS messages.

### Agency admin sends message

For now an Agency can send a group or targeted message by activing a notification by sending an HTTP 
POST as follows, the agency can provide the message body in the request, if a message is not provided
the notification will be sent with a body that was saved with the notification when it was created.

```
curl -H "Content-Type: application/json" -H "Authorization:eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE1MTU3OTUxNzZ9.JN7aLcS1l7PS6GPE0B5KA7iozZ4AIClNa3wtb7yuviI" -X POST -d '{ "body": "Hello from NAAS"}' http://localhost:3001/notifications/3/send_group_notification
```

## Public domain

This project is in the worldwide [public domain](LICENSE.md). As stated in [CONTRIBUTING](CONTRIBUTING.md):

> This project is in the public domain within the United States, and copyright and related rights in the work worldwide are waived through the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
>
> All contributions to this project will be released under the CC0 dedication. By submitting a pull request, you are agreeing to comply with this waiver of copyright interest.
