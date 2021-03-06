const { Schema, model } = require('mongoose');

const UserSchema = Schema({
  username: {
    type: String,
    required: true
  },
  email: {
    type: String,
    required: true,
    unique: true
  },
  password: {
    type: String,
    required: true
  },
  online: {
    type: Boolean,
    default: false
  },
});

UserSchema.method('toJSON', function(){
  const {__v, _id, password, ...object} = this.toObject();
  object._uid = _id;
  return object;
});

module.exports = model('User', UserSchema);