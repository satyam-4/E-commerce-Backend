import prisma from "../../prisma/client.js";

export const createNewUser = async (fullName, email, password, phone) => {
    const user = await prisma.users.create({
        data: {
            fullName,
            email,
            password,
            phone
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
        throw new Error("Failed to fetch user");
    }
}