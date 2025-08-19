import express from "express";
import { createProducts, deleteProduct, getProducts, getProductsById, updateProduct } from "./product.controller.js";
import { verifyJWT } from "#middlewares/auth.middleware.js";
import { checkRole } from "#middlewares/role.middleware.js";

const router = express.Router();

router.route("/products").post(verifyJWT, checkRole(["seller"]), createProducts);
router.route("/products").get(verifyJWT, getProducts);
router.route("/products/:id").get(verifyJWT, getProductsById);
router.route("/products/:id").patch(verifyJWT, checkRole(["seller"]), updateProduct);
router.route("/products/:id").delete(verifyJWT, checkRole(["seller"]), deleteProduct);

export default router;