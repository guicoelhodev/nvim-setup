local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

local typescriptCodeBlock = {
	s(
		'typ', -- trigger for typescript code block
		fmt(
			[[
```typescript
{}
```
			]],
			{
				i(1, '//your code here'),
			}
		)
	),
}

local spaceLine = {
	s(
		'sl', -- trigger for space line
		fmt(
			[[
#v(1em)
			]],
			{}
		)
	),
}

-- Add typescript code block snippet
ls.add_snippets('typst', typescriptCodeBlock)

-- Add space line snippet
ls.add_snippets('typst', spaceLine)

return {}
