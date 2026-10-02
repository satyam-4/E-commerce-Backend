import { checkUserExistence, createNewUser, destroySessionToken, getUserByEmail, storeSessionToken } from "./repository.js";
import { encryptPassword, generateSessionToken, hashToken, verifyPassword } from "./service.js";
import { AppError } from "#utils/AppError.js";
import { sanitizeUser } from "./serializer.js";
import { env } from "#config/env.js";

export const SESSION_COOKIE_NAME = env.SESSION_COOKIE_NAME;

export const SESSION_COOKIE_OPTIONS = {
    httpOnly: true,
    secure: env.NODE_ENV === "production",
    sameSite: "lax"
};

const signupUser = async (req, res) => {
    const { fullName, email, password, phone, address } = req.body;
    const userExists = await checkUserExistence(email, phone);

    if (userExists) {
        throw new AppError(409, "User already exists");
    }

    const hashedPassword = await encryptPassword(password);
    const user = await createNewUser(fullName, email, hashedPassword, phone, address);
    return res
    .status(201)
    .json({
        success: true,
        user: sanitizeUser(user),
        message: "User created successfully"
    });
};

const signinUser = async (req, res) => {
    const { email, password } = req.body;

    const user = await getUserByEmail(email);
    const ipAddress = req.ip;
    const userAgent = req.headers['user-agent'];

    if (!user) {
        throw new AppError(404, "User does not exist");
    } 

    const hashedPassword = user.password;
    
    if (!(await verifyPassword(password, hashedPassword))) {
        throw new AppError(400, "Incorrect password");
    }

    const rawToken = await generateSessionToken();
    const hashedToken = await hashToken(rawToken);

    const now = new Date();
    const expiresAt = new Date(now.getTime() + env.SESSION_MAX_AGE);
    const absoluteExp = new Date(now.getTime() + env.SESSION_ABSOLUTE_MAX_AGE);

    await storeSessionToken(user.id, hashedToken, ipAddress, userAgent, expiresAt, absoluteExp);

    return res 
    .status(200)
    .cookie(SESSION_COOKIE_NAME, hashedToken, {
        ...SESSION_COOKIE_OPTIONS,
        maxAge: env.SESSION_ABSOLUTE_MAX_AGE
    })
    .json({
        success: true,
        message: "User logged in successfully",
        user: sanitizeUser(user)
    });
};

const signoutUser = async (req, res) => {
    const sessionToken = req.cookies?.sid;

    if (sessionToken) {
        destroySessionToken(sessionToken);
    }

    return res
    .status(200)
    .clearCookie(SESSION_COOKIE_NAME, SESSION_COOKIE_OPTIONS)
    .json({
        success: true,
        message: "User logged out successfully"
    });
};

export {
    signinUser,
    signupUser,
    signoutUser
};