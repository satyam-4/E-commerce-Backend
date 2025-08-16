import { AppError } from "#utils/AppError.js";
import { getUserByEmail } from "#modules/auth/auth.db.js";
import jwt from "jsonwebtoken";

export const verifyJWT = async (req, res, next) => {
    const accessToken = req.cookies?.accessToken;

    console.log("Access Token:", accessToken);

    if(!accessToken) {
        throw new AppError(401, "Unauthorized request");
    }

    const decodedToken = jwt.verify(accessToken, process.env.ACCESS_TOKEN_SECRET);
    const user = await getUserByEmail(decodedToken.payload.email);

    if(!user) {
        throw new AppError(401, "Invalid Access Token");
    }

    req.user = user;

    next();
}