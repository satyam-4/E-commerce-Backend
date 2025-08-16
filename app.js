import express from "express";
import authRoutes from "./src/modules/auth/auth.route.js";
import { errorHandler } from "./src/middlewares/errorHandler.middleware.js";
import cookieParser from "cookie-parser";;

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());
app.use("/auth", authRoutes);

app.use(errorHandler);
export { app };