module CrowdRest
  SuccessfullResponse = Struct.new(:token, :code, :body)
  FailedResponse = Struct.new(:reason, :message, :code, :body)

  class Session
    def self.create(username, password)
      body = "<authentication-context>
        <username>#{username}</username>
        <password>#{password}</password>
      </authentication-context>"
      res = CrowdRest.post("/session", :body => body)
      if res.code == 201
        SuccessfullResponse.new(res['session']['token'], res.code, res.body)
      else
        FailedResponse.new(res['reason'], res['message'], res.code, res.body)
      end
    end
  end
end
