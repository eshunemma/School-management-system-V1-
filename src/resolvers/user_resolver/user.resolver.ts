/* eslint-disable @typescript-eslint/no-explicit-any */

import Yup from "yup";
import { GraphQLError } from "graphql";
import dotenv from "dotenv";
import { toCapitalizeEachWord } from "../../helpers/text-formatter.js";
import { Context } from "../../contexts.js";
import { comparePassword, hashPassword } from "../../helpers/hashPassword.js";
import JWT from "jsonwebtoken";
dotenv.config();
const JWT_signature = process.env.JWT_SIGNATURE;

interface UserArgs {
    data: {
        id: number;
        name: string;
        email: string;
        password: string;
        role: string;
        userName: string;
        CreatedBy: number;
    }
  }

export const user_resolvers = {
    Mutation: {
        // Sign Up Resolver
        signUp: async (_: any, { data }: UserArgs, { prisma }: Context) => {
            const { name, email, userName, password, CreatedBy, role } = data;
            const convertName = toCapitalizeEachWord(name);
            try {
                // Yup Validations
                const validator = Yup.object({
                    name: Yup.string().required("Name is required"),
                    email: Yup.string()
                        .email("Email is not valid")
                        .required("Email is required"),
                    userName: Yup.string().required("Username is required"),
                    password: Yup.string().required("Password is required").min(5).max(8),
                    role: Yup.string(),
                });
                await validator.validate(data);

                // Checking for existance of email
                const checkEmail = await prisma.user.findUnique({
                    where: {
                        email
                    }
                });

                // Checking of existance of Username
                const checkUserName = await prisma.user.findUnique({
                    where: {
                        userName
                    }
                });

                let response;
                if(!checkEmail){
                    if(!checkUserName){
                        response = await prisma.user.create({
                            data: {
                                email,
                                name: convertName,
                                password: await hashPassword(password),
                                role,
                                userName,
                                created_by: CreatedBy,
                            },
                        });
                    } else {
                        throw new GraphQLError("User Name Already exists");
                    }
                } else {
                    throw new GraphQLError("Email already exists");
                }
                
                // JWT token
                const token =  JWT.sign({
                    UserId: response.id,
                    role: role
                }, JWT_signature, {
                    expiresIn: 36000000
                });
                
                return {
                    message: "User Successfully Created",
                    token: token
                };
            } catch (error) {
                return error;
            }
        },

        signIn: async (_: any, { data }: UserArgs, { prisma }: Context) => {
            const {email, password } = data;
            try {
                // Yup Validations
                const validator = Yup.object({
                    email: Yup.string()
                        .email("Email is not valid"),
                    userName: Yup.string(),
                    password: Yup.string().required("Password is required"),
                });
                await validator.validate(data);

                // Checking the existance of email
                const checkEmail = await prisma.user.findUnique({
                    where: {
                        email
                    }
                });
                
                if(!checkEmail){
                    throw new GraphQLError("Invalid Credentials");
                }
                
                // Comparing user password
                const isMatch = await comparePassword(password, checkEmail.password);
    
                if (!isMatch){
                    throw new GraphQLError("Invalid Credentials");
                }

                // JWT token
                const token =  JWT.sign({
                    UserId: checkEmail.id,
                    role: checkEmail.role
                }, JWT_signature, {
                    expiresIn: 36000000
                });
                
                return {
                    message: "User Loged In Successfully",
                    token: token
                };
            } catch (error) {
                return error;
            }
        },
    },
};
