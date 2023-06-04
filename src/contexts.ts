import { PrismaClient, Prisma } from "@prisma/client";

export const prisma = new PrismaClient();

//Prisma Context for the headers
export interface Context {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  req: any;
  prisma?: PrismaClient<
    Prisma.PrismaClientOptions,
    never,
    Prisma.RejectOnNotFound | Prisma.RejectPerOperation
  >;
}
