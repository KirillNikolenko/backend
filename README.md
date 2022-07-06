# Get cryptocurrency info

Simple NodeJS service that contains one endpoint 'getCryptocurrencyInfo', which returns a list of both Ticker and Price of the cryptocurrencies. Wraps a 3rd party REST API of the Coin Gecko service.

.env file contains the environment variable 'PORT', which is the port number the server will be running on.

In order to run the server use:
- 'npm run build';
- 'npm run start'

Using docker:
- Go to the app folder, which contains Dockerfile;
- Run 'docker build -t getcryptoinfo .' in order to create an image called "getcryptoinfo";
- Run 'docker run -p 8000:8000 -d getcryptoinfo' in order to run the container;
- Test the endpoint via e.g. 'curl http://localhost:8000/cryptoCurrencies -UseBasicParsing'

-- Interviews.sql file with the 1st task is in the src/SQL folder.
