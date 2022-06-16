# TODO:


urls(v::Vector{SpiderResult}) = [r.url for r in v]

function crawl!(s::Spider)
    for url in s.startpages
        r = HTTP.get(url);
        h = parsehtml(String(r.body))

        links = scrape(s.selector, h.root)
        
        if !isnothing(s.filter)
            filter!(contains(s.filter), links)
        end

        push!(s.results, SpiderResult.(links)...)

        @info "$(length(links))\tadded from $url"
    end
end
