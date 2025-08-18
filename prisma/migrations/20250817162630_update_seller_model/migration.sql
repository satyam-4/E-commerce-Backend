/*
  Warnings:

  - A unique constraint covering the columns `[sellerId]` on the table `seller` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "seller_sellerId_key" ON "seller"("sellerId");
