class GithubService
  attr_accessor :access_token

  def initialize(hash = {})
    @access_token = hash["access_token"]
  end

  def authenticate!(client_id, client_secret, code)
      response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
        req.body = { 'client_id': ENV["GITHUB_CLIENT"], 'client_secret': ENV["GITHUB_SECRET"], 'code': code }
        req.headers['Accept'] = 'application/json'
      end

      body = JSON.parse(response.body)
      @access_token = body['access_token']
  end

  def get_username
    
  end
end