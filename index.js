import { app } from "./app.js";

app.get("/", (req, res) => {
    res.send("Hi-Hello");
});

const PORT = 3000;

app.listen(PORT, () => {
    console.log(`server is listening at port ${PORT}`);
});