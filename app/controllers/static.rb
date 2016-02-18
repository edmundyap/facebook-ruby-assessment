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
		redirect '/user_profile'
	else
		redirect '/'
	end
end

post '/logout' do
  @current_user = session[:current_user_id] = nil

  redirect '/'
end

get '/user_profile' do
	@all_user = User.show_users

	erb :"static/user_profile"
end

get '/users/:user_id/post/new' do 

	erb :"static/create_post"
end

post '/users/:user_id/post' do
	
	@new_post = Post.new(user_id: params[:user_id], post_text: params[:post])
  @new_post.save

	redirect '/user_profile'
end

get '/users/:user_id/post/:post_id' do
	@show_post = Post.find(params[:post_id])

	erb :"static/see_post"
end

get '/users/:user_id/post/:post_id/edit' do
	@user_post = Post.find(params[:post_id])

	erb :"static/edit_post"
end

post '/users/:user_id/post/:post_id' do
	@user_post = Post.find(params[:post_id])
	@user_post.update(post_text: params[:post_text])
	
	redirect '/user_profile'
end 

post '/users/:user_id/post/:post_id/destroy' do
	@user_post = Post.find(params[:post_id])
	@user_post.destroy

	redirect '/user_profile'
end

get '/post/:post_id/comment/new' do 
	@post = Post.find(params[:post_id])

	erb :"static/create_comment"
end

post '/post/:post_id/comment' do
	# @user = User.find(session[:current_user_id])
	@user = current_user
	@comment_on_post = @user.comments.new(post_id: params[:post_id], comment_text: params[:comment])
  @comment_on_post.save

	redirect '/user_profile'
end

get '/post/:post_id/comment' do
	@post = Post.find(params[:post_id])
	@comments = @post.comments.all
	erb :"static/see_comments"
end

post '/post/:post_id/comment/:comment_id/destroy' do
	@comment = Comment.find(params[:comment_id])
	@post = @comment.post
	@comment.destroy
	@comments = @post.comments.all
	erb :"static/see_comments"
end

get '/post/:post_id/comment/:comment_id/edit' do
	@comment = Comment.find(params[:comment_id])
	@post = @comment.post
	erb :"static/edit_comment"
end

post '/post/:post_id/comment/:comment_id' do
	@user_comment = Comment.find(params[:comment_id])
	@user_comment.update(comment_text: params[:comment_text])

	redirect "/users/#{current_user.id}/post/#{@user_comment.post_id}"
end
