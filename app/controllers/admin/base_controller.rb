class Admin::BaseController < ApplicationController
  before_filter :authorize_admin!

  def index
  end

  def devise_parameter_sanitizer
    if resource_class == User
      Admin::ParameterSanitizer.new(User, :user, params)
    else
      super # Use the default one
    end
  end
end