var express = require("express");
var path = require("path");
var bodyParser = require("body-parser");
var mongodb = require("mongodb");
var ObjectID = mongodb.ObjectID;
var mongoose = require('mongoose');
var passport = require('passport');
var LocalStrategy = require('passport-local').Strategy;

var User = require('./models/User');
var Character = require('./models/Character');

var app = express();
app.use(express.static(__dirname + "/public"));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(passport.initialize());
app.use(passport.session());
app.use(app.router);

mongoose.connect(process.env.MONGOLAB_URI);
mongoose.connection.on('error', function() {
	console.log('MongoDB Connection Error. Please make sure that MongoDB is running.');
	process.exit(1);
    });

mongoose.connection.on("connected", function(ref) {
	console.log("Connected to  DB!");
  
	port = process.env.port || 3000;
	ip = process.env.ip;
  
	app.listen(port, ip, function() {
		console.log('listening on port ' + port);
	    });
    });

// CONTACTS API ROUTES BELOW
// Generic error handler used by all endpoints.
function handleError(res, reason, message, code) {
    console.log("ERROR: " + reason);
    res.status(code || 500).json({"error": message});
};

//POST request to login 
//if succeeds will say "Successfully authenticated"
//if not will say "Failure to authenticate"
app.post('/login', 
	 passport.authenticate('local', {
		 successRedirect: '/loginSuccess', 
	       failureRedirect: '/loginFailure'
		     }));

app.get('/loginSuccess', isLoggedIn, function(req, res, next) {
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

app.post('/newuser', function(req, res) {
	var newuser = new User({
		username: req.body.username,
		password: req.body.password
	    });
	newuser.save(function(err, newuser) {
		if (err) {
		    console.log(err);
		    return res.send(err);
		}
		else{
		    passport.authenticate('local')(req, res, function () {
			    res.redirect('/login');
			});
		}
	    });
    });

//retrieve user spell data
app.get('/users', isLoggedIn, function(req, res) {
	User.findOne({username: req.body.username}, function(err, user) {
		if(err) {
		    return res.send(err);
		}
		character.findOne({user: user.id}, function(err, character) {
			res.send(character);
		    });
	    });
    });

//save user spell data
app.post('/users', isLoggedIn, function(req, res){
	User.findOne({username: req.body.username}, function(err, user){
		if(err) return res.send(err);
	    });
        var newcharacter = new Character({
		user: user.id,
		character: req.body.character,
		classlevel: req.body.classlevel,
		stats: req.body.stats,
		spells: req.body.spells,
		slots: req.body.slots
            });
	Character.findOne({user: user.id}, function(err, character) {
		if(err){	
		    newcharacter.save(function(err, newuser) {
			    if (err) {
				console.log(err);
				return res.send(err);
			    }
			    return res.send("Saved new character");
			});
		}
		else {
		    newcharacter.findOneAndUpdate({user: user.id}, function(err, newuser) {
			    if (err) return res.send(err);
			    return res.send("Successfully updated");
			});
		}
	    });
    });
	


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

    return res.send("Not logged in\n");
    }

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