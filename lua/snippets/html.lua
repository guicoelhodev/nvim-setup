local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

local function createTag(tagName)
	return s(tagName, fmt('<{}>{}</{}>', { t(tagName), i(0), t(tagName) }))
end


local commonTags =
{ 'div', 'section', 'article', 'header', 'footer', 'aside', 'main', 'ul', 'li', 'ol', 'p', 'span', 'h1', 'h2', 'h3', 'h4',
	'h5', 'h6', 'img' }

local snippets = {}

for _, element in ipairs(commonTags) do
	table.insert(snippets, createTag(element))
end

ls.add_snippets('html', snippets)
