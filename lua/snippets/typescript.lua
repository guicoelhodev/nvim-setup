local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

local consoleLog = {
	s('clog', fmt([[console.log('{}', {})]], { i(1, ''), rep(1) })),
}

local createFn = {
	s(
		'cfn', -- create function
		fmt(
			[[
      function {} (arg) {{

      }};
    ]],
			{
				i(1, ''),
			}
		)
	),
}

local createAsyncFn = {
	s(
		'cafn', -- create async function
		fmt(
			[[
      async function {} (arg) {{

      }};
    ]],
			{
				i(1, ''),
			}
		)
	),
}

local createClass = {
	s(
		'cll', -- create class
		fmt(
			[[
export class {} {{

	constructor() {{ }}
}};
    ]],
			{
				i(1, ''),
			}
		)
	),
}

local createClassI = {
	s(
		'clli', -- create class with implements
		fmt(
			[[
export class {} implements {}Contract {{

	constructor() {{ }}
}};
    ]],
			{
				i(1, ''),
				rep(1)
			}
		)
	),
}

-- console.logs
ls.add_snippets('typescript', consoleLog)

-- functions
ls.add_snippets('typescript', createFn)
ls.add_snippets('typescript', createAsyncFn)

-- class
ls.add_snippets('typescript', createClass)
ls.add_snippets('typescript', createClassI)

return {}
