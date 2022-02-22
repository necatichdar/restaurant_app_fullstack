module.exports = (sequelize, Sequelize) => {
    const Image = sequelize.define("image", {
        image_path: {
            type: Sequelize.STRING,
            allowNull: false,
        },
        status: {
            type: Sequelize.BOOLEAN,
            defaultValue: false,
        },
    });

    return Image;
};