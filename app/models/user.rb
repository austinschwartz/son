class User < ActiveRecord::Base
  def self.create_with_omniauth(auth)
    p "ASDASDASD"
    p auth
    p "ASDASDASD"
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end
end
