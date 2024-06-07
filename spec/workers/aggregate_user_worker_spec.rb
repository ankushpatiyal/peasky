RSpec.describe AggregateUserWorker do
  describe '.perform' do
    it 'should call the expected method' do
      expect(AggregateUserService).to receive(:call)

      AggregateUserWorker.new.perform
    end
  end
end