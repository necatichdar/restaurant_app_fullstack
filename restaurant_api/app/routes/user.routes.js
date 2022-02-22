const express = require('express');
const Middleware = require('../middleware/index.js');
const UserValidator = require("../validation/user.validate")
const router = express.Router()
const UserController = require("../controllers/user.controller.js");

router.post("/", UserValidator.checkCreateUser(), Middleware.handlerValidationError, UserController.create);
router.post("/login", UserController.findUser);
router.get("/", UserController.findAll);
router.put("/:id", UserController.banned);

module.exports = router