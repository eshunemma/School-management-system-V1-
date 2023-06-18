/*
  Warnings:

  - A unique constraint covering the columns `[staffId]` on the table `staff` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `staffId` to the `staff` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `dateJoined` on the `staff` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "staff" ADD COLUMN     "staffId" TEXT NOT NULL,
DROP COLUMN "dateJoined",
ADD COLUMN     "dateJoined" TIMESTAMP(3) NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "staff_staffId_key" ON "staff"("staffId");
