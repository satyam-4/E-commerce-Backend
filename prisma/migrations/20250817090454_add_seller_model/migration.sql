/*
  Warnings:

  - The values [user] on the enum `Role` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the `refreshToken` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `address` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "Role_new" AS ENUM ('buyer', 'admin', 'seller');
ALTER TABLE "users" ALTER COLUMN "role" DROP DEFAULT;
ALTER TABLE "users" ALTER COLUMN "role" TYPE "Role_new" USING ("role"::text::"Role_new");
ALTER TYPE "Role" RENAME TO "Role_old";
ALTER TYPE "Role_new" RENAME TO "Role";
DROP TYPE "Role_old";
ALTER TABLE "users" ALTER COLUMN "role" SET DEFAULT 'buyer';
COMMIT;

-- DropForeignKey
ALTER TABLE "refreshToken" DROP CONSTRAINT "refreshToken_userId_fkey";

-- AlterTable
ALTER TABLE "users" ADD COLUMN     "address" TEXT NOT NULL,
ALTER COLUMN "role" SET DEFAULT 'buyer';

-- DropTable
DROP TABLE "refreshToken";

-- CreateTable
CREATE TABLE "refreshtoken" (
    "id" SERIAL NOT NULL,
    "token" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "userAgent" TEXT,
    "ip" TEXT,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "refreshtoken_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "seller" (
    "id" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "pickupAddress" TEXT NOT NULL,
    "businessName" TEXT NOT NULL,
    "gstNumber" TEXT,
    "bankInfo" TEXT,

    CONSTRAINT "seller_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "refreshtoken" ADD CONSTRAINT "refreshtoken_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "seller" ADD CONSTRAINT "seller_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
