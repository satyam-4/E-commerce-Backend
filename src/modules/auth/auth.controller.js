import { checkUserExistence, createNewUser, getUserByEmail, storeRefreshToken } from "./auth.db.js";
import { encryptPassword, generateAccessToken, generateRefreshToken, verifyPassword } from "./auth.service.js";
import { AppError } from "#utils/AppError.js";

const signupUser = async (req, res) => {
    const { fullName, email, password, phone, address } = req.body;
    const userExists = await checkUserExistence(email, phone);

    if(userExists) {
        throw new AppError(409, "User already exists");
    }

    const hashedPassword = await encryptPassword(password);
    const user = await createNewUser(fullName, email, hashedPassword, phone, address);
    return res
    .status(201)
    .json({
        success: true,
        user,
        message: "User created successfully"
    });
};

const signinUser = async (req, res) => {
    const { email, password } = req.body;
    const user = await getUserByEmail(email);

    if(!user) {
        throw new AppError(404, "User does not exist");
    } 

    const hashedPassword = user.password;
    
    if(!(await verifyPassword(password, hashedPassword))) {
        throw new AppError(400, "Incorrect password");
    }

    const payload = { id: user.id, email: user.email, role: user.role };
    const accessToken = await generateAccessToken(payload);
    const refreshToken = await generateRefreshToken(payload);

    const ipAddress = req.ip;
    const userAgent = req.headers['user-agent'];
    const expiresAt = new Date();
    expiresAt.setDate(expiresAt.getDate() + 7);

    await storeRefreshToken(user.id, refreshToken, ipAddress, userAgent, expiresAt);

    return res 
    .status(200)
    .cookie("accessToken", accessToken, {
        httpOnly: true,
        maxAge: 24 * 60 * 60 * 1000
    })
    .cookie("refreshToken", refreshToken, {
        httpOnly: true,
        maxAge: 24 * 60 * 60 * 1000
    })
    .json({
        success: true,
        message: "User logged in successfully",
        data: user
    });
};

export {
    signinUser,
    signupUser
};