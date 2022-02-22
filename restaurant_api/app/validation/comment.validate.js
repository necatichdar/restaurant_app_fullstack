const { body, param, query } = require("express-validator")

class CommentValidator {
    checkCreateComment() {
        return [
            body('restoran_id')
                .notEmpty()
                .withMessage('restoran_id boş olamaz!'),
            body('user_id')
                .notEmpty()
                .withMessage('user_id boş olamaz!'),
            body('comment')
                .notEmpty()
                .withMessage('comment boş olamaz!'),
            body('username')
                .notEmpty()
                .withMessage('username boş olamaz!'),
            body('rating')
                .notEmpty()
                .withMessage('rating boş olamaz!'),
        ]
    }
}

module.exports = new CommentValidator()