import { app } from "./app.js";
import pool from "./src/db/db.js";
import dotenv from "dotenv";

dotenv.config();

const Port = process.env.PORT || 3000;

pool.connect()
    .then(() => {
        console.log("Connected to PostgreSql");
        app.listen(Port, () => {
            console.log(`Server is listening at port ${Port}`);
        });
    })
    .catch((err) => console.error("Database connection failed", err));