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
CREATE UNIQUE INDEX "class_table_staff_id_key" ON "class_table"("staff_id");

-- CreateIndex
CREATE UNIQUE INDEX "student_class_student_id_key" ON "student_class"("student_id");

-- CreateIndex
CREATE UNIQUE INDEX "_departmentsTosubject_AB_unique" ON "_departmentsTosubject"("A", "B");

-- CreateIndex
CREATE INDEX "_departmentsTosubject_B_index" ON "_departmentsTosubject"("B");

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
