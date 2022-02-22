module.exports = (sequelize, Sequelize) => {
    const Restoran = sequelize.define("restoran", {
        restoran_id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        name: {
            type: Sequelize.STRING,
            allowNull: false,
        },
        description: {
            type: Sequelize.STRING,
            allowNull: false,
        },
        lat: {
            type: Sequelize.STRING,
            allowNull: false,
        },
        long: {
            type: Sequelize.STRING,
            allowNull: false,
        },
        status: {
            type: Sequelize.BOOLEAN,
            defaultValue: false,
        },
    });

    return Restoran;
};