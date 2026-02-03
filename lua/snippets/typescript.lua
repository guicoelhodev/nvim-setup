local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

-- Convert kebab-case to PascalCase
local function toPascalCase(args)
	local str = args[1][1]
	return str:gsub("%-(%w)", function(c) return c:upper() end):gsub("^%w", string.upper)
end

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

local angularComponent = {
	s(
		'angularcomp',
		fmt(
			[[
import {{ Component }} from '@angular/core';

@Component({{
  selector: 'app-{}',
  standalone: true,
  imports: [],
  templateUrl: './{}.component.html',
  styleUrl: './{}.component.scss'
}})
export class {}Component {{

}}
]],
			{
				i(1, 'name'),
				rep(1),
				rep(1),
				f(toPascalCase, {1}),
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

-- angular
ls.add_snippets('typescript', angularComponent)

return {}
