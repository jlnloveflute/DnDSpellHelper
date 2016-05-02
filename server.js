var express = require("express");
var path = require("path");
var bodyParser = require("body-parser");
var mongodb = require("mongodb");
var ObjectID = mongodb.ObjectID;
//var mongoose = require('mongoose');
//var passport = require('passport');
//var LocalStrategy = require('passport-local').Strategy;
//var flash = require('connect-flash');
var CONTACTS_COLLECTION = "contacts";

//var request = require('request');
//var User = require('../models/User');
//var passportConfig = require('./config/passport');
var app = express();
app.use(express.static(__dirname + "/public"));
app.use(bodyParser.json());
//app.use(passport.initialize());
//app.use(passport.session());
//app.use(app.router);

/*mongoose.connect(process.env.MONGOLAB_URI);
mongoose.connection.on('error', function() {
	console.log('MongoDB Connection Error. Please make sure that MongoDB is running.');
	process.exit(1);
    });

var Schema = mongoose.Schema;
var UserDetail = new Schema({
	username: String,
	password: String
    }, {
	collection: 'userInfo'
    });
var UserDetails = mongoose.model('userInfo', UserDetail);
*/
// Create a database variable outside of the database connection callback to reuse the connection pool in your app.
var db;

// Connect to the database before starting the application server.
mongodb.MongoClient.connect(process.env.MONGODB_URI, function (err, database) {
	if (err) {
	    console.log(err);
	    process.exit(1);
	}

	// Save database object from the callback for reuse.
	db = database;
	console.log("Database connection ready");

	// Initialize the app.
	var server = app.listen(process.env.PORT || 8080, function () {
		var port = server.address().port;
		console.log("App now running on port", port);
	    });
    });

// CONTACTS API ROUTES BELOW
// Generic error handler used by all endpoints.
function handleError(res, reason, message, code) {
    console.log("ERROR: " + reason);
    res.status(code || 500).json({"error": message});
}

/*
//POST request to login 
//if succeeds will say "Successfully authenticated"
//if not will say "Failure to authenticate"
app.post("/login", 
	 passport.authenticate('local', function(err, user, info){
		 successRedirect: '/loginSuccess',
		 failureRedirect:'/loginFailure'
		     })
	 );

app.get('/loginSuccess', function(req, res, next) {
	res.send('Successfully authenticated');
    });
app.get('/loginFailure', function(req, res, next) {
	res.send('Failure to authenticate');
    });
passport.serializeUser(function(user, done) {
	done(null, user.id);
    });
passport.deserializeUser(function(user, done) {
	User.findById(id, function(err, user) {	
		done(null, user);
	    });
    });

//use this strategy to determine
passport.use(new LocalStrategy(function(username, password, done) {
	    User.findOne(function(err, user) {
		    if (!user) {
			return done(null, false, { msg: 'No such user.'});
		    }
		    user.comparePassword(password, function(err, isMatch) {
			    if (isMatch) {
				return done(null, user);
			    } else {
				return done(null, false, { msg: 'Invalid password.' });
			    }
			});
		});
}));


///****how to do here????
app.post('/newuser', function(req, res) {
	User.register(new Account({ username : req.body.username }), req.body.password, function(err, account) {
		if (err) {
		    return res.render('register', { account : account });
		}

		passport.authenticate('local')(req, res, function () {
			res.redirect('/');
		    });
	    });
    });


//when want to create new user, make a POST request to /newuser
app.post('/newuser', function(req, res) {
	var newUser = new User();
	newUser.local.username = username;
	newUser.local.password = password;
	newUser.save(function(err) {
		if(err)
		    throw err;
		return done(null, newUser);
	    });

    });
*/


// we will use route middleware to verify this (the isLoggedIn function)
/*app.get('/users/:username', isLoggedIn, function(req, res){
	//req.params.username
	});*/



app.post('/users/:username', function(req, res){
    
});
/*
//logout
app.get('/logout', function(req, res) {
	req.logout();
	res.redirect('/');
    });

// route middleware to make sure a user is logged in
function isLoggedIn(req, res, next) {

    // if user is authenticated in the session, carry on 
    if (req.isAuthenticated())
        return next();

    // if they aren't redirect them to the home page
    res.redirect('/');
    }*/

//when it gets a GET request for spells
//query MUST be /spells/*classname*/*level* where ** is variables
app.get('/spells/:classname/:level', function(req,res) {
        var fs = require("fs");
        var spellstring = fs.readFileSync("DnDspells.json");
        var spellsJSON = JSON.parse(spellstring); //convert to json
        //traverse through JSON
        for(var i = 0; i< spellsJSON.length; i++){
            //if meets requirements print them out
            classes = spellsJSON[i]["class"];
            if(classes.search(req.params.classname)== -1)
                delete spellsJSON[i];
            else if(spellsJSON[i]["level"] > req.params.level)
                delete spellsJSON[i];
        }
        // Iterate the array from back to front, removing null entries
        for (var i=spellsJSON.length;i--;){
            if (spellsJSON[i]==null) spellsJSON.splice(i,1);
        }
        res.send(spellsJSON);
    });