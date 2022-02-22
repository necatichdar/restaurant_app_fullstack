const { body, param, query } = require("express-validator")

class RestoranValidator {
    checkCreateRestoran() {
        return [
            body('name')
                .notEmpty()
                .withMessage('name boş olamaz!'),
            body('description')
                .notEmpty()
                .withMessage('description boş olamaz!'),
            body('lat')
                .notEmpty()
                .withMessage('lat boş olamaz!'),
            body('long')
                .notEmpty()
                .withMessage('long boş olamaz!'),
        ]
    }
}

module.exports = new RestoranValidator()