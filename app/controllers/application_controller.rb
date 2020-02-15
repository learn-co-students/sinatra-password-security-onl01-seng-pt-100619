require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

	configure do
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
	end

	helpers do

		def current_user
		  @current_user ||= User.find_by(id: session[:user_id])
		end
	
		def logged_in?
		  !!current_user
		end
	
	  end

	get "/" do
		erb :index
	end

	get "/signup" do
		erb :signup
	end

	post "/signup" do
		#your code here!
		user = User.new(username: params[:username], password: params[:password])
		if user.save
			redirect "/login"
		  else
			redirect "/failure"
		  end
		session[:user_id] = @user.id
	end

	get "/login" do
		erb :login
	end

	post "/login" do
		user = User.find_by(:username => params[:username])
		if user && user.authenticate(params[:password])
		  session[:user_id] = user.id
		  redirect "/success"
		else
		  redirect "/failure"
		end
	  end

	get "/success" do
		user = User.find_by(:username => params[:username])
		erb :success
	end

	get "/failure" do
		erb :failure
	end

	get "/logout" do
		session.clear
		redirect "/"
	end

	

end
