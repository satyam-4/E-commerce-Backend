/*
  Warnings:

  - You are about to drop the column `userId` on the `seller` table. All the data in the column will be lost.
  - Added the required column `sellerId` to the `seller` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "seller" DROP CONSTRAINT "seller_userId_fkey";

-- AlterTable
ALTER TABLE "seller" DROP COLUMN "userId",
ADD COLUMN     "sellerId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "seller" ADD CONSTRAINT "seller_sellerId_fkey" FOREIGN KEY ("sellerId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
