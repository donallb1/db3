(function() { // We use this anonymous function to create a closure.

	var app = angular.module('splatter-web', ['ngResource']);
	
	app.config(['$httpProvider', function($httpProvider) {
		$httpProvider.defaults.headers.common = {};
		$httpProvider.defaults.headers.post = {};
		$httpProvider.defaults.headers.put = {};
	}]);
	
	app.factory('User', function($resource) {
		return $resource('http://donald.sqrawler.com/api/users/:id.json', {} , {update:{method:'PUT',url:'http://donald.sqrawler.com/api/users/:id.json'}});
	});
	
	app.factory('Splatt', function($resource) {
		return $resource('http://donald.sqrawler.com/api/splatts/:id.json');
	});
	
	app.factory('ViewSplatt', function($resource) {
		return $resource('http://donald.sqrawler.com/api/users/splatts/:id.json');
	});
	
	app.factory('FollowUser', function($resource) {
		return $resource('http://donald.sqrawler.com/api/users/follows');
	});

	app.factory('UnFollowUser', function($resource) {
		return $resource('http://donald.sqrawler.com/api/users/follows/:id/:follows_id.json');
	});
	
	//////////////////////////////////////////////////////////////////////
	//							Create User								//
	//////////////////////////////////////////////////////////////////////
	
	app.controller('AddUserController', function(User) {	//User is the name of the factory being passed in
		
		this.data = {};
		this.createUser = function(user) {
			var dataUserName = this.data.userName;
			var dataEmail = this.data.email;
			var dataPassword = this.data.password;
			
			user = new User.save({name: dataUserName, email: dataEmail, password: dataPassword}, user);
			
			//user = new User({name: dataUserName, email: dataEmail, password: dataPassword});
			//User.save(user,user);
			
			this.data = {} //clears the form
		}
	});
	
	//////////////////////////////////////////////////////////////////////
	//							User Login								//
	//////////////////////////////////////////////////////////////////////
	
	app.controller('LogInController', function(User) {
	
		this.data = {};
		var self = this;
		this.logInForm = function() {
			var dataUserID = this.data.userID;
			
			self.user = User.get({id: dataUserID});
		}
	});
	
	//////////////////////////////////////////////////////////////////////
	//							Edit User								//
	//////////////////////////////////////////////////////////////////////
	
	app.controller("EditUserController", function(User){
		this.data = {};
		this.EditUser = function() {
			var dataUserID = this.data.userid;
			var dataName = this.data.name;
			var dataBlurb = this.data.blurb;

			User.update({id: this.data.userid}, {user:{name: dataName, blurb: dataBlurb}});

		this.data = {};
		}
	});
		
	//////////////////////////////////////////////////////////////////////
	//							Create Splatt							//
	//////////////////////////////////////////////////////////////////////
	
	app.controller("NewSplattController", function(Splatt){
		this.data = {};
		this.newSplatt = function(splatt) {
			var dataUserID = this.data.userID;
			var dataMessage = this.data.message;
			
		splatt = new Splatt({body: dataMessage, user_id: dataUserID});
		
		Splatt.save(splatt,splatt);				
		
		this.data = {}; // clears the form
		}
	});
	
	//////////////////////////////////////////////////////////////////////
	//							Display Splatts							//
	//////////////////////////////////////////////////////////////////////
	
	app.controller("DisplaySplattsController", function(ViewSplatt,User){
		this.data = {};
		var self = this;
		this.findSplatts = function() {
			var	dataUserID = parseInt(this.data.userid);
			self.splatts = ViewSplatt.query({id: dataUserID});
			self.user = User.get({id: dataUserID});
		}
			
	});
	
	//////////////////////////////////////////////////////////////////////
	//							Follow User								//
	//////////////////////////////////////////////////////////////////////
	
	app.controller("followUserController", function(FollowUser){
		this.data = {};
		this.followUser = function(add_follows) {
			var dataUserID = this.data.userID;
			var dataFollowerID = this.data.followerID;

		add_follows = new FollowUser({id: dataUserID,follows_id: dataFollowerID});
			
		FollowUser.save(add_follows,add_follows);
		
			this.data = {};
		}
	});
	
	//////////////////////////////////////////////////////////////////////
	//							Unfollow a User							//
	//////////////////////////////////////////////////////////////////////
	
	app.controller("unfollowUserController", function(UnFollowUser){
		this.data = {};
		var self = this;
		this.unfollowUser = function() {
			var	UserID = this.data.userID;
			var FollowerID = this.data.followerID;

			self.unfollowUser = UnFollowUser.remove({id: UserID, follows_id: FollowerID});
		}
	});
	
	//////////////////////////////////////////////////////////////////////
	//							Delete User								//
	//////////////////////////////////////////////////////////////////////
	
	app.controller("DeleteUserController", function(User){
		this.data = {};
		this.DeleteUser = function() { 
			var	deleteUserID = this.data.userDeleteID;
			this.user = User.remove({id: deleteUserID});
		}
			
	});
	
})();
