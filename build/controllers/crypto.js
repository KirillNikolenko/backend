"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const axios_1 = __importDefault(require("axios"));
let cryptos = [];
// GET-endpoint that receives all crypto currencies and returns their Ticker and Price
const getCryptocurrencyInfo = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        // Get all crypto currencies
        const result = yield axios_1.default.get(`https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd`);
        const cryptoCurrencies = result.data;
        // Save necessary info
        cryptoCurrencies.forEach((cryptoCurrency) => {
            cryptos.push({ ticker: cryptoCurrency.symbol, price: cryptoCurrency.current_price });
        });
        return res.status(200).json({
            CryptoCurrencyInfo: cryptos
        });
    }
    catch (error) {
        throw new Error('Error occurred while getting crypto currencies');
    }
});
exports.default = { getCryptocurrencyInfo };
