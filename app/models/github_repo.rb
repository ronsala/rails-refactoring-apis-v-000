class GithubRepo

  attr_accessor :name, :url

    def initialize(hash)
      # binding.pry
      @name = hash["name"]
      @url = hash["html_url"]
    end
  end
