RSpec.describe UserWorker do
  describe '.perform' do
    it 'should call the expected method' do
      expect(UserService).to receive(:call)

      UserWorker.new.perform
    end
  end
end