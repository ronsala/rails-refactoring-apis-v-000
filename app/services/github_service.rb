class GithubService
  attr_accessor :access_token

  def initialize(hash = {})
    @access_token = hash["access_token"]
  end
end