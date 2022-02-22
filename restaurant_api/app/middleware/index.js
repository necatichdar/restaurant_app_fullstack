const { validationResult } = require('express-validator');

class Middleware {
    handlerValidationError(req, res, next) {
        const error = validationResult(req)
        if (!error.isEmpty()) {
            return res.json(error.array()[0]);
        }
        next()
    }
}


module.exports = new Middleware()