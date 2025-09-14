import express from "express";
import { 
    getAllCategories, 
    getCategoryById,
    getSubcategoriesByCategoryId,
    createCategory,
    updateCategory,
    deleteCategory,
    createSubcategoryByCategoryId,
} from "./category.controller.js";
import { 
    getCategoryByIdValidator, 
    getSubcategoriesByCategoryIdValidator,
    createCategoryValidator,
    updateCategoryValidator, 
    deleteCategoryValidator,
    createSubcategoryValidator,
} from "./category.validator.js";
import { verifyJWT } from "#middlewares/auth.middleware.js";
import { checkRole } from "#middlewares/role.middleware.js";
import { validate } from "#middlewares/validate.middleware.js";

const router = express.Router();

router.route("/").get(
    verifyJWT, 
    getAllCategories
);
router.route("/:categoryId").get(
    verifyJWT, 
    getCategoryByIdValidator, 
    validate, 
    getCategoryById
);
router.route("/:categoryId/subcategory").get(
    verifyJWT, 
    getSubcategoriesByCategoryIdValidator, 
    validate, 
    getSubcategoriesByCategoryId
);
router.route("/:categoryId/subcategory").post(
    verifyJWT, 
    checkRole(["SELLER", "ADMIN"]),
    createSubcategoryValidator,
    validate,
    createSubcategoryByCategoryId,
);
router.route("/").post(
    verifyJWT,
    checkRole(["ADMIN", "SELLER"]), 
    createCategoryValidator,
    validate,
    createCategory
);
router.route("/:categoryId").put(
    verifyJWT,
    checkRole(["ADMIN", "SELLER"]), 
    updateCategoryValidator,
    validate,
    updateCategory
);
router.route("/:categoryId").delete(
    verifyJWT,
    checkRole(["ADMIN", "SELLER"]), 
    deleteCategoryValidator,
    validate,
    deleteCategory
);

export default router;