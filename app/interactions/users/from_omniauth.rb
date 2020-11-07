module Users
  class FromOmniauth < ActiveInteraction::Base
    object :auth, class: OmniAuth::AuthHash

    def execute
      user = User.find_or_initialize_by(provider: auth[:provider], uid: auth[:uid])
      user.name = auth.info.name
      user.email = auth.info.email

      user.save
      user
    end
  end
end

