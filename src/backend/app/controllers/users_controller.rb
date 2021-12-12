class UsersController < ApplicationController
 skip_before_action :authenticate_request

 def sign_up
   user = User.new(user_params)

   if user.save
     head 201
   else
     render json: { error: user.errors }, status: :bad_request
   end
 end

 def sign_in
   command = AuthenticateUser.call(user_params[:email], user_params[:password])

   if command.success?
     render json: { auth_token: command.result }
   else
     render json: { error: command.errors }, status: :unauthorized
   end
 end

 private

 def user_params
  params.require(:user).permit(:email, :password, :password_confirmation, :name)
 end
end
