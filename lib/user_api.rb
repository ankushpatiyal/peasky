class UserApi
  BASE_URL = 'https://randomuser.me'
  LIMIT = 20

  def self.fetch_users
    url = "#{BASE_URL}/api/?results=#{LIMIT}"
    response = Faraday.get(url)
    
    raise "API Error: #{response.code}" unless response.success?
    JSON.parse(response.body)
  end
end