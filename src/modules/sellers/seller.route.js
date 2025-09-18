import express from "express";
import { verifyJWT } from "#middlewares/auth.middleware.js";
import { checkRole } from "#middlewares/role.middleware.js";
import {
    createSellerVariantValidator,
    getSellerVariantByIdValidator,
    updateSellerVariantByIdValidator,
    deleteSellerVariantByIdValidator,
} from "./seller.validator.js"
import { validate } from "#middlewares/validate.middleware.js";
import { 
    createSellerVariant,
    deleteSellerVariantById,
    getAllSellerVariant,
    getSellerVariantByID,
    updateSellerVariantById,
} from "./seller.controller.js";

const router = express.Router();

router.route("/seller-variant").post(
    verifyJWT,
    checkRole(["SELLER"]),
    createSellerVariantValidator,
    validate,
    createSellerVariant
);
router.route("/seller-variant").get(
    verifyJWT,
    checkRole(["SELLER"]),
    getAllSellerVariant
);
router.route("/seller-variant/:sellerVariantId").get(
    verifyJWT,
    checkRole(["SELLER"]),
    getSellerVariantByIdValidator,
    validate,
    getSellerVariantByID
);
router.route("/seller-variant/:sellerVariantId").put(
    verifyJWT,
    checkRole(["SELLER"]),
    updateSellerVariantByIdValidator,
    validate,
    updateSellerVariantById
);
router.route("/seller-variant/:sellerVariantId").delete(
    verifyJWT,
    checkRole(["SELLER"]),
    deleteSellerVariantByIdValidator,
    validate,
    deleteSellerVariantById
);

export default router;