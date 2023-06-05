/*
  Warnings:

  - Added the required column `gender` to the `student_info` table without a default value. This is not possible if the table is not empty.
  - Added the required column `hometown` to the `student_info` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "family_info" ADD COLUMN     "email" TEXT;

-- AlterTable
ALTER TABLE "student_info" ADD COLUMN     "gender" TEXT NOT NULL,
ADD COLUMN     "hometown" TEXT NOT NULL;
