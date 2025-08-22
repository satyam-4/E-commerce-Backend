import express from "express";
import { signinUser, signupUser } from "./auth.controller.js";
import { sigininValidator, signupValidator } from "./auth.validator.js";
import { validate } from "#middlewares/validate.middleware.js";

const router = express.Router();

router.route("/signin").post(sigininValidator, validate, signinUser);
router.route("/signup").post(signupValidator, validate, signupUser);

export default router;