var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var UserSchema = new Schema({
  id: String,
  name : String,
  email : String,
  phone : String,
  rate : Number,
  img : String
});

module.exports = mongoose.model("User", UserSchema)
