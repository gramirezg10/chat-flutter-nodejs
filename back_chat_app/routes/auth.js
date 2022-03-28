// path: 'api/login' pos

const { Router } = require('express');
const { check } = require('express-validator');
const {createUser, login, renewTkn} = require('../controllers/auth');
const { validarCampos } = require('../middlewares/validar-campos');
const validateJWT = require('../middlewares/validar-jwt');

const router = Router();

router.post('/new', [
  check('username', 'username is required').notEmpty(),
  check('email', 'email is required and must be email format').isEmail(),
  check('password', 'password is required').notEmpty(),
  validarCampos
], createUser);

router.post ('/', [
  check('email', 'email is required and must be email format').isEmail(),
  check('password', 'password is required').notEmpty(),
  validarCampos
], login);

router.get('/renew', [validateJWT], renewTkn);

module.exports = router;