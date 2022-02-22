const express = require("express");
const cors = require("cors");
const app = express();
const db = require("./app/models");
const dbConfig = require("./app/config/db.config");

app.use(cors());
app.use(express.static('public'))
app.use(express.json({ limit: '50mb' }));

// resimler klasoru yoksa olusturacak
var fs = require('fs');
var dir = './public';
if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir);
}
var dir2 = './public/resimler';
if (!fs.existsSync(dir2)) {
    fs.mkdirSync(dir2);
}


const mysql = require('mysql2');

const PORT = process.env.PORT || 3000;
async function initialize() {
    const { HOST, USER, PASSWORD, DB } = dbConfig;
    const connection = await mysql.createConnection({
        host: HOST,
        user: USER,
        password: PASSWORD,
    });
    connection.connect((error) => {
        if (error) {
            console.log("Error connecting to database: ", error);
        }
        connection.query(`CREATE DATABASE IF NOT EXISTS \`${DB}\``, async (err) => {
            if (err) {
                console.log("Error creating table: ", err);
            }
            await db.sequelize.sync();
        })
    })
}

initialize();
// db.sequelize.sync() 

app.get("/", (req, res) => {
    res.json({ message: "Welcome to resotran api application." });
});

//? Tanımlama İşlemleri
const userRouter = require('./app/routes/user.routes');
const restoranRouter = require('./app/routes/restoran.routes');
const commentRouter = require('./app/routes/comment.routes');
app.use('/user', userRouter)
app.use('/restoran', restoranRouter)
app.use('/comment', commentRouter)

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}.`);
});
