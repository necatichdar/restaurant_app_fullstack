const { user } = require("../models");
const db = require("../models");
const Comment = db.comment;
const Image = db.image;
const Op = db.Sequelize.Op;

class CommentController {
    // Create and Save a new Comment
    create = async (req, res) => {
        console.log("1");
        var data = await Comment.findAll({
            where: {
                user_id: req.body.user_id,
                restoran_id: req.body.restoran_id,
            }
        })
        if (data.length > 0) {
            return res.status(200).send({
                message: "Onay bekleyen gönderiniz bulunmaktadır!",
            });
        }
        console.log("2");
        var base64 = req.body.imagePath
        if (req.body.imagePath != "") {
            // Unique isim olusturma
            var timestamp = new Date().toISOString().replace(/[-:.]/g, "");
            var random = ("" + Math.random()).substring(2, 8);
            var random_number = timestamp + random;

            // Dosya kaydetme
            try {
                require("fs").writeFile(`./public/resimler/${random_number}.png`, base64, 'base64', function (err) { });
                console.log("h burda");
                var imagePath = `/resimler/${random_number}.png`
                await Image.create({
                    image_path: imagePath,
                    user_id: req.body.user_id,
                    restoran_id: req.body.restoran_id,
                })
            } catch (error) {
            }
        }
        console.log("3");
        Comment.create(req.body)
            .then(data => {
                res.send(data);
            })
            .catch(err => {
                console.log(err);
                res.status(500).send({
                    message:
                        err.message || "Some error occurred while creating the Comment."
                });
            });
    };

    // Retrieve all Tutorials from the database.
    findAll = (req, res) => {
        // const title = req.query.title;
        // var condition = title ? { title: { [Op.like]: `%${title}%` } } : null;

        // Comment.findAll({ where: condition })
        Comment.findAll()
            .then(data => {
                res.send(data);
            })
            .catch(err => {
                res.status(500).send({
                    message:
                        err.message || "Some error occurred while retrieving tutorials."
                });
            });
    };


}

module.exports = new CommentController()