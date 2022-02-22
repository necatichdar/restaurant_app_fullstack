const db = require("../models");
const User = db.user;
const Op = db.Sequelize.Op;

class UserController {
    // Create and Save a new User
    create = (req, res) => {
        // Validate request
        console.log("deneme");
        // Save User in the database
        User.create(req.body)
            .then(data => {
                res.send(data);
            })
            .catch(err => {
                console.log(err.errors[0].message);

                res.status(500).send({
                    message:
                        err.errors[0].message || "Some error occurred while creating the User."
                });
            });
    };

    // Retrieve all Tutorials from the database.
    findAll = (req, res) => {
        // const title = req.query.title;
        // var condition = title ? { title: { [Op.like]: `%${title}%` } } : null;

        // User.findAll({ where: condition })
        User.findAll()
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

    findUser = (req, res) => {
        User.findAll({
            where: {
                mail: req.body.mail,
                password: req.body.password,
            },
        })
            .then(data => {
                console.log(data);
                data != null ? res.send(data[0]) : res.send(null);
                // res.send(data);
            })
            .catch(err => {
                res.status(500).send({
                    message:
                        err.message || "Some error occurred while retrieving tutorials."
                });
            });
    };


    banned = (req, res) => {
        const id = req.params.id;

        User.update({ status: false }, {
            where: { user_id: id }
        })
            .then(data => {
                res.send({
                    message: "User banned."
                });
            })
            .catch(err => {
                res.status(500).send({
                    message: "Error updating User with id=" + id
                });
            });
    };


}

module.exports = new UserController()