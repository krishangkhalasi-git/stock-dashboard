const API_KEY = "d6soj19r01qoqoiqs3sgd6soj19r01qoqoiqs3t0"

async function loadStock(){

let symbol = document.getElementById("symbol").value

let priceResponse = await fetch(
`https://finnhub.io/api/v1/quote?symbol=${symbol}&token=${API_KEY}`
)

let priceData = await priceResponse.json()

console.log(priceData)

loadNews(symbol)

}
