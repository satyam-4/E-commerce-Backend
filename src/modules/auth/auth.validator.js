import { body } from "express-validator";

export const signupValidator = [
    body("fullName")
        .isString().withMessage("Full name must be a string")
        .isLength({ min: 3, max: 50}).withMessage("Full name must be between 3 and 50 characters")
        .notEmpty().withMessage("Full name is required"),

    body("email")
        .isEmail().withMessage("Invalid email address")
        .normalizeEmail()
        .notEmpty().withMessage("Email is required"),

    body("password")
        .isLength({ min: 6, max: 12 }).withMessage("Password must be between 6 and 12 characters")
        .matches(/[0-9]/).withMessage("Password must contain atleast one number")
        .matches(/[A-Z]/).withMessage("Password must contain atleast one uppercase letter")
        .notEmpty().withMessage("Password is required"),

    body("phone")
        .isMobilePhone().withMessage("Invalid phone number")
        .notEmpty().withMessage("Phone is required"),

    body("address")
        .isString().withMessage("Address must be a string")
        .isLength({ max: 100 }).withMessage("Address must not exceed 100 characters")
        .notEmpty().withMessage("Address is required"),
];

export const sigininValidator = [
    body("email")
        .isEmail().withMessage("Invalid email address")
        .normalizeEmail()
        .notEmpty().withMessage("Email is required"),

    body("password")
        .notEmpty().withMessage("Password is required")
];