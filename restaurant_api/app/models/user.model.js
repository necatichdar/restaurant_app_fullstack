module.exports = (sequelize, Sequelize) => {
  const User = sequelize.define("user", {
    user_id: {
      type: Sequelize.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    username: {
      type: Sequelize.STRING,
      allowNull: false,
      unique: true,
    },
    mail: {
      type: Sequelize.STRING,
      allowNull: false,
      unique: true,
    },
    password: {
      type: Sequelize.STRING,
      allowNull: false,
    },
    status: {
      type: Sequelize.BOOLEAN,
      defaultValue: true,
    },
    role: {
      type: Sequelize.STRING,
      defaultValue: "user",
    },
  });

  return User;
};