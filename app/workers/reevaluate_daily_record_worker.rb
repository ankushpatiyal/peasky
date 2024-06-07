class ReevaluateDailyRecordWorker < Base
  def perform(created_date, gender, age)
    if created_date == DateTime.now.to_date.to_s
      user_count = Rails.cache.read(User.send("#{gender}_key"))
      Rails.cache.write(User.send("#{gender}_key"), user_count - 1)
    else
      DailyRecord.transaction do
        d = DailyRecord.where("DATE(created_at) = ?", created_date).last.lock!
        d.set_new_avg_age(age, gender)
        d.save!
      end
    end
  end
end