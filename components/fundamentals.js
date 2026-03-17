const API_KEY = "d6soj19r01qoqoiqs3sgd6soj19r01qoqoiqs3t0"

async function loadFundamentals(symbol){

let response = await fetch(
`https://finnhub.io/api/v1/stock/metric?symbol=${symbol}&metric=all&token=${API_KEY}`
)

let data = await response.json()

let metrics = data.metric

let container = document.getElementById("fundamentals")

container.innerHTML = `
<div class="card">
    <h3>${symbol} Fundamentals</h3>
    <p>Market Cap: ${metrics.marketCapitalization}</p>
    <p>P/E Ratio: ${metrics.peNormalizedAnnual}</p>
    <p>EPS: ${metrics.epsNormalizedAnnual}</p>
</div>
`

}
