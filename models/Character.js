var mongoose = require('mongoose');

var charSchema = new mongoose.Schema({
        user: { type: String, unique: true },
        character: String,
	classlevel: [String],
	stats: [Number],
	spells: [{name: String, desc: String, level: Number, range: String, components: [String], duration: String, concentration: Boolean, casting_time: String, school: String, classes: [String], oaths: [String], ritual: Boolean, prepared: Boolean}],
	slots: [Number]
    });

var Character = mongoose.model('Character', charSchema);

module.exports = Character;

