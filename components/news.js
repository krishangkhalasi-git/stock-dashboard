async function loadNews(symbol){

let response = await fetch(
`https://finnhub.io/api/v1/company-news?symbol=${symbol}&token=${API_KEY}`
)

let news = await response.json()

let container = document.getElementById("news")

container.innerHTML=""

news.slice(0,5).forEach(article => {

container.innerHTML += `
<div>
<a href="${article.url}" target="_blank">
${article.headline}
</a>
</div>
`

})

}
