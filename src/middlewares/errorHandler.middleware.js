export const errorHandler = (err, req, res, next) => {
    console.log("Error hander middleware")
    return res.status(err.statusCode).json({
        success: err.success,
        message: err.message,   
        errors: err.errors,
        data: err.data,
        stack: err.stack
    });
};