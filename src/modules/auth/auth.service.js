import argon2 from "argon2";
import jwt from "jsonwebtoken";

export const encryptPassword = async (password) => {
    const hashedPassword = await argon2.hash(password);
    return hashedPassword;
}

export const validatePassword = async (password, hashedPassword) => {
    const result = await argon2.verify(hashedPassword, password);
    return result;
}

export const generateAccessToken = async (payload) => {
    try {
        return jwt.sign(
            { payload },
            process.env.ACCESS_TOKEN_SECRET,
            { expiresIn: process.env.ACCESS_TOKEN_EXPIRY }
        );
    } catch (error) {
        throw new Error("Error while generating access token");
    }
}

export const generateRefreshToken = async (payload) => {
    try {
        return jwt.sign(
            { payload },
            process.env.REFRESH_TOKEN_SECRET,
            { expiresIn: process.env.REFRESH_TOKEN_EXPIRY }
        );
    } catch (error) {
        throw new Error("Error while generating refresh token");
    }
}