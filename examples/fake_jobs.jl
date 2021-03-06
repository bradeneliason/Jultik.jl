using Jultik
using Gumbo, Cascadia, HTTP

# category_sel = AttrSelector(sel".category-link", "href")

# spider = Spider(
#     ["https://www.webscraper.io/test-sites/e-commerce/allinone"], 
#     category_sel, false, SpiderResult[], nothing
# )


title        = Field("title", TextSelector(sel".title"))
subtitle        = Field("subtitle", TextSelector(sel".subtitle"))
location        = Field("location", TextSelector(sel".location"))
posttime        = Field("time", TextSelector(sel"time"))

sch = Schema([title, subtitle, location, posttime] )

# "https://realpython.github.io/fake-jobs/"
##
using JSON3

json_data = []

r = HTTP.get("https://realpython.github.io/fake-jobs/");
h = parsehtml(String(r.body))
data = map(x -> scrape(sch, x),  eachmatch(sel".card", h.root))
push!(json_data, data)

open("fake_jobs.json", "w") do io
    JSON3.pretty(io, data)
end

