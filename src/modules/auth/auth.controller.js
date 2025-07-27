import { checkUserExistence, createNewUser, getUserByEmail } from "./auth.db.js";
import { encryptPassword, validatePassword } from "./auth.service.js";

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
    const result = await getUserByEmail(email);

    if(!result) {
        throw new Error("User does not exist");
    } 

    const hashedPassword = result.password;
    
    if(!(await validatePassword(password, hashedPassword))) {
        throw new Error("Incorrect password");
    }

    return res 
    .status(200)
    .json({
        success: true,
        message: "User logged in successfully"
    });
};

export {
    signinUser,
    signupUser
};