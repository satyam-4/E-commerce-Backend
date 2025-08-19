import { AppError } from "#utils/AppError.js";
import prisma from "../../prisma/client.js";

export const addProducts = async (userId, name, price, description) => {
    try {
        const seller = await prisma.seller.findUnique({
            where: { sellerId: userId }
        })
        
        const product = await prisma.product.create({
            data: {
                name,
                price,
                description,
                sellerId: seller.id
            }
        });

        return product;
    } catch (error) {
        console.log(error)
        throw new AppError(500, "Error while adding product");
    }
};

export const getAllProducts = async () => {
    try {
        const products = prisma.product.findMany();
        return products;
    } catch (error) {
        throw new AppError(500, "Error while fetching products");
    }
};

export const getProductById = async (productId) => {
    try {
        const product = prisma.product.findFirst({
            where: {
                id: productId
            }
        })
        return product;
    } catch (error) {
        throw new AppError(500, "Error while fetching product");
    }
};

export const updateProductById = async (productId, userId, updateData) => {
    try {
        const seller = await prisma.seller.findUnique({
            where: {
                sellerId: userId
            }
        });

        const sellerId = seller.id;

        const product = await prisma.product.findFirst({
            where: {
                id: productId,
                sellerId: sellerId
            }
        });

        if(!product) {
            throw new AppError(403, "You cannot update this product");
        }

        const updatedProduct = await prisma.product.update({
            where: {
                id: productId,
            },
            data: updateData
        });
        
        return updatedProduct;
    } catch (error) {
        if(error instanceof AppError) {
            throw error;
        }
        
        throw new AppError(500, "Error while updating the product");
    }
};

export const deleteProductById = async (productId, userId) => {
    try {
        const seller = await prisma.seller.findFirst({
            where: {
                sellerId: userId
            }
        });

        const sellerId = seller.id;

        const product = await prisma.product.findFirst({
            where: {
                id: productId,
                sellerId: sellerId
            }
        });

        if(!product) {
            throw new AppError(400, "You cannot delete this product");
        }

        const deletedProduct = await prisma.product.delete({
            where: {
                id: productId
            }
        });

        return deletedProduct;
    } catch (error) {
        console.log("This is the error->", error)

        if(error instanceof AppError) {
            throw error;
        }

        throw new AppError(500, "Error while deleting the product");
    }
};