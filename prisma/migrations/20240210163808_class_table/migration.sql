-- DropForeignKey
ALTER TABLE "class_table" DROP CONSTRAINT "class_table_staff_id_fkey";

-- AlterTable
ALTER TABLE "class_table" ALTER COLUMN "staff_id" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "class_table" ADD CONSTRAINT "class_table_staff_id_fkey" FOREIGN KEY ("staff_id") REFERENCES "staff"("staffId") ON DELETE SET NULL ON UPDATE CASCADE;
