import express from "express";
import { getMe, signinUser, signupUser } from "./auth.controller.js";
import { verifyJWT } from "#middlewares/auth.middleware.js";

const router = express.Router();

router.route("/signin").post(signinUser);
router.route("/signup").post(signupUser);
router.route("/me").get(verifyJWT, getMe);

export default router;