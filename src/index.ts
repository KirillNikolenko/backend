import express, { Express } from 'express';
import dotenv from 'dotenv';
import controller from './controllers/crypto-info';

dotenv.config();

const app: Express = express();

/** GET-endpoint that receives all crypto currencies and returns their Ticker and Price */
app.get('/cryptoCurrencies', controller.getCryptocurrencyInfo);

const PORT: any = process.env.PORT ?? 8000;
app.listen(PORT, () => console.log(`The server is running on port ${PORT}`));