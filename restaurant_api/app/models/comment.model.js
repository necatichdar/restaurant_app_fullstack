module.exports = (sequelize, Sequelize) => {
    const Comment = sequelize.define("comment", {
        comment_id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        comment: {
            type: Sequelize.STRING,
            allowNull: false,
        },
        username: {
            type: Sequelize.STRING,
            allowNull: false,
        },
        rating: {
            type: Sequelize.DOUBLE,
            allowNull: false,
        },
        status: {
            type: Sequelize.BOOLEAN,
            defaultValue: false,
        },
    });

    return Comment;
};