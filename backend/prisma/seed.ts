//ai generated

import 'dotenv/config';
import { PrismaClient } from '../src/generated/prisma/client';
import { PrismaPg } from '@prisma/adapter-pg';
import categories from '../categories.json';
import products from '../products.json';

const adapter = new PrismaPg({ connectionString: process.env.DATABASE_URL });
const prisma = new PrismaClient({ adapter });

async function main() {
    const categoryEntries = Object.values(categories);
    for (const cat of categoryEntries) {
        await prisma.category.upsert({
            where: { id: 0 },
            update: {},
            create: {
                name: cat.name,
                image_path: cat.imagePath,
                color: BigInt(cat.color),
            },
        }).catch(async () => {
            await prisma.category.create({
                data: {
                    name: cat.name,
                    image_path: cat.imagePath,
                    color: BigInt(cat.color),
                },
            });
        });
    }

    const allCategories = await prisma.category.findMany();
    const categoryMap = new Map(allCategories.map((c) => [c.name.toLowerCase(), c.id]));

    const productEntries = Object.values(products);
    for (const prod of productEntries) {
        const catId = categoryMap.get(prod.category.name.toLowerCase()) || allCategories[0]?.id;
        if (!catId) continue;

        await prisma.product.create({
            data: {
                name: prod.name,
                image_path: prod.imagePath,
                amount: prod.amount,
                description: prod.description,
                discount: prod.discount,
                price: prod.price,
                is_new: prod.isNew,
                free_shipping: prod.freeShipping,
                same_day_delivery: prod.sameDayDelivery,
                color: BigInt(prod.color),
                category_id: catId,
            },
        });
    }

    console.log('Database seeded successfully!');
}

main()
    .catch((e) => {
        console.error(e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
