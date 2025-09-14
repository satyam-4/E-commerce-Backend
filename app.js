import express from "express";
import authRoutes from "./src/modules/auth/auth.route.js";
import userRoutes from "./src/modules/users/user.route.js";
import productRoutes from "./src/modules/product/product.route.js";
import cartRoutes from "./src/modules/cart/cart.route.js";
import categoryRoutes from "./src/modules/categories/category.route.js";
import subcategoryRoutes from "./src/modules/subcategories/subcategories.route.js";
import { errorHandler } from "./src/middlewares/errorHandler.middleware.js";
import cookieParser from "cookie-parser";;

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());

app.use("/auth", authRoutes);
app.use("/users", userRoutes);
app.use("/products", productRoutes);
app.use("/cart", cartRoutes);
app.use("/categories", categoryRoutes);
app.use("/subcategories", subcategoryRoutes);

app.use(errorHandler);
export { app };