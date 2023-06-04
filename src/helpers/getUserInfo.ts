import dotenv from "dotenv";
import JWT from "jsonwebtoken";
dotenv.config();
const JWT_signature = process.env.JWT_SIGNATURE;

export const getUserFromToken = (token: string) => {
    try {
        return JWT.verify(token, JWT_signature) as {
            UserId: number
        };
    } catch (error) {
        return null;
    }
};