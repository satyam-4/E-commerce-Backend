import { checkUserExistence, createNewUser, getUserByEmail, storeRefreshToken } from "./auth.db.js";
import { encryptPassword, generateAccessToken, generateRefreshToken, validatePassword } from "./auth.service.js";

const signupUser = async (req, res) => {
    const { fullName, email, password, phone } = req.body;
    const userExists = await checkUserExistence(email, phone);

    if(userExists) {
        throw new Error("User already exists");
    }
    
    if(!fullName || !email || !password || !phone) {
        throw new Error("All fields are required");
    }

    const hashedPassword = await encryptPassword(password);
    const user = createNewUser(fullName, email, hashedPassword, phone)
    return res
    .status(200)
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
        throw new Error("User does not exist");
    } 

    const hashedPassword = user.password;
    
    if(!(await validatePassword(password, hashedPassword))) {
        throw new Error("Incorrect password");
    }

    const payload = { id: user.id, email: user.email, role: user.role };
    const accessToken = await generateAccessToken(payload);
    const refreshToken = await generateRefreshToken(payload);

    await storeRefreshToken(user.id, refreshToken);

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
        message: "User logged in successfully"
    });
};

export {
    signinUser,
    signupUser
};