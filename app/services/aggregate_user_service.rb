class AggregateUserService < BaseService
  def call
    create_daily_record
  end

  def create_daily_record
    d = DailyRecord.new
    d.male_count = Rails.cache.read(User.male_key).to_i
    d.female_count = Rails.cache.read(User.female_key).to_i
    d.set_avg_age
    d.save
  end
end