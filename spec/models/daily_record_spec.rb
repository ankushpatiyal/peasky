require 'rails_helper'

RSpec.describe DailyRecord, type: :model do
  let(:daily_record_obj) {DailyRecord.create(male_count: 3, female_count: 4, male_avg_age: 50, female_avg_age: 20)}
  let!(:user1) { User.create(name: 'foo', age: 16, gender: User::MALE_KEY) }
  let!(:user2) { User.create(name: 'bar', age: 20, gender: User::FEMALE_KEY) }

  describe '#set_avg_age' do
    it 'should set average age of male and female that came in today' do
      subject.set_avg_age

      expect(subject.male_avg_age).to eq(16)
      expect(subject.female_avg_age).to eq(20)
    end
  end

  describe '.new_avg_age' do
    it 'should calculate new avg age if we remove any user' do
      rs = daily_record_obj.new_avg_age(prev_avg_age: 100, prev_count: 5, age_removed: 20)

      expect(rs).to eq(120)
    end
  end

  describe '#set_new_avg_age' do
    it 'should set new avg age based on gender' do
      daily_record_obj.set_new_avg_age(50, User::MALE_KEY)

      expect(daily_record_obj.male_avg_age).to eq(50)
      expect(daily_record_obj.male_count).to eq(2)
    end
  end

  describe '#update_users' do
    it 'should update users if daily_record object is created' do
      user = User.create
      daily_record = DailyRecord.create

      expect(user.reload.daily_record_id).to be(daily_record.id)
    end
  end
end