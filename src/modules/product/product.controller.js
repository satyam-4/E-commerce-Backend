import { AppError } from "#utils/AppError.js";
import { addProducts, deleteProductById, getAllProducts, getProductById, updateProductById } from "./product.db.js";

const createProducts = async (req, res) => {
    const userId = req.user.id;
    const { name, price, description } = req.body;
    
    const product = await addProducts(userId, name, price, description);

    return res
    .status(200)
    .json({
        success: true,
        message: "Product added sucessfully",
        product: product
    });
};

const getProducts = async (req, res) => {
    const products = await getAllProducts();
    return res
    .status(200)
    .json({
        success: true,
        message: "Products fetched successfully",
        data: products
    });
};

const getProductsById = async (req, res) => {
    const { id } = req.params;
    const productId = parseInt(id, 10);
    const product = await getProductById(productId);

    if(!product) {
        throw new AppError(404, "Product not found");
    }

    return res
    .status(200)
    .json({
        success: true,
        message: "Product fetched successfully",
        data: product
    });
};

const updateProduct = async (req, res) => {
    const { id } = req.params;
    const userId = req.user.id;
    const productId = parseInt(id, 10);
    const allowedFields = ["name", "price", "description"];
    const updateData = {};

    for(const key in req.body) {
        if(allowedFields.includes(key)) {
            updateData[key] = req.body[key]
        }
    }

    console.log("updateData:", updateData);

    if(Object.keys(updateData).length === 0) {
        throw new AppError(400, "No valid fields to update");
    }

    const updatedProduct = await updateProductById(productId, userId, updateData);

    return res
    .status(200)
    .json({
        success: true,
        message: "Successfully updated the product",
        data: updatedProduct
    });
};

const deleteProduct = async (req, res) => {
    const userId = req.user.id;
    const { id } = req.params;
    const productId = parseInt(id, 10);

    const deletedProduct = await deleteProductById(productId, userId);

    return res
    .status(200)
    .json({
        success: true,
        message: "Successfully deleted the product",
        data: deletedProduct
    });
};

export {
    createProducts,
    getProducts,
    getProductsById,
    updateProduct,
    deleteProduct
};