-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ALUMNI', 'ADMIN');

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'ALUMNI',
    "isEmailVerified" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Profile" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "biography" TEXT,
    "linkedInUrl" TEXT,
    "profileImageUrl" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Degree" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "institution" TEXT NOT NULL,
    "completionDate" DATE NOT NULL,

    CONSTRAINT "Degree_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Certification" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "awardingBody" TEXT NOT NULL,
    "completionDate" DATE NOT NULL,

    CONSTRAINT "Certification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EmploymentHistory" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "jobTitle" TEXT NOT NULL,
    "company" TEXT NOT NULL,
    "startDate" DATE NOT NULL,
    "endDate" DATE,

    CONSTRAINT "EmploymentHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Bid" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "targetDate" DATE NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Bid_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Token" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "token" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Token_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Profile_userId_key" ON "Profile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Bid_userId_targetDate_key" ON "Bid"("userId", "targetDate");

-- CreateIndex
CREATE UNIQUE INDEX "Token_token_key" ON "Token"("token");

-- AddForeignKey
ALTER TABLE "Profile" ADD CONSTRAINT "Profile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Degree" ADD CONSTRAINT "Degree_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Certification" ADD CONSTRAINT "Certification_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmploymentHistory" ADD CONSTRAINT "EmploymentHistory_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Bid" ADD CONSTRAINT "Bid_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Token" ADD CONSTRAINT "Token_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
