import { AppError } from "#utils/AppError.js";
import prisma from "../../prisma/client.js"

export const createNewSeller = async (userId, pickupAddress, businessName, gstNumber, bankInfo) => {
    try {
        await prisma.users.update({
            where: { id: userId },
            data: { role: "seller" }
        }); 

        const seller = await prisma.seller.create({
            data: {
                sellerId: userId,
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