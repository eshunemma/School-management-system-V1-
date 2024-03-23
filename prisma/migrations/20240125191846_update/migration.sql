-- CreateEnum
CREATE TYPE "Role" AS ENUM ('Admin', 'Teacher', 'student');

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "userName" TEXT NOT NULL,
    "role" "Role",
    "picture" TEXT,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "created_by" INTEGER NOT NULL,
    "updated_at" TIMESTAMP(3),
    "update_by" INTEGER,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "student_info" (
    "id" SERIAL NOT NULL,
    "student_id" TEXT NOT NULL,
    "student_name" TEXT NOT NULL,
    "date_of_birth" TIMESTAMP(3) NOT NULL,
    "nationality" TEXT NOT NULL,
    "gender" TEXT NOT NULL,
    "hometown" TEXT NOT NULL,
    "destination" TEXT NOT NULL,
    "digital_Address" TEXT,
    "mother_tongue" TEXT NOT NULL,
    "second_language" TEXT,
    "religion" TEXT NOT NULL,
    "admission_date" TIMESTAMP(3) NOT NULL,
    "admission_number" TEXT,
    "class_on_admission" TEXT,
    "previous_school" TEXT,
    "previous_school_location" TEXT,
    "class_in_previous_school" TEXT,
    "student_image" TEXT,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "created_by" INTEGER NOT NULL,
    "updated_at" TIMESTAMP(3),
    "updated_by" INTEGER,

    CONSTRAINT "student_info_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "family_info" (
    "id" SERIAL NOT NULL,
    "student_id" TEXT NOT NULL,
    "parent_name" TEXT NOT NULL,
    "occupation" TEXT NOT NULL,
    "place_of_work" TEXT,
    "parent_destination" TEXT NOT NULL,
    "hometown" TEXT NOT NULL,
    "telephone_number" TEXT NOT NULL,
    "whatsapp_number" TEXT,
    "email" TEXT,
    "relation" TEXT NOT NULL,

    CONSTRAINT "family_info_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "emergency_contact" (
    "id" SERIAL NOT NULL,
    "student_id" TEXT NOT NULL,
    "contact_name" TEXT NOT NULL,
    "relation" TEXT NOT NULL,
    "telephone" TEXT NOT NULL,

    CONSTRAINT "emergency_contact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "staff" (
    "id" SERIAL NOT NULL,
    "staffId" TEXT NOT NULL,
    "staffName" TEXT NOT NULL,
    "DOB" TEXT NOT NULL,
    "destination" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "nationalId" TEXT NOT NULL,
    "snnitId" TEXT NOT NULL,
    "dateJoined" TIMESTAMP(3) NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "staff_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "class_table" (
    "id" SERIAL NOT NULL,
    "class_name" TEXT NOT NULL,
    "department_id" INTEGER NOT NULL,
    "staff_id" TEXT NOT NULL,

    CONSTRAINT "class_table_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "departments" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "departments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "student_class" (
    "student_id" INTEGER NOT NULL,
    "class_id" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "subject" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "subject_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "exam_type" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "exam_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "exam" (
    "id" SERIAL NOT NULL,
    "exam_type_id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "start_date" TIMESTAMP(3) NOT NULL,
    "end_date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "exam_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "exam_result" (
    "id" SERIAL NOT NULL,
    "exam_id" INTEGER NOT NULL,
    "student_id" INTEGER NOT NULL,
    "subject_id" INTEGER NOT NULL,
    "marks" INTEGER NOT NULL,

    CONSTRAINT "exam_result_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_departmentsTosubject" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_userName_key" ON "User"("userName");

-- CreateIndex
CREATE UNIQUE INDEX "student_info_student_id_key" ON "student_info"("student_id");

-- CreateIndex
CREATE UNIQUE INDEX "emergency_contact_student_id_key" ON "emergency_contact"("student_id");

-- CreateIndex
CREATE UNIQUE INDEX "staff_staffId_key" ON "staff"("staffId");

-- CreateIndex
CREATE UNIQUE INDEX "staff_email_key" ON "staff"("email");

-- CreateIndex
CREATE UNIQUE INDEX "staff_nationalId_key" ON "staff"("nationalId");

-- CreateIndex
CREATE UNIQUE INDEX "staff_snnitId_key" ON "staff"("snnitId");

-- CreateIndex
CREATE UNIQUE INDEX "class_table_staff_id_key" ON "class_table"("staff_id");

-- CreateIndex
CREATE UNIQUE INDEX "student_class_student_id_key" ON "student_class"("student_id");

-- CreateIndex
CREATE UNIQUE INDEX "_departmentsTosubject_AB_unique" ON "_departmentsTosubject"("A", "B");

-- CreateIndex
CREATE INDEX "_departmentsTosubject_B_index" ON "_departmentsTosubject"("B");

-- AddForeignKey
ALTER TABLE "family_info" ADD CONSTRAINT "family_info_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "student_info"("student_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "emergency_contact" ADD CONSTRAINT "emergency_contact_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "student_info"("student_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "class_table" ADD CONSTRAINT "class_table_department_id_fkey" FOREIGN KEY ("department_id") REFERENCES "departments"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "class_table" ADD CONSTRAINT "class_table_staff_id_fkey" FOREIGN KEY ("staff_id") REFERENCES "staff"("staffId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "student_class" ADD CONSTRAINT "student_class_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "student_info"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "student_class" ADD CONSTRAINT "student_class_class_id_fkey" FOREIGN KEY ("class_id") REFERENCES "class_table"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "exam" ADD CONSTRAINT "exam_exam_type_id_fkey" FOREIGN KEY ("exam_type_id") REFERENCES "exam_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "exam_result" ADD CONSTRAINT "exam_result_exam_id_fkey" FOREIGN KEY ("exam_id") REFERENCES "exam"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "exam_result" ADD CONSTRAINT "exam_result_subject_id_fkey" FOREIGN KEY ("subject_id") REFERENCES "subject"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_departmentsTosubject" ADD CONSTRAINT "_departmentsTosubject_A_fkey" FOREIGN KEY ("A") REFERENCES "departments"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_departmentsTosubject" ADD CONSTRAINT "_departmentsTosubject_B_fkey" FOREIGN KEY ("B") REFERENCES "subject"("id") ON DELETE CASCADE ON UPDATE CASCADE;
