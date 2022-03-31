const {response} = require('express');
const bcrypt = require('bcryptjs');
const User = require('./../models/user');
const { generateJWT } = require('../helpers/jwt');

const createUser = async (req, res = response) => {
  const { email, password } = req.body;

  try {
    const emailExists = await User.findOne({email});
    if (emailExists) {
      return res.status(400).json({
        ok: false,
        msg: 'email exists'
      });
    }

    const user = new User(req.body);
    // encriptar la contraseña
    const salt = bcrypt.genSaltSync();
    user.password = bcrypt.hashSync(password, salt)
    // 
    await user.save();
    // generate jwt
    const token = await generateJWT(user._id)
    //  

    res.json({
      ok: true,
      user,
      token
    });    
  } catch (error) {
    console.log(error);
    res.status(500).json({
      ok: false,
      msg: 'error con la base de datos'
    });
  }
}

const login = async (req, res = response) => {
  const { email, password } = req.body;
  try {
    const userDB = await User.findOne({email});
    if (!userDB) {
      return res.status(404).json({
        ok: false,
        msg: 'email not found'
      });
    }
    // validate password
    const validPassword = bcrypt.compareSync(password, userDB.password);
    if (!validPassword) {
      return res.status(400).json({
        ok: false,
        msg: 'invalid password'
      });
    }
    const token = await generateJWT(userDB._id)
    return res.json({
      ok: true,
      user: userDB,
      token
    });
    // 

    
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      ok: false,
      msg: 'error en la autenticación'
    });
    
  }
}

const renewTkn = async(req, res = response) => {
  const uid = req.uid

  const newToken = await generateJWT(uid);

  const user = await User.findById(uid);
  
  return res.json({
    ok: true,
    user,
    token: newToken
  }); 
}

module.exports = {
  createUser,
  login,
  renewTkn
};