import express from "express";
import { becomeSeller, getMe } from "./user.controller.js";
import { verifyJWT } from "#middlewares/auth.middleware.js";

const router = express.Router();

router.route("/become-seller").post(verifyJWT, becomeSeller);
router.route("/me").get(verifyJWT, getMe);

export default router;