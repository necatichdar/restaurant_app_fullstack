const express = require('express');
const Middleware = require('../middleware/index.js');
const RestoranValidator = require("../validation/restoran.validate")
const router = express.Router()
const RestoranController = require("../controllers/restoran.controller.js");

router.post("/", RestoranValidator.checkCreateRestoran(), Middleware.handlerValidationError, RestoranController.create);
router.get("/", RestoranController.findAll);
router.get("/admin", RestoranController.adminAll);
router.get("/admin/:role/:id/:status", RestoranController.adminChangeStatus);
router.get("/:id", RestoranController.findOne);

module.exports = router