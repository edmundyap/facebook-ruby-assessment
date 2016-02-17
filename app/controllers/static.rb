get '/' do
	erb :"static/index"
end

post '/signup' do
	@user = User.new(params[:user])

	if @user.save
		redirect'/'
	else
		redirect '/'
	end
end

post '/login' do
	if @user_login = User.authenticate(params[:user][:email], params[:user][:password])

		session[:current_user_id] = @user_login.id
		@all_user = User.show_users
		erb :"static/user_profile"
	else
		redirect '/'
	end
end

post '/logout' do
  @current_user = session[:current_user_id] = nil
  redirect '/'
end

get '/users/:user_id/post/new' do 
	erb :"static/create_post"
end

post '/users/:user_id/post' do
	@all_user = User.show_users
	@new_post = Post.new(user_id: params[:user_id], post_text: params[:post])
  @new_post.save
	erb :"static/user_profile"
end

get '/users/:user_id/post/:post_id/edit' do
	@user_post = Post.find(params[:post_id])
	erb :"static/specific_posts"
end