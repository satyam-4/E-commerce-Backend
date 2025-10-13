export const errorHandler = (err, req, res, next) => {
    console.log("Error handler middleware");
    const statusCode = err?.statusCode || 500;

    console.log("code:", statusCode);
    console.log("error obj:", err);

    if (process.env.NODE_ENV === "development") {
        return res
        .status(statusCode)
        .json({
            success: false,
            message: err.message,
            stack: err.stack
        })
    } else {
        return res
        .status(statusCode)
        .json({
            success: false,
            message: err.message
        });
    }
};