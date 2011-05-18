# 2011-05-18: v0.0.2

* The returned user from CrowdRest::Session.find(token, :include => :user) is
  now a CrowdRest::User object instead of a vanilla OpenStruct.

# 2011-05-17: v0.0.1

* Initial version. Supports login with CrowdRest::Session.create and finding
  current user/session with CrowdRest::Session.find