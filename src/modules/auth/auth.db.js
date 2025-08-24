import { AppError } from "#utils/AppError.js";
import prisma from "../../prisma/client.js";

export const createNewUser = async (fullName, email, password, phone, address) => {
    const user = await prisma.users.create({
        data: {
            fullName,
            email,
            password,
            phone,
            address
        }
    });
    return user;
}

export const checkUserExistence = async (email, phone) => {
    const user = await prisma.users.findFirst({
        where: {
            OR: [
                { email },
                { phone }
            ]
        }
    });
    return user;
}

export const getUserByEmail = async (email) => {
    try {
        const user = await prisma.users.findUnique({
            where: {
                email
            }
        });
        return user;
    } catch (error) {
        throw new AppError(500, "Failed to fetch user");
    }
}

export const storeRefreshToken = async (userId, refreshToken, ipAddress, userAgent, expiresAt) => {
    try {
        return await prisma.refreshtoken.create({
            data: {
                token: refreshToken,
                userId: userId,
                ip: ipAddress,
                userAgent: userAgent,
                expiresAt: expiresAt
            }
        });
    } catch (error) {
        throw new AppError(500, "Error while storing refresh token");
    }
}