require 'rails_helper'

RSpec.describe User, type: :model do
  let(:current_date) { Date.today.to_s }
  let!(:user1) { User.create(name: 'abc', age: 2, gender: User::MALE_KEY) }
  let!(:user2) { User.create(name: 'abc', age: 6, gender: User::FEMALE_KEY) }
  let!(:user3) { User.create(name: 'abc', age: 8, gender: User::FEMALE_KEY) }

  describe '.male_key' do
    it 'should return key with current date and along with male_key' do
      expect(User.male_key).to eq(current_date + User::MALE_KEY)
    end
  end

  describe '.female_key' do
    it 'should return key with current date and along with female_key' do
      expect(User.female_key).to eq(current_date + User::FEMALE_KEY)
    end
  end

  describe '.male_avg_age_today' do
    it 'should return average age of male user that were created today' do
      expect(User.male_avg_age_today).to eq(2)
    end
  end

  describe '.female_avg_age_today' do
    it 'should return average age of female user that were created today' do
      expect(User.female_avg_age_today).to eq(7)
    end
  end

  describe '#reevaluate_daily_record' do
    it 'should schedule a job' do
      expect(ReevaluateDailyRecordWorker).to receive(:perform_async)

      user1.reevaluate_daily_record
    end
  end
end