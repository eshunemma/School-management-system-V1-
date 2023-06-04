/*
  Warnings:

  - Added the required column `created_by` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "User" ADD COLUMN     "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "created_by" INTEGER NOT NULL,
ADD COLUMN     "update_by" INTEGER,
ADD COLUMN     "updated_at" TIMESTAMP(3);
