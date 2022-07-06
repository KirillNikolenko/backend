"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
var _a;
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const dotenv_1 = __importDefault(require("dotenv"));
//import routes from './routes/route-crypto';
const crypto_1 = __importDefault(require("./controllers/crypto"));
dotenv_1.default.config();
const app = (0, express_1.default)();
/** Routes */
//router.use('/', routes);
/** Server */
app.get('/cryptoCurrencies', crypto_1.default.getCryptocurrencyInfo);
const PORT = (_a = process.env.PORT) !== null && _a !== void 0 ? _a : 8000;
app.listen(PORT, () => console.log(`The server is running on port ${PORT}`));
