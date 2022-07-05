import express from 'express';
import controller from '../controllers/crypto';
const router = express.Router();

router.get('/cryptoCurrencies', controller.getCryptocurrencyInfo);

export = router;