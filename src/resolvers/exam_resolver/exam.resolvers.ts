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



export const exam_resolvers = {

    Query: {
        listAllStaffs: async(_:any, __:any, {prisma}: Context) => {
            const response = await prisma.staff.findMany();
            return response;
        }
    },
    Mutation: {
        addExamType: async (
            _: any,
            { data }: any,
            { prisma }: Context
        ) => {
            const {
                name,
                description
            } = data;
            try {
                const response = await prisma.exam_type.create({
                    data: {
                        name,
                        description 
                    },
                });
                return response;
            } catch (error) {
                return error;
            }
        },

        addExam: async (
            _: any,
            { data }: any,
            { prisma }: Context
        ) => {
            const {exam_type_id, name, start_date, end_date} = data;
            try {
                const response = await prisma.exam.create({
                    data: {
                        exam_type_id,
                        name,
                        start_date,
                        end_date
                    }
                });
                return response;
            } catch (error) {
                return error;
            }
        },

        addExamResult: async (
            _: any,
            { data }: any,
            { prisma }: Context
        ) => {
            const {exam_id, student_id, subject_id, marks} = data;
            try {
                const response = await prisma.exam_result.create({
                    data: {
                        exam_id,
                        student_id,
                        subject_id,
                        marks
                    }
                });
                return response;
            } catch (error) {
                return error;
            }
        }
    }
};
