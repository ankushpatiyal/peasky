class DailyRecord < ApplicationRecord
  def set_avg_age
    self.male_avg_age = User.male_avg_age_today
    self.female_avg_age = User.female_avg_age_today
  end

  def new_avg_age(prev_avg_age:, prev_count:, age_removed:)
    previous_total_age = prev_avg_age * prev_count
    current_total_age = previous_total_age - age_removed
    current_total_age/(prev_count - 1)
  end

  def set_new_avg_age(age_removed, gender)
    if gender == User::MALE_KEY
      avg_age = new_avg_age(prev_avg_age: self.male_avg_age,
        prev_count: self.male_count, age_removed: age_removed)
      self.male_avg_age = avg_age
      self.male_count -= 1
    else
      avg_age = new_avg_age(prev_avg_age: self.female_avg_age,
        prev_count: self.female_count, age_removed: age_removed)
      self.female_avg_age = avg_age
      self.female_count -= 1
    end
  end
end
