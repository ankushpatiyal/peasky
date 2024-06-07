class UserWorker < Base
  def perform
    UserService.call
  end
end
