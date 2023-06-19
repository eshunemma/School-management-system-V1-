/* eslint-disable @typescript-eslint/no-explicit-any */
import { GraphQLError } from "graphql";
import dotenv from "dotenv";
import { toCapitalizeEachWord } from "../../helpers/text-formatter.js";
import { Context } from "../../contexts.js";
dotenv.config();

interface ClassArgs {
  data: {
    class_name: string,
    department_id: number,
    staff_id: string
  };
}

export const class_resolvers = {
    Query: {
        listAllClasses: (_: any, __: any, { prisma }: Context) => {
            return prisma.class_table.findMany({
                include: {
                    department: true,
                    staff: true,
                    students: true
                }
            });
        },
    },

    Mutation: {
    // Sign Up Resolver
        addClass: async (
            _: any,
            { data }: ClassArgs,
            { prisma }: Context
        ) => {
            const {  
                class_name,
                department_id,
                staff_id} = data;
            try {
                const response = await prisma.class_table.create({
                    data:{
                        class_name: toCapitalizeEachWord(class_name),
                        department_id,
                        staff_id,
                    },
                    include:{
                        department: true,
                        staff: true,
                        students:true
                    }
                });
                return response;
            } catch (error) {
                return error;
            }
        }
    }
};
 