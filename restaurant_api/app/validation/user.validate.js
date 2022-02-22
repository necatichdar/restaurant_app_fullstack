const { body, param, query } = require("express-validator")

class UserValidator {
    checkCreateUser() {
        return [
            body('username')
                .notEmpty()
                .withMessage('username boş olamaz!'),
            body('mail')
                .notEmpty()
                .withMessage('mail boş olamaz!'),
            body('password')
                .notEmpty()
                .withMessage('password boş olamaz!'),
        ]
    }
}

module.exports = new UserValidator()