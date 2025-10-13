import { app } from "./app.js";
import dotenv from "dotenv";

dotenv.config();

const Port = 

app.listen(process.env.PORT || 5000, () => {
    console.log(`Server is listening at port ${Port}`);
});
