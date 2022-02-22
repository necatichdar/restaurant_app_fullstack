const db = require("../models");
const Image = db.image;
const Op = db.Sequelize.Op;

class ImageController {
    // Create and Save a new Image
    create = (req, res) => {
        // Validate request
        console.log("deneme");
        // Save Image in the database
        Image.create(req.body)
            .then(data => {
                res.send(data);
            })
            .catch(err => {
                console.log(err);
                res.status(500).send({
                    message:
                        err.message || "Some error occurred while creating the Image."
                });
            });
    };

    // Retrieve all Tutorials from the database.
    findAll = (req, res) => {
        // const title = req.query.title;
        // var condition = title ? { title: { [Op.like]: `%${title}%` } } : null;

        // Image.findAll({ where: condition })
        Image.findAll()
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
    // showid den tüm sezonları getirir
    findAllSeasons = (req, res) => {
        Image.findAll({
            where: {
                ShowID: req.params.show_id
            },
            order: [
                ['Season', "asc"],
            ],
            attributes: ['Season'],
            group: ['Season'],
            distinct: true,
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

    // Retrieve all Tutorials from the database.
    findAllEpisodes = (req, res) => {
        // const title = req.query.title;
        // var condition = title ? { title: { [Op.like]: `%${title}%` } } : null;

        // Image.findAll({ where: condition })
        Image.findAll({
            where: {
                ShowID: req.params.show_id,
                Season: req.params.seasons
            },
            order: [
                ['Episode', "asc"],
            ],
            attributes: ['Episode', 'EpisodeName', 'EpisodeNameTr'],
            group: ['Episode', 'EpisodeName', 'EpisodeNameTr'],
            distinct: true,
        }
        )
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


    // Retrieve all Tutorials from the database.
    findAllEpisodeImages = (req, res) => {
        // const title = req.query.title;
        // var condition = title ? { title: { [Op.like]: `%${title}%` } } : null;

        // Image.findAll({ where: condition })
        Image.findAll({
            where: {
                ShowID: req.params.show_id,
                Season: req.params.seasons,
                Episode: req.params.episode
            },
            order: [
                ['Time', "asc"],
            ],
            distinct: true,
        }
        )
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

    // Retrieve all Tutorials from the database.
    findTitle = (req, res) => {
        const title = req.params.title;
        console.log(title);
        var condition = title ? { title: { [Op.like]: `%${title}%` } } : null;

        Image.findAll({ where: condition })
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

    // Find a single Image with an id
    findOne = (req, res) => {
        const id = req.params.id;

        Image.findByPk(id)
            .then(data => {
                if (data) {
                    res.send(data);
                } else {
                    res.status(404).send({
                        message: `Cannot find Image with id=${id}.`
                    });
                }
            })
            .catch(err => {
                res.status(500).send({
                    message: "Error retrieving Image with id=" + id
                });
            });
    };

    // Update a Image by the id in the request
    update = (req, res) => {
        const id = req.params.id;

        Image.update(req.body, {
            where: { id: id }
        })
            .then(num => {
                if (num == 1) {
                    res.send({
                        message: "Image was updated successfully."
                    });
                } else {
                    res.send({
                        message: `Cannot update Image with id=${id}. Maybe Image was not found or req.body is empty!`
                    });
                }
            })
            .catch(err => {
                res.status(500).send({
                    message: "Error updating Image with id=" + id
                });
            });
    };

    // Delete a Image with the specified id in the request
    delete = (req, res) => {
        const id = req.params.id;

        Image.destroy({
            where: { id: id }
        })
            .then(num => {
                if (num == 1) {
                    res.send({
                        message: "Image was deleted successfully!"
                    });
                } else {
                    res.send({
                        message: `Cannot delete Image with id=${id}. Maybe Image was not found!`
                    });
                }
            })
            .catch(err => {
                res.status(500).send({
                    message: "Could not delete Image with id=" + id
                });
            });
    };

    // Delete all Tutorials from the database.
    deleteAll = (req, res) => {
        Image.destroy({
            where: {},
            truncate: false
        })
            .then(nums => {
                res.send({ message: `${nums} Tutorials were deleted successfully!` });
            })
            .catch(err => {
                res.status(500).send({
                    message:
                        err.message || "Some error occurred while removing all tutorials."
                });
            });
    };

    // find all published Image
    findAllPublished = (req, res) => {
        Image.findAll({ where: { isBanned: 0 } })
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

module.exports = new ImageController()