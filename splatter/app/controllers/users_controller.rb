class UsersController < ApplicationController
	before_filter :set_headers
	
	####################################################################
	###############          Users Controller        ###################
	####################################################################
	
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
	db = UserRepository.new(Riak::Client.new)
	@user = db.find(params[:id])
	render json: @user
  end

  # POST /users
  # POST /users.json
  def create
	@user = User.new
	@user.email = params[:email]
	@user.name = params[:name]
	@user.password = params[:password]
	@user.blurb = params[:blurb]
	
	db = UserRepository.new(Riak::Client.new)
	if db.save(@user)
		render json: @user, status: :created, location: @user
	else
		render json: "error", status: :unprocessable_entity
	end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if @user.update(user_params(params))
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    head :no_content
  end
	
	def splatts
		@user = User.find(params[:id])
		
		render json: @user.splatts
	end
	
	def show_follows
		@user = User.find(params[:id])
		
		@user.follows
	end
	
	def show_followers
		@user = User.find(params[:id])
		
		@user.followed_by
	end
	
	def add_follows
		@follower = User.find(params[:id])
		@followed = User.find(params[:follows_id])          
		if
			@follower.follows << @followed
			head :no_content
		else
			render json: @follower.errors, status: :unprocessable_entity
		end
	end
	
	def delete_follows
		@follower = User.find(params[:id])
		@followed = User.find(params[:follows_id])
		
		@follower.follows.delete(@followed)
	end
	
	# GET /users.splatts-feed/1
	def splatts_feed
		#Select all from splatts table where user id is equal to User_ID
		@feed = Splatt.find_by_sql("SELECT splatts.user_id, splatts.body, splatts.created_at FROM splatts JOIN follows ON follows.followed_id = splatts.user_id WHERE follows.follower_id = #{params[:id]} ORDER BY splatts.created_at")
		
		render json: @feed
	end
	
	private
	
	def user_params(params)
		params.permit(:email, :password, :name, :blurb)
	end
	
	def set_headers
		response.headers['Access-Control-Allow-Origin'] = '*';
	end
end
