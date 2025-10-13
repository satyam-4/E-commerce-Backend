import express from "express";
import { 
    createProduct, 
    createProductVariant, 
    deleteProduct, 
    deleteProductVariant, 
    getProducts, 
    getProductsById, 
    updateProduct 
} from "./product.controller.js";
import { 
    createProductValidator, 
    getProductByIdValidator, 
    updateProductValidator, 
    deleteProductValidator, 
    createProductVariantValidator, 
    deleteProductVariantValidator} 
from "./product.validator.js";
import { validate } from "#middlewares/validate.middleware.js";
import { verifyJWT } from "#middlewares/auth.middleware.js";
import { checkRole } from "#middlewares/role.middleware.js";

const router = express.Router();

router.route("/").get(getProducts);
router.route("/").post(
    verifyJWT, 
    checkRole(["SELLER", "ADMIN"]), 
    createProductValidator, 
    validate, 
    createProduct
);
router.route("/:productId").delete(
    verifyJWT, 
    checkRole(["SELLER", "ADMIN"]), 
    deleteProductValidator,
    validate,
    deleteProduct
);
router.route("/:productId/variants").post(
    verifyJWT, 
    checkRole(["SELLER", "ADMIN"]), 
    createProductVariantValidator, 
    validate, 
    createProductVariant
);
router.route("/:productId/variants/:productVariantId").delete(
    verifyJWT,
    checkRole(["SELLER", "ADMIN"]),
    deleteProductVariantValidator,
    validate,
    deleteProductVariant
);
router.route("/:id").get(
    verifyJWT, 
    getProductByIdValidator, 
    validate, 
    getProductsById
);
router.route("/:id").patch(
    verifyJWT, 
    checkRole(["SELLER", "ADMIN"]), 
    updateProductValidator, 
    validate, 
    updateProduct
);

export default router;