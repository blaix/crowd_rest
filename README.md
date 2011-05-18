# Crowd Rest

A ruby client for [Atlassian's Crowd REST API](http://confluence.atlassian.com/display/CROWDDEV/Crowd+REST+APIs).

## Installation

    gem install crowd_rest

## Usage

    require 'crowd_rest'
    
    CrowdRest.config do |c|
      c.crowd_url = "http://127.0.0.1:8095"
      c.app_name = "demo"
      c.app_pass = "demo_pass"
    end
    
    # unsuccessful login
    response = CrowdRest::Session.create("baduser", "badpass")
    response.code # => 400
    response.reason # => INVALID_USER_AUTHENTICATION
    
    # successful log in
    response = CrowdRest::Session.create("gooduser", "goodpass")
    response.code # => 201
    token = response.token # => the crowd sso token

    # check for existing login session
    response = CrowdRest::Session.find(token)
    response.code # => 200
    
    # get the user associated with a login session
    response = CrowdRest::Session.find(token, :include => :user)
    response.user.name # => "gooduser"
