RSpec.describe UserService do
  let(:user_response) {{"results":[{"gender":"male","name":{"title":"Mr","first":"Jacob","last":"Madsen"},"location":{"city":"Sundby/Erslev","state":"Danmark","country":"Denmark"},"email":"jacob.madsen@example.com","login":{"uuid":"576cbd03-ea21-47b6-86bd-6eb5375bc2e4","username":"sadsnake493"},"dob":{"date":"1997-02-10T13:53:07.690Z","age":27}}]}.with_indifferent_access}

  describe '#call' do
    it 'should execute methods in order' do
      expect(subject).to receive(:fetch_users).and_return(user_response)
      expect(subject).to receive(:store_in_db)
      expect(subject).to receive(:update_data)

      subject.call
    end

    it 'should increase the count of user by 20', :vcr do
      expect { subject.call }.to change(User, :count).by(20)
    end
  end

  describe '#fetch_users' do
    it 'should call fetch user api' do
      expect(UserApi).to receive(:fetch_users).and_return(user_response)

      subject.fetch_users
    end
  end

  describe '#store_in_db' do
    it 'should call fetch user api' do
      allow(UserApi).to receive(:fetch_users).and_return(user_response)
      

      expect{ UserService.call }.to change { User.count }.by(1)
    end
  end

  describe '#user_name' do
    it 'should call fetch user api' do
      allow(UserApi).to receive(:fetch_users).and_return(user_response)
      

      expect(subject.user_name(user_response["results"][0])).to eq("Mr Jacob Madsen")
    end
  end
end