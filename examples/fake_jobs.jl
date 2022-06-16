using Jultik
using Gumbo, Cascadia, HTTP

# category_sel = AttrSelector(sel".category-link", "href")

# spider = Spider(
#     ["https://www.webscraper.io/test-sites/e-commerce/allinone"], 
#     category_sel, false, SpiderResult[], nothing
# )


title        = Field("title", TextSelector(sel".card .title"))
subtitle        = Field("subtitle", TextSelector(sel".card .subtitle"))
location        = Field("location", TextSelector(sel".card .location"))
posttime        = Field("time", TextSelector(sel".card time"))

sch = Schema([title, subtitle, location, posttime] )

# "https://realpython.github.io/fake-jobs/"
##
using JSON3

json_data = []

r = HTTP.get("https://realpython.github.io/fake-jobs/");
h = parsehtml(String(r.body))
data = scrape(sch, h.root)
merge!(data, Dict("url" => result.url))
push!(json_data, data)
result.scraped = true    # Update status of spider
