# Crowd Rest

A ruby client for [Atlassian's Crowd REST API](http://confluence.atlassian.com/display/CROWDDEV/Crowd+REST+APIs).

## Usage

    require 'crowd_rest'
    
    CrowdRest.crowd_url = "http://127.0.0.1:8095"
    CrowdRest.app_name = "demo"
    CrowdRest.app_pass = "demo_pass"
    
    # log in a crowd user
    response = CrowdRest::Session.create("username", "password")
    response.code  # => 201
    response.token # => the crowd sso token
    
    # failed login
    response = CrowdRest::Session.create("baduser", "badpass")
    response.code   # => 400
    response.reason # => INVALID_USER_AUTHENTICATION

    # check for existing login session
    response = CrowdRest::Session.find(token)
    response.code # => 200
    
    # check for non-existant session
    response = CrowdRest::Session.find("badtoken")
    response.code == 200 # => false
    
    # get the user associated with a login session
    login = CrowdRest::Session.create("username", "password")
    response = CrowdRest::Session.find(login.token, :include => :user)
    response.code         # => 200
    response.user['name'] # => "username"
