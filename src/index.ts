import http from 'http';
import express, { Express } from 'express';
import dotenv from 'dotenv';
import routes from './routes/route-crypto';

dotenv.config();

const router: Express = express();

/** Routes */
router.use('/', routes);

/** Server */
const httpServer = http.createServer(router);
const PORT: any = process.env.PORT ?? 8000;
httpServer.listen(PORT, () => console.log(`The server is running on port ${PORT}`));