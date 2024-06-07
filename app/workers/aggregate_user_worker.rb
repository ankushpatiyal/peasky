class AggregateUserWorker < Base
  def perform
    AggregateUserService.call    
  end
end
