require 'rails_helper'

RSpec.describe AggregateUserService do
  let(:user_response) {{"results":[{"gender":"male","name":{"title":"Mr","first":"Jacob","last":"Madsen"},"location":{"city":"Sundby/Erslev","state":"Danmark","country":"Denmark"},"email":"jacob.madsen@example.com","login":{"uuid":"576cbd03-ea21-47b6-86bd-6eb5375bc2e4","username":"sadsnake493"},"dob":{"date":"1997-02-10T13:53:07.690Z","age":27}}]}.with_indifferent_access}
  let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }

  describe '#call' do
    it 'should execute methods in order' do
      expect(subject).to receive(:create_daily_record)

      subject.call
    end

    it 'should read data from rails cache' do
      allow(Rails).to receive(:cache).and_return(memory_store)
      expect(Rails.cache).to receive(:read).with(User.male_key)
      expect(Rails.cache).to receive(:read).with(User.female_key)

      subject.call
    end
  end

  describe '#create_daily_record' do
    it 'should create new daily_record' do
      expect{ AggregateUserService.call }.to change { DailyRecord.count }.by(1)
    end
  end
end