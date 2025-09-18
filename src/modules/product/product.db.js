import { AppError } from "#utils/AppError.js";
import prisma from "../../prisma/client.js";

export const addProducts = async (name, description, subcategoryId) => {
    try {
        const subcategory = await prisma.subcategory.findUnique({
            where: { id: subcategoryId }
        });
        
        if(!subcategory) {
            throw new AppError(404, "Subcategory not found");
        }

        const product = await prisma.product.create({
            data: {
                name,
                description,
                subcategoryId: subcategoryId
            }
        });

        return product;
    } catch (error) {
        if(error instanceof AppError) {
            throw error;
        }

        throw new AppError(500, "Error while creating new product");
    }
};

export const destroyProduct = async (productId) => {
    try {
        const product = await prisma.product.findFirst({
            where: { id: productId }
        });

        if(!product) {
            throw new AppError(404, "Product not found");
        }

        const deletedProduct = await prisma.product.delete({
            where: { id: productId }
        });

        return deletedProduct;
    } catch (error) {
        if(error instanceof AppError) {
            throw error;
        }

        throw new AppError(500, "Error while deleting the product");
    }
};

export const addProductVariant = async (productId, sku, attributes) => {
    try {
        const product = await prisma.product.findUnique({
            where: { id: productId }
        });

        if(!product) {
            throw new AppError(404, "Product not found");
        }

        const productVariant = await prisma.productVariant.create({
            data: {
                sku: sku,
                productId: productId,
                attributes: attributes
            }
        });

        return productVariant;
    } catch (error) {
        if(error instanceof AppError) {
            throw error;
        }

        throw new AppError(500, "Error while creating variant of a product");
    }
};

export const destroyProductVariant = async (productId, productVariantId) => {
    try {
        const product = await prisma.product.findUnique({
            where: { id: productId }
        });

        if(!product) {
            throw new AppError(404, "Product not found");
        }

        const productVariant = await prisma.productVariant.findUnique({
            where: { id: productVariantId } 
        });

        if(!productVariant) {
            throw new AppError(404, "Product variant not found");
        }

        const deletedProductVariant = await prisma.variant.delete({
            where: { id: productVariantId }
        });

        return deletedProductVariant;
    } catch (error) {
        if(error instanceof AppError) {
            throw error;
        }

        throw new AppError(500, "Error while deleting product variant");
    }
}

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
        if(!productId) return null;
        const product = prisma.product.findUnique({
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

