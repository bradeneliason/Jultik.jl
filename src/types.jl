abstract type AbstractSelector end

struct TextSelector <: AbstractSelector
    selector::Selector
end

struct AttrSelector{A} <: AbstractSelector
    selector::Selector
    attribute::A
end

struct HTMLSelector <: AbstractSelector
    selector::Selector
end

struct LinkSelector{A} <: AbstractSelector
    selector::Selector
    attribute::A
end

struct PairSelector{G <: AbstractSelector, K <: AbstractSelector,V <: AbstractSelector} <: AbstractSelector
    groupselector::G
    keyselector::K
    valueseletor::V
end

# TODO: implement new selectors
# TODO: Add Constructors for selectors so I can make them with just a string and not sel"..."
# struct ImageSelector <: AbstractSelector end
# struct TableSelector <: AbstractSelector end


mutable struct SpiderResult
    url::AbstractString
    scraped::Bool
end

SpiderResult(url) = SpiderResult(url, false)

struct Spider{S <: AbstractSelector}
    startpages::Vector{<:AbstractString}
    selector::S
    recursive::Bool
    results::Vector{SpiderResult}
    filter
end

# Schema and Fields
abstract type AbstractField end

struct Field{S <: AbstractSelector} <: AbstractField 
    name::AbstractString
    selector::S
end

struct Schema
    fields::Vector{<: AbstractField }
end

# names(schema::Schema) = [f.name for f in schema.fields]

