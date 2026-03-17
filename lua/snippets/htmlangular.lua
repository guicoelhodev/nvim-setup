local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local function createTag(tagName)
	return s(tagName, fmt("<{}>{}</{}>", { t(tagName), i(0), t(tagName) }))
end

local commonTags = {
	"div",
	"section",
	"article",
	"header",
	"footer",
	"aside",
	"main",
	"nav",
	"ul",
	"li",
	"ol",
	"p",
	"span",
	"a",
	"h1",
	"h2",
	"h3",
	"h4",
	"h5",
	"h6",
	"img",
	"figure",
	"figcaption",
	"form",
	"input",
	"label",
	"button",
	"textarea",
	"select",
	"option",
	"table",
	"thead",
	"tbody",
	"tr",
	"td",
	"th",
}

local snippets = {}

for _, element in ipairs(commonTags) do
	table.insert(snippets, createTag(element))
end

local angularSnippets = {
	s(
		"for",
		fmt(
			[[
@for ({} of {}; track {}) {{
  <div>
  </div>
}}
]],
			{
				i(1, "item"),
				i(2, "items"),
				rep(1),
			}
		)
	),
	s(
		"if",
		fmt(
			[[
@if ({}) {{
  <div>
  </div>
}}
]],
			{
				i(1, "condition"),
			}
		)
	),
	s(
		"ifelse",
		fmt(
			[[
@if ({}) {{
  <div>
  </div>
}} @else {{
  <div>
  </div>
}}
]],
			{
				i(1, "condition"),
			}
		)
	),
}

local allSnippets = {}

for _, snip in ipairs(snippets) do
	table.insert(allSnippets, snip)
end

for _, snip in ipairs(angularSnippets) do
	table.insert(allSnippets, snip)
end

ls.add_snippets("htmlangular", allSnippets)
