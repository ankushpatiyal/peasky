class ReevaluateDailyRecordWorker < Base
  def perform(gender, age, daily_record_id = nil)
    if daily_record_id.blank?
      user_count = Rails.cache.read(User.send("#{gender}_key"))
      Rails.cache.write(User.send("#{gender}_key"), user_count - 1)
    else
      DailyRecord.transaction do
        d = DailyRecord.where(id: daily_record_id).last.lock!
        d.set_new_avg_age(age, gender)
        d.save!
      end
    end
  end
end