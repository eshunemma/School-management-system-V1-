-- CreateTable
CREATE TABLE "staff" (
    "id" SERIAL NOT NULL,
    "staffName" TEXT NOT NULL,
    "DOB" TEXT NOT NULL,
    "destination" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "nationalId" TEXT NOT NULL,
    "snnitId" TEXT NOT NULL,
    "dateJoined" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "staff_pkey" PRIMARY KEY ("id")
);
