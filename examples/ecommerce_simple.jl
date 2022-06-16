using Jultik
using Gumbo, Cascadia, HTTP

category_sel = AttrSelector(sel".category-link", "href")

spider = Spider(
    ["https://www.webscraper.io/test-sites/e-commerce/allinone"], 
    category_sel, false, SpiderResult[], nothing
)

crawl!(spider)
spider.results

##

name        = Field("name", TextSelector(sel".thumbnail .title"))
link        = Field("link", AttrSelector(sel".thumbnail .title", "href"))
price       = Field("price", TextSelector(sel".thumbnail .price"))
description = Field("description", TextSelector(sel".thumbnail .description"))

sch = Schema([name, link, price, description] )

##
using JSON3

json_data = []
for result in spider.results
    r = HTTP.get(result.url);
    h = parsehtml(String(r.body))
    data = scrape(sch, h.root)
    merge!(data, Dict("url" => result.url))
    push!(json_data, data)
    result.scraped = true    # Update status of spider
end