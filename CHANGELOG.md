# 2016-01-05: v0.1.1

* Bump HTTParty Gem Version requirement to 0.13

# 2013-03-16: v0.1.0

* Add support for user session destruction and token validation and
  invalidation (@kunklejr).

# 2011-05-18: v0.0.2

* The returned user from CrowdRest::Session.find(token, :include => :user) is
  now a CrowdRest::User object instead of a vanilla OpenStruct.

# 2011-05-17: v0.0.1

* Initial version. Supports login with CrowdRest::Session.create and finding
  current user/session with CrowdRest::Session.find
