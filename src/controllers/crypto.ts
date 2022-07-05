import { Request, Response, NextFunction } from 'express';
import axios from 'axios';

interface CryptoCurrency {
    ticker: String;
    price: Number;
}

let cryptos: CryptoCurrency[] = [];

// GET-endpoint that receives all crypto currencies and returns their Ticker and Price
const getCryptocurrencyInfo = async (req: Request, res: Response, next: NextFunction) => {
    try {
        // Get all crypto currencies
        const result = await axios.get(`https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd`);
        const cryptoCurrencies = result.data;
        
        // Save necessary info
        cryptoCurrencies.forEach((cryptoCurrency: { id: any; symbol: any; current_price: any; }) => {
            cryptos.push({ ticker: cryptoCurrency.symbol, price: cryptoCurrency.current_price});
        });

        return res.status(200).json({
            CryptoCurrencyInfo: cryptos
    });
    } catch (error) {
        throw new Error('Error occurred while getting crypto currencies');
    }
};

export default { getCryptocurrencyInfo };