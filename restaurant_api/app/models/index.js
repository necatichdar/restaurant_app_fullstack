const dbConfig = require("../config/db.config.js");

const Sequelize = require("sequelize");
const sequelize = new Sequelize(dbConfig.DB, dbConfig.USER, dbConfig.PASSWORD, {
  host: dbConfig.HOST,
  dialect: dbConfig.dialect,
  operatorsAliases: false,
  logging: false,
  define: {
    charset: 'utf8',
    collate: 'utf8_turkish_ci',
    timestamps: true
  },
  pool: {
    max: dbConfig.pool.max,
    min: dbConfig.pool.min,
    acquire: dbConfig.pool.acquire,
    idle: dbConfig.pool.idle
  }
});

const db = {};

db.Sequelize = Sequelize;
db.sequelize = sequelize;

db.user = require("./user.model.js")(sequelize, Sequelize);
db.restoran = require("./restoran.model.js")(sequelize, Sequelize);
db.comment = require("./comment.model.js")(sequelize, Sequelize);
db.image = require("./image.model.js")(sequelize, Sequelize);

db.user.hasMany(db.comment, { as: "comments", foreignKey: { name: 'user_id', allowNull: false }, });
db.restoran.hasMany(db.comment, { as: "comments", foreignKey: { name: 'restoran_id', allowNull: false }, });
db.user.hasMany(db.image, { as: "images", foreignKey: { name: 'user_id', allowNull: false }, });
db.restoran.hasMany(db.image, { as: "images", foreignKey: { name: 'restoran_id', allowNull: false }, });

module.exports = db;
