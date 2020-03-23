class GithubService
  attr_accessor :access_token

  def initialize(hash = {})
    @access_token = hash["access_token"]
  end

  def authenticate!(client_id, client_secret, code)
    binding.pry
      response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
        req.body = { 'client_id': ENV["GITHUB_CLIENT"], 'client_secret': ENV["GITHUB_SECRET"], 'code': code }
        req.headers['Accept'] = 'application/json'
      end

      body = JSON.parse(response.body)
      @access_token = body['access_token']
  end

  def get_username
    response = Faraday.get "https://api.github.com/user" do |req|
      req.headers['Authorization'] = "token #{@access_token}"
      req.headers['Accept'] = 'application/json'
    end

    body = JSON.parse(response.body)
    @username = body['login']
  end

  def get_repos
    response = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers['Authorization'] = "token #{@access_token}"
      req.headers['Accept'] = 'application/json'
    end

    @repos_array = []
    body = JSON.parse(response.body)
    body.each do |r|
      @repos_array << GithubRepo.new(r)
    end

    return @repos_array
  end

  def create_repo(repo_name)
    # response = Faraday.post "https://api.github.com/user/repos" do |req|
    Faraday.post "https://api.github.com/user/repos" do |req|
      req.headers['Authorization'] = "token #{@access_token}"
      # req.headers['Authorization'] = @access_token
      req.body = {"name": repo_name}
      # req.body["name"] = repo_name
      # req.headers['Accept'] = 'application/json'
    end

    # body = JSON.parse(response.body)
  end
end