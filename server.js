var express = require("express");
var path = require("path");
var bodyParser = require("body-parser");
var mongodb = require("mongodb");
var ObjectID = mongodb.ObjectID;

var CONTACTS_COLLECTION = "contacts";

var app = express();
app.use(express.static(__dirname + "/public"));
app.use(bodyParser.json());

// Create a database variable outside of the database connection callback to reuse the connection pool in your app.
//var db;

//testing
var mongoose = require("mongoose");
var db = mongoose.createConnection('mongodb://derp:dnd97531@ds021711.mlab.com:21711/dndhelper');
//emd

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

/*  "/contacts"
 *    GET: finds all contacts
 *    POST: creates a new contact
 */

app.get("/contacts", function(req, res) {
    });

app.post("/contacts", function(req, res) {
    });

/*  "/contacts/:id"
 *    GET: find contact by id
 *    PUT: update contact by id
 *    DELETE: deletes contact by id
 */

app.get("/contacts/:id", function(req, res) {
    });

app.put("/contacts/:id", function(req, res) {
    });

app.delete("/contacts/:id", function(req, res) {
    });
//when it gets a GET request for spells                                                                                               
//query MUST be /spells/*classname*/*level* where ** is variables                                                                     
app.get('/spells/:classname/:level', function(req,res) {
        //var spellstring = require("../spells"); //read in things from ../spells as a string                                         
        //console.log(spellstring);                                                                                                   
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