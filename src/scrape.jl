# FIXME:
function simplify(iter)
    if length(iter) == 0
        return ""
    elseif length(iter) == 1
        return first(iter)
    end
    iter
end

# TODO: look into what nodeText does
gettext(x) = error("Getting text is not yet implemented for type $(typeof(x))")
gettext(x::HTMLElement) = join(gettext.(children(x)))
gettext(x::HTMLText) = x.text

scrape(s::TextSelector, html) = [gettext(m) for m in eachmatch(s.selector, html)]
scrape(s::AttrSelector{String}, html) = 
    [get(m.attributes, s.attribute, "") for m in eachmatch(s.selector, html)]

scrape(s::HTMLSelector, html) = [string(m) for m in eachmatch(s.selector, html)]

scrape(s::Schema, html) = 
    Dict(field.name => simplify(scrape(field.selector, html)) for field in s.fields)
    # Dict(Symbol(field.name) => simplify(scrape(field.selector, html)) for field in s.fields)

# Create a special method for and attribute selector with a regex attribute value
getregex(d::Dict, r::Regex, default) = get.(Ref(d), filter(contains(r), keys(d)), Ref(default))
scrape(s::AttrSelector{Regex}, html) = 
    vcat([getregex(m.attributes, s.attribute, "") for m in eachmatch(s.selector, html)]...)

##
scrape(s::LinkSelector{String}, html) =
    vcat([strip(nodeText(m)) => get(m.attributes, s.attribute, "") for m in eachmatch(s.selector, html)]...)

scrape(s::LinkSelector{Regex}, html) =
    vcat([strip(nodeText(m)) => getregex(m.attributes, s.attribute, "") for m in eachmatch(s.selector, html)]...)

#TODO: make sure this gets turned into a list of tuples. list of lists?
function scrape(s::PairSelector, html)
    groups = collect(eachmatch(s.groupselector.selector, html))
    [simplify(scrape(s.keyselector, g)) => simplify(scrape(s.valueseletor, g)) for g in groups]
end