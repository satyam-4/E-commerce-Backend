export const errorHandler = (err, req, res, next) => {
    console.log("Error hander middleware")
    const statusCode = err.statusCode || 500;

    return res
    .status(statusCode)
    .json({
        success: err.success,
        message: err.message,   
        errors: err.errors,
        data: err.data,
        stack: err.stack
    });
};