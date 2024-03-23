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

interface DepartmentArgs {
  data: {
    name: string
  };
}

export const department_resolvers = {
    Query: {
        listAllDepartment: (_: any, __: any, { prisma }: Context) => {
            return prisma.departments.findMany({
                include:{
                    class: true,
                    subject:true,
                },
                orderBy: {
                    id: "desc"
                }
            });
        },
    },

    Mutation: {
    // add department Resolver
        addDepartment: async (
            _: any,
            { data }: DepartmentArgs,
            { prisma }: Context
        ) => {
            const {name} = data;

            try {
                const response = await prisma.departments.create({
                    data:{
                        name: toCapitalizeEachWord(name)
                    },
                    include: {
                        class: true,
                        subject: true
                    }
                });
                return response;
            } catch (error) {
                return error;
            }
        }
    }
};
 