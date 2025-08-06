import express from "express";
import authRoutes from "./src/modules/auth/auth.route.js";
import { errorHandler } from "./src/middlewares/errorHandler.middleware.js";

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use("/auth", authRoutes);

app.use(errorHandler);
export { app };