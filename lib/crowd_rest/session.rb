require 'ostruct'

module CrowdRest
  class Session
    def self.create(username, password)
      body = "<authentication-context>
        <username>#{username}</username>
        <password>#{password}</password>
      </authentication-context>"
      response = CrowdRest.post("/session", :body => body)
      normalize_response(response, 201) do |successful_response|
        successful_response.token = response['session']['token']
      end
    end
    
    def self.find(token, options = {})
      request_user = options[:include] && options[:include] == :user
      path = "/session/#{token}"
      path << "?expand=user" if request_user
      response = CrowdRest.get(path)
      normalize_response(response) do |successful_response|
        user = response['session']['user']
        successful_response.user = CrowdRest::User.new(user)
      end
    end
    
    private
    def self.normalize_response(response, success_code = 200)
      attributes = {
        :code => response.code,
        :body => response.body,
        :reason => response['reason'],
        :message => response['message']
      }

      norm_response = OpenStruct.new(attributes)
      yield(norm_response) if response.code == success_code
      norm_response
    end
  end
end
