module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Tracker").join(" - ")
      end
    end
  end

  def admins_only(&block)
    block.call if current_user.try(:admin?)
  end

  def authorized?(permission, thing, &block)
    block.call if can?(permission.to_sym, thing) || current_user.try(:admin?)
  end
end

class User::ParameterSanitizer < Devise::ParameterSanitizer
  def sign_in
    default_params.permit(:firstname, :lastname, :email)
  end
end

class Admin::ParameterSanitizer < Devise::ParameterSanitizer
  def sign_in
    default_params.permit(:firstname, :lastname, :email, :admin)
  end
end
