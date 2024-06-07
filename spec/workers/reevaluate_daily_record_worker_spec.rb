require 'rails_helper'

RSpec.describe ReevaluateDailyRecordWorker do
  let!(:daily_record) { DailyRecord.create(created_at: DateTime.yesterday, male_avg_age: 100, male_count: 2) }

  describe '.perform' do
    it 'should create update daily record' do
      ReevaluateDailyRecordWorker.new.perform(User::MALE_KEY, 10, daily_record.id)
      
      expect(daily_record.reload.male_avg_age).to eq(190)
    end
  end
end