class GitignoreNotFoundException < RuntimeError
  attr :ignore_name
  def initialize(ignore_name)
    @ignore_name = ignore_name
  end
end
