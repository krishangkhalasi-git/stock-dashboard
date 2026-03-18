const API_KEY = "d6soj19r01qoqoiqs3sgd6soj19r01qoqoiqs3t0"

// GLOBAL chart variable
let chart

async function loadStock() {

    let symbol = document.getElementById("symbol").value.toUpperCase()

    if (!symbol) {
        alert("Enter stock symbol")
        return
    }

    loadChart()
    loadFundamentals(symbol)
    loadNews(symbol)
}

// ------------------ CHART ------------------

function loadChart() {

    const ctx = document.getElementById('priceChart').getContext('2d')

    // Destroy old chart if exists
    if (chart) {
        chart.destroy()
    }

    // Dummy data (guaranteed to work)
    chart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: ["Mon", "Tue", "Wed", "Thu", "Fri"],
            datasets: [{
                label: "Stock Price",
                data: [100, 105, 102, 110, 108],
                borderWidth: 2
            }]
        }
    })
}

// ------------------ FUNDAMENTALS ------------------

async function loadFundamentals(symbol) {

    try {

        let res = await fetch(
            `https://finnhub.io/api/v1/stock/metric?symbol=${symbol}&metric=all&token=${API_KEY}`
        )

        let data = await res.json()

        console.log("Fundamentals:", data)

        let m = data.metric

        if (!m) {
            document.getElementById("fundamentals").innerHTML = "No data found"
            return
        }

        document.getElementById("fundamentals").innerHTML = `
        <div class="card">
            <h3>${symbol}</h3>
            <p>Market Cap: ${m.marketCapitalization || "N/A"}</p>
            <p>P/E Ratio: ${m.peNormalizedAnnual || "N/A"}</p>
            <p>EPS: ${m.epsNormalizedAnnual || "N/A"}</p>
        </div>
        `

    } catch (error) {
        console.error(error)
        document.getElementById("fundamentals").innerHTML = "Error loading data"
    }
}

// ------------------ NEWS ------------------

async function loadNews(symbol) {

    try {

        let res = await fetch(
            `https://finnhub.io/api/v1/company-news?symbol=${symbol}&from=2025-01-01&to=2026-12-31&token=${API_KEY}`
        )

        let data = await res.json()

        console.log("News:", data)

        let container = document.getElementById("news")
        container.innerHTML = ""

        if (!data || data.length === 0) {
            container.innerHTML = "No news found"
            return
        }

        data.slice(0, 5).forEach(article => {

            container.innerHTML += `
            <div class="card">
                <a href="${article.url}" target="_blank" style="color:lightblue;">
                    ${article.headline}
                </a>
            </div>
            `
        })

    } catch (error) {
        console.error(error)
        document.getElementById("news").innerHTML = "Error loading news"
    }
}

