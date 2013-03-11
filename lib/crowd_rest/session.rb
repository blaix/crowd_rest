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

    def self.destroy(username, options = {})
      path = "/session?username=#{username}"
      path << "&except=#{options.except}" if options[:except]
      response = CrowdRest.delete(path)
      normalize_response(response, 204)
    end

    def self.validate(token, validation_factors = {})
      path = "/session/#{token}"
      body = "<validation-factors>"
      validation_factors.each do |name, value|
        body << "<validation-factor>
          <name>#{name}</name>
          <value>#{value}</value>
        </validation-factor>"
      end
      body << "</validation-factors>"
      response = CrowdRest.post(path, :body => body)
      normalize_response(response, 200) do |successful_response|
        successful_response.token = response['session']['token']
      end
    end

    def self.invalidate(token)
      path = "/session/#{token}"
      response = CrowdRest.delete(path)
      normalize_response(response, 204)
    end

    private
    def self.normalize_response(response, success_code = 200)
      attributes = {
        :code => response.code,
        :body => response.body,
        :reason => response['error'] ? response['error']['reason'] : response['reason'] || nil,
        :message => response['error'] ? response['error']['message'] : response['message'] || nil
      }

      norm_response = OpenStruct.new(attributes)
      yield(norm_response) if block_given? && response.code == success_code
      norm_response
    end
  end
end
