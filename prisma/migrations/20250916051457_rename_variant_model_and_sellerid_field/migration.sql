/*
  Warnings:

  - You are about to drop the column `variantId` on the `seller_variants` table. All the data in the column will be lost.
  - You are about to drop the column `sellerId` on the `sellers` table. All the data in the column will be lost.
  - You are about to drop the `variants` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[userId]` on the table `sellers` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `productVariantId` to the `seller_variants` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `sellers` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "seller_variants" DROP CONSTRAINT "seller_variants_variantId_fkey";

-- DropForeignKey
ALTER TABLE "sellers" DROP CONSTRAINT "sellers_sellerId_fkey";

-- DropForeignKey
ALTER TABLE "variants" DROP CONSTRAINT "variants_productId_fkey";

-- DropIndex
DROP INDEX "sellers_sellerId_key";

-- AlterTable
ALTER TABLE "seller_variants" DROP COLUMN "variantId",
ADD COLUMN     "productVariantId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "sellers" DROP COLUMN "sellerId",
ADD COLUMN     "userId" INTEGER NOT NULL;

-- DropTable
DROP TABLE "variants";

-- CreateTable
CREATE TABLE "product_variants" (
    "id" SERIAL NOT NULL,
    "sku" TEXT NOT NULL,
    "productId" INTEGER NOT NULL,
    "attributes" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "product_variants_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "product_variants_sku_key" ON "product_variants"("sku");

-- CreateIndex
CREATE UNIQUE INDEX "sellers_userId_key" ON "sellers"("userId");

-- AddForeignKey
ALTER TABLE "sellers" ADD CONSTRAINT "sellers_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_variants" ADD CONSTRAINT "product_variants_productId_fkey" FOREIGN KEY ("productId") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "seller_variants" ADD CONSTRAINT "seller_variants_productVariantId_fkey" FOREIGN KEY ("productVariantId") REFERENCES "product_variants"("id") ON DELETE CASCADE ON UPDATE CASCADE;
