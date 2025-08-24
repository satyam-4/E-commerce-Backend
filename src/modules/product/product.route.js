import express from "express";
import { createProducts, deleteProduct, getProducts, getProductsById, updateProduct } from "./product.controller.js";
import { createProductValidator, getProductByIdValidator, updateProductValidator, deleteProductValidator } from "./product.validator.js";
import { validate } from "#middlewares/validate.middleware.js";
import { verifyJWT } from "#middlewares/auth.middleware.js";
import { checkRole } from "#middlewares/role.middleware.js";

const router = express.Router();

router.route("/products").post(verifyJWT, checkRole(["seller"]), createProductValidator, validate, createProducts);
router.route("/products").get(verifyJWT, getProducts);
router.route("/products/:id").get(verifyJWT, getProductByIdValidator, validate, getProductsById);
router.route("/products/:id").patch(verifyJWT, checkRole(["seller"]), updateProductValidator, validate, updateProduct);
router.route("/products/:id").delete(verifyJWT, checkRole(["seller"]), deleteProduct);

export default router;