# Jultik

An experimental webscraper written in Julia. This is package is in the early stages of development.

## TODO:
 * General
    - Handeling relative paths for links
 * Crawling
    - Implement recursive crawling
    - Add different types of spiders - for example pagination crawling
    - Add initial pages to spider results??
    - Allow for all types of Selectors in crawl, right now Selectors that return a Pair fail.
* Scraping
    - Special methods to scrape to JSON, Dataframes, etc.
    - Scrape multiple elements from each page
    - Perhaps add post-processing to scraped strings. For example stripping whitespace, re-encoding.