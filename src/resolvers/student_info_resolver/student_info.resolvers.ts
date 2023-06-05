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

interface studentArgs {
  data: {
    studentId: string;
    studentName: string;
    dateOfBirth: string;
    nationality: string;
    gender: string;
    hometown: string;
    destination: string;
    digitalAddress: string;
    motherTongue: string;
    secondLanguage: string;
    religion: string;
    admissionDate: string;
    admissionNumber: string;
    classOnAdmission: string;
    previous_school: string;
    previousSchoolLocation: string;
    classInPreviousSchool: string;
    studentImage: string;
    createdBy: number;
    updatedAt: string;
    updatedBy: number;
    Family_info: [];
  };
}

interface EmergencyContactArgs {
    contactName: string
    relation: string
    telephone: string
}

export const student_resolvers = {
    Query: {
        listAllUsers: (_: any, __: any, { prisma }: Context) => {
            return prisma.user.findMany();
        },
    },

    Mutation: {
    // Sign Up Resolver
        addStudent: async (
            _: any,
            { data }: any,
            { prisma, userInfo }: Context
        ) => {
            const {
                studentId,
                studentName,
                dateOfBirth,
                nationality,
                gender,
                hometown,
                destination,
                digitalAddress,
                motherTongue,
                secondLanguage,
                religion,
                admissionDate,
                admissionNumber,
                classOnAdmission,
                previous_school,
                previousSchoolLocation,
                classInPreviousSchool,
                studentImage,
                createdBy,
                Family_info,
                contactName,
                relation,
                telephone
            } = data;
            try {
                // Yup Validations
                // const validator = Yup.object({
                //     name: Yup.string().required("Name is required"),
                //     email: Yup.string()
                //         .email("Email is not valid")
                //         .required("Email is required"),
                //     userName: Yup.string().required("Username is required"),
                //     password: Yup.string().required("Password is required").min(5).max(8),
                //     role: Yup.string(),
                // });
                // await validator.validate(data);
                const response = await prisma.student_info.create({
                    data: {
                        student_id: studentId,
                        student_name: toCapitalizeEachWord(studentName),
                        date_of_birth: new Date(dateOfBirth),
                        nationality,
                        gender,
                        hometown,
                        destination,
                        digital_Address: digitalAddress,
                        mother_tongue: motherTongue,
                        second_language: secondLanguage,
                        religion,
                        admission_date: new Date(admissionDate),
                        admission_number: admissionNumber,
                        class_on_admission: classOnAdmission,
                        previous_school,
                        previous_school_location: previousSchoolLocation,
                        class_in_previous_school: classInPreviousSchool,
                        student_image: studentImage,
                        created_by: userInfo.UserId,
                        Family_info: {
                            create: Family_info
                        },
                        Emergency_contact: {
                            create:{
                                contact_name: contactName,
                                relation,
                                telephone
                            }
                        }

                    },
                    include: {
                        Emergency_contact: true,
                        Family_info: true
                    }
                });
                
                return response;
            } catch (error) {
                return error;
            }
        },
    }
};
