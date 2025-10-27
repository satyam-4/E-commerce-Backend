import express from "express";
import { becomeSeller, getMe } from "./user.controller.js";
import { verifyJWT } from "#middlewares/auth.middleware.js";
import { becomeSellerValidator } from "./user.validation.js";
import { validate } from "#middlewares/validate.middleware.js";

const router = express.Router();

router.route("/become-seller").post(
    verifyJWT, 
    becomeSellerValidator, 
    validate, 
    becomeSeller
);
router.route("/me").get(verifyJWT, getMe);

export default router;