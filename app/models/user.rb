class User < ApplicationRecord
  MALE_KEY = "male"
  FEMALE_KEY = "female"

  after_destroy :reevaluate_daily_record
  scope :by_gender_and_date, ->(gender, date) { where('gender = ? and DATE(created_at) = ?', gender, date) }

  def self.male_key
    Date.today.to_s + MALE_KEY
  end

  def self.female_key
    Date.today.to_s + FEMALE_KEY
  end

  def self.male_avg_age_today
    avg_age_today(MALE_KEY)
  end

  def self.female_avg_age_today
    avg_age_today(FEMALE_KEY)
  end

  def self.avg_age_today(gender)
    by_gender_and_date(gender, Date.today).average(:age)
  end

  def reevaluate_daily_record
    ReevaluateDailyRecordWorker.perform_async(self.gender, self.age, self.daily_record_id)
  end
end
