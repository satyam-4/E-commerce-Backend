import { AppError } from "#utils/AppError.js";
import prisma from "../../prisma/client.js"

export const createNewSeller = async (userId, pickupAddress, businessName, gstNumber, bankInfo) => {
    try {
        await prisma.user.update({
            where: { id: userId },
            data: { role: "SELLER" }
        }); 

        const seller = await prisma.seller.create({
            data: {
                userId: userId,
                pickupAddress: pickupAddress,
                businessName: businessName,
                gstNumber: gstNumber,
                bankInfo: bankInfo     
            }
        });

        return seller;
    } catch (error) {
        throw new AppError(500, "Error while creating new seller")
    }
}