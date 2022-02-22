const express = require('express');
const Middleware = require('../middleware/index.js');
const CommentValidator = require("../validation/comment.validate")
const router = express.Router()
const CommentController = require("../controllers/comment.controller");

router.post("/", CommentController.create);
router.get("/", CommentController.findAll);

module.exports = router