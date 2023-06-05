-- CreateTable
CREATE TABLE "student_info" (
    "id" SERIAL NOT NULL,
    "student_id" TEXT NOT NULL,
    "student_name" TEXT NOT NULL,
    "date_of_birth" TIMESTAMP(3) NOT NULL,
    "nationality" TEXT NOT NULL,
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

-- CreateIndex
CREATE UNIQUE INDEX "student_info_student_id_key" ON "student_info"("student_id");

-- CreateIndex
CREATE UNIQUE INDEX "emergency_contact_student_id_key" ON "emergency_contact"("student_id");

-- AddForeignKey
ALTER TABLE "family_info" ADD CONSTRAINT "family_info_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "student_info"("student_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "emergency_contact" ADD CONSTRAINT "emergency_contact_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "student_info"("student_id") ON DELETE RESTRICT ON UPDATE CASCADE;
