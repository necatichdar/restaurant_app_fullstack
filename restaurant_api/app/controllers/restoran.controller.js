const db = require("../models");
const Restoran = db.restoran;
const Op = db.Sequelize.Op;

class RestoranController {
    // Create and Save a new Restoran
    create = (req, res) => {
        // Validate request
        // Save Restoran in the database
        Restoran.create(req.body)
            .then(data => {
                res.send(data);
            })
            .catch(err => {
                console.log(err);
                res.status(500).send({
                    message:
                        err.message || "Some error occurred while creating the Restoran."
                });
            });
    };

    // Retrieve all Tutorials from the database.
    findAll = (req, res) => {
        // const title = req.query.title;
        // var condition = title ? { title: { [Op.like]: `%${title}%` } } : null;

        // Restoran.findAll({ where: condition })
        Restoran.findAll({ where: { status: true } })
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

    adminAll = async (req, res) => {
        var data = [];
        var restoranlar = await Restoran.findAll({ where: { status: false } })
        restoranlar.forEach(element => {
            data.push({
                id: element.restoran_id,
                title: element.name,
                description: element.description,
                role: "1"
            })
        });
        var yorumlar = await db.comment.findAll({ where: { status: false } })
        yorumlar.forEach(element => {
            data.push({
                id: element.comment_id,
                title: element.username,
                description: element.comment,
                role: "2"
            })
        });
        var resimler = await db.image.findAll({ where: { status: false } })
        resimler.forEach(element => {
            data.push({
                id: element.id,
                title: element.restoran_id.toString(),
                description: element.image_path,
                role: "3"
            })
        });
        res.send(data);
    };

    adminChangeStatus = async (req, res) => {
        var id = req.params.id;
        var role = req.params.role;
        var status = req.params.status;
        console.log(req.params);
        try {
            switch (role) {
                case "1":
                    console.log("rol 1");
                    if (status == true) {
                        console.log("bura");
                        await Restoran.update({ status: true }, { where: { restoran_id: id } });
                    } else {
                        console.log("bura22");
                        await Restoran.destroy({ where: { restoran_id: id } });
                    }
                    break;

                case "2":
                    console.log("rol 2");
                    if (status == true) {
                        await db.comment.update({ status: true }, { where: { comment_id: id } });
                    } else {
                        await db.comment.destroy({ where: { comment_id: id } });
                    }
                    break;


                case "3":
                    console.log("rol 3");
                    if (status == true) {
                        await db.image.update({ status: true }, { where: { id: id } });
                    } else {
                        await db.image.destroy({ where: { id: id } });
                    }
                    break;

                default:
                    console.log("default");
                    break;
            }
            res.send({ "message": "success" });
        } catch (error) {
            res.send({ "message": "hata" });
        }
    };

    // Find a single Restoran with an id
    findOne = (req, res) => {
        const id = req.params.id;
        Restoran.findAll({
            where: { restoran_id: id, },
            include: [
                {
                    model: db.comment, as: 'comments',
                },
                {
                    model: db.image, as: 'images'
                }],
        })
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

module.exports = new RestoranController()