import express from "express";
import { 
    deleteSubcategory, 
    getAllSubcategories, 
    getProductsBySubcategoryId, 
    getSubcategoryById, 
    updateSubcategory } 
from "./subcategories.controller.js";
import { 
    deleteSubcategoryValidator,
    getProductsBySubcategoryIdValidator,
    getSubcategoryByIdValidator,
    updateSubcategoryValidator,
} from "./subcategories.validator.js";
import { verifyJWT } from "#middlewares/auth.middleware.js";
import { checkRole } from "#middlewares/role.middleware.js";
import { validate } from "#middlewares/validate.middleware.js";

const router = express.Router();

router.route("/").get(getAllSubcategories);
router.route("/:subcategoryId").get(
    verifyJWT,
    getSubcategoryByIdValidator,
    validate,
    getSubcategoryById
);
router.route("/:subcategoryId/products").get(
    verifyJWT,
    getProductsBySubcategoryIdValidator,
    validate,
    getProductsBySubcategoryId
);
router.route("/:subcategoryId").put(
    verifyJWT,
    checkRole(["ADMIN", "SELLER"]),
    updateSubcategoryValidator,
    validate,
    updateSubcategory
);
router.route("/:subcategoryId").delete(
    verifyJWT,
    checkRole(["ADMIN", "SELLER"]),
    deleteSubcategoryValidator,
    validate,
    deleteSubcategory
);

export default router;