/*
  Warnings:

  - A unique constraint covering the columns `[productVariantId,sellerId]` on the table `seller_variants` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "seller_variants_productVariantId_sellerId_key" ON "seller_variants"("productVariantId", "sellerId");
