module Jultik
    using HTTP
    using Gumbo
    using Cascadia
    using DataFrames

    include("types.jl")
    include("crawl.jl")
    include("scrape.jl")

    export TextSelector, AttrSelector, HTMLSelector, LinkSelector, PairSelector
    export Spider, SpiderResult
    export Schema, Field

    export crawl!, urls
    export scrape

end
