import argon2 from "argon2";

export const encryptPassword = async (password) => {
    const hashedPassword = await argon2.hash(password);
    return hashedPassword;
}

export const validatePassword = async (password, hashedPassword) => {
    const result = await argon2.verify(hashedPassword, password);
    return result;
}