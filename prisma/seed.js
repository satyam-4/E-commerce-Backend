import { PrismaClient } from "@prisma/client";
import slugify from "slugify";

const prisma = new PrismaClient()

async function main() {
    const categoriesData = [
        {
            name: "Electronics",
            subcategories: ["Mobiles", "Laptops", "Tablets", "Cameras"]
        },
        {
            name: "Fashion",
            subcategories: ["Men", "Women", "Kids", "Accessories"],
        },
        {
            name: "Home & Kitchen",
            subcategories: ["Furniture", "Appliances", "Decor", "Cookware"],
        },
    ];

    await prisma.$transaction(
        categoriesData.map((cat) => 
            prisma.category.upsert({
                where: { slug: slugify(cat.name, { lower: true } )},
                update: {},
                create: {
                    name: cat.name,
                    slug: slugify(cat.name, { lower: true }),
                    subcategories: {
                        create: cat.subcategories.map((subcat) => ({
                            name: subcat,
                            slug: slugify(subcat, { lower: true })
                        }))
                    }
                }
            })
        )
    );
}

main()
    .then(() => console.log("Categories and Subcategories are seeded successfully"))
    .catch((err) => {
        console.error("Seed error:", err)
    })
    .finally(async () => {
        await prisma.$disconnect();
    });