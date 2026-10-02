import { app } from "./app.js";
import { connectDB } from './src/config/db.js';
import { env } from "#config/env.js";
import { logger } from "#config/logger.js";

await connectDB();

app.listen(env.PORT, () => {
    logger.info(`Server is listening at port ${env.PORT}`);
});