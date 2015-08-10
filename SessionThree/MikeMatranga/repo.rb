class Repo
  def initialize(repo_json)
    @name = repo_json['name']
    @last_push = repo_json['pushed_at']
  end

  def name
    @name
  end

  def last_push
    @last_push
  end
end
