class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  respond_to :json

  def authenticate_user
    if request.headers["Authorization"].present?
      debugger
      token = request.headers["Authorization"].split(" ").second
      self.current_user = Warden::JWTAuth::UserDecoder.new.call(token, :user, nil)
    end
  rescue JWT::DecodeError
    # ignore we want current_user to be nil
  end
end
