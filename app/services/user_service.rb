class UserService < BaseService
  def call
    @male_count = 0
    @female_count = 0
    fetch_users
    store_in_db
    update_data
  end

  def fetch_users
    @users = UserApi.fetch_users.fetch("results")
  end

  def store_in_db
    @users.each do |user_data|
      user = User.find_or_initialize_by(uuid: user_data.dig("login", "uuid"))

      user.gender = user_data.fetch("gender")
      user.name = user_name(user_data)
      user.location = user_data.fetch("location")
      user.age = user_data.dig('dob', 'age')

      user.save
      increase_gender_count(user)
    end
  end

  def user_name(user)
    name_obj = user.fetch('name')
    "#{name_obj.fetch('title')} #{name_obj.fetch('first')} #{name_obj.fetch('last')}"
  end

  def increase_gender_count(user)
    if user.gender == User::FEMALE_KEY
      @female_count += 1
    else
      @male_count += 1
    end
  end

  def update_data
    value = Rails.cache.read(User.male_key).to_i
    Rails.cache.write(User.male_key, value + @male_count)

    value = Rails.cache.read(User.female_key).to_i
    Rails.cache.write(User.female_key, value + @female_count)
  end
end