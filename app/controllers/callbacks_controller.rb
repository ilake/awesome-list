class CallbacksController < Devise::OmniauthCallbacksController
  def github
    outcome = ::Users::FromOmniauth.run(auth: request.env["omniauth.auth"])

    if outcome.valid?
      user = outcome.result
      sign_in(user)
    end

    redirect_to root_path
  end
end

