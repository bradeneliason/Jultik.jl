# TODO:
#   ⋅ Implement recursive crawling
#   ⋅ Add different types of spiders - for example pagination crawling
#   ⋅ 

urls(v::Vector{SpiderResult}) = [r.url for r in v]

function crawl!(s::Spider)
    for url in s.startpages
        r = HTTP.get(url);
        h = parsehtml(String(r.body))

        links = filter(contains(s.filter), scrape(s.selector, h.root) )

        push!(s.results, SpiderResult.(links)...)

        @info "$(length(links))\tadded from $url"
    end
end
