import { z } from "zod";
import dotenv from "dotenv";
import { logger } from "./logger.js";

dotenv.config();

const envSchema = z.object({
    NODE_ENV: z
        .enum(["development", "production", "test"])
        .default("development"),
    PORT: z
        .coerce.number()
        .int()
        .positive()
        .default(5000),

    DATABASE_URL: z
        .string()
        .url("DATABASE_URL must be a valid Postgres connection string"),

    SESSION_COOKIE_NAME: z.string().min(1).default("sid"),
    SESSION_COOKIE_SECRET: z.string().min(32, "SESSION_COOKIE_SECRET should be at least 32 random characters"),
    SESSION_MAX_AGE: z.coerce.number().int().positive(),
    SESSION_ABSOLUTE_MAX_AGE: z.coerce.number().int().positive(),

    CORS_ORIGINS: z
        .string()
        .min(1, "CORS_ORIGINS is required, comma-separated list of allowed origins")
        .transform((val) => val.split(",").map((origin) => origin.trim())),
});

const parsed = envSchema.safeParse(process.env);

if (!parsed.success) {
    logger.fatal(
        { issues: parsed.error.issues },
        "Invalid environment variables. Refusing to start"
    );
    process.exit(1);
}

export const env = parsed.data;