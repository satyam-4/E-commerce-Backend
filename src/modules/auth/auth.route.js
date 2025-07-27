import express from "express";
import { signinUser, signupUser } from "./auth.controller.js";

const router = express.Router();

router.route("/signin").post(signinUser);
router.route("/signup").post(signupUser);

export default router;