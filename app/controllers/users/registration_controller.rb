class Users::RegistrationsController < Devise::RegistrationsController

 def sign_up_params
  devise_parameter_sanitizer.for(:sign_up).push(:name, :lastname)
 end

 def account_update_params
   devise_parameter_sanitizer.for(:account_update).push(:name,:lastname, :email, :password, :password_confirmation, :current_password)
 end
end