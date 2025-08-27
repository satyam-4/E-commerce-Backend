/*
  Warnings:

  - A unique constraint covering the columns `[cartId,productId]` on the table `cartitem` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "cartitem_cartId_productId_key" ON "cartitem"("cartId", "productId");
