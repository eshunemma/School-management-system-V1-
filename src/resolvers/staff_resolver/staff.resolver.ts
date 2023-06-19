/* eslint-disable @typescript-eslint/no-explicit-any */

import Yup from "yup";
import { GraphQLError } from "graphql";
import dotenv from "dotenv";
import { toCapitalizeEachWord } from "../../helpers/text-formatter.js";
import { Context } from "../../contexts.js";
dotenv.config();

interface StaffArgs {
  data: {
    staffId: string;
    staffName: string
    DOB: string
    destination: string
    phoneNumber: string
    email: string
    nationalId: string
    snnitId: string
    dateJoined: string
    active: boolean
    createdAt: string
    updatedAt: string
  };
}



export const staff_resolvers = {

    Query: {
        listAllStaffs: async(_:any, __:any, {prisma}: Context) => {
            const response = await prisma.staff.findMany();
            return response;
        }
    },
    Mutation: {
        addStaff: async (
            _: any,
            { data }: StaffArgs,
            { prisma }: Context
        ) => {
            const {
                staffId,
                staffName,
                DOB,
                active,
                dateJoined,
                destination,
                email,
                nationalId,
                phoneNumber,
                snnitId,
            } = data;
            try {
                // Yup Validations
                const validator = Yup.object({
                    staffName: Yup.string().required("Name is required"),
                    email: Yup.string()
                        .email("Email is not valid")
                        .required("Email is required"),
                    DOB: Yup.string().required("Date of Bith is required"),
                });
                await validator.validate(data);
                const response = await prisma.staff.create({
                    data: {
                        staffId,
                        staffName: toCapitalizeEachWord(staffName),
                        DOB,
                        active,
                        dateJoined: new Date(dateJoined),
                        destination,
                        email,
                        nationalId,
                        phoneNumber,
                        snnitId,
                    },
                });
                return response;
            } catch (error) {
                return error;
            }
        },
    }
};
