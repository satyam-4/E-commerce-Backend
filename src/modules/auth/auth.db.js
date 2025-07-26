import prisma from "../../prisma/client.js";

async function createNewUser(fullName, email, password, phone) {
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

async function checkUserExistence(email, phone) {
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

export {
    createNewUser,
    checkUserExistence
};