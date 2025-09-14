import { AppError } from "#utils/AppError.js";
import { 
    addProducts, 
    addProductVariant, 
    destroyProduct, 
    destroyProductVariant, 
    getAllProducts, 
    getProductById, 
    updateProductById 
} from "./product.db.js";

const createProduct = async (req, res) => {
    const { name, description, subcategoryId } = req.body;
    
    const product = await addProducts(name, description, subcategoryId);

    return res
    .status(200)
    .json({
        success: true,
        message: "Product created sucessfully",
        product: product
    });
};

const deleteProduct = async (req, res) => {
    const { productId } = req.params;

    const deletedProduct = await destroyProduct(productId);

    return res
    .status(200)
    .json({
        success: true,
        message: "Successfully deleted the product",
        data: deletedProduct
    });
};

const createProductVariant = async (req, res) => {
    const productId = req.params.productId;
    const { sku, attributes } = req.body;

    const variant = await addProductVariant(productId, sku, attributes);

    return res
    .status(201)
    .json({
        success: true,
        message: "Product variant created successfully",
        data: variant
    });
}

const deleteProductVariant = async (req, res) => {
    const { productId, variantId } = req.params;
    
    console.log(productId, variantId)

    const deletedVariant = await destroyProductVariant(productId, variantId);

    return res
    .status(200)
    .json({
        success: true,
        message: "Deleted product variant successfully",
        data: deletedVariant
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

export {
    createProduct,
    deleteProduct,
    createProductVariant,
    deleteProductVariant,
    getProducts,
    getProductsById,
    updateProduct,
};