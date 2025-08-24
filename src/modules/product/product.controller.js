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
    const { id: productId } = req.params;
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
    const { id: productId } = req.params;
    const userId = req.user.id;
    const dataToUpdate = req.body;

    const updatedProduct = await updateProductById(productId, userId, dataToUpdate);

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
    const { id: productId } = req.params;

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