class User::ParameterSanitizer < Devise::ParameterSanitizer
    private
    def account_update
        default_params.permit(:firstname, :lastname, :email, :password, :password_confirmation, :current_password)
    end
end