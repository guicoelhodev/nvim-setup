local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep
local l = require('luasnip.extras').l

-----------------------------------------------------------------------------------------
------------------------------- REACT TYPESCRIPT CONFIG ---------------------------------
-----------------------------------------------------------------------------------------

local function createTag(tagName)
  return s(tagName, fmt('<{}>{}</{}>', { t(tagName), i(0), t(tagName) }))
end

ls.add_snippets('typescriptreact', {
  s(
    'us', -- create useState
    fmt(
      [[
      const [ {}, set{setter} ] = useState({});
    ]],
      {
        i(1, 'state'),
        setter = l(l._1:sub(1, 1):upper() .. l._1:sub(2, -1), 1),
        i(2, ''),
      }
    )
  ),
})

local consoleLog = {
  s('clog', fmt([[console.log('{}', {})]], { i(1, ''), rep(1) })),
}

ls.add_snippets('typescriptreact', consoleLog)

ls.add_snippets('typescriptreact', {
  s(
    'usef', -- create useEffect
    fmt(
      [[

      useEffect(() => {{

      }}, [{}])

    ]],
      {
        i(1, 'state'),
      }
    )
  ),
})

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
ls.add_snippets('typescriptreact', createFn)

ls.add_snippets('typescriptreact', createAsyncFn)

ls.add_snippets('typescriptreact', {
  s(
    'ctest', -- create base test
    fmt(
      [[
        it('{}', () => {{

            const screen = screen(<{} />);
        }});
      ]],
      { i(1, 'test description'), i(2, 'Component') }
    )
  ),
})

------------------------------------------------- CREATE HTML TAGS ------------------------------------------

local commonTags =
{ 'div', 'section', 'article', 'header', 'footer', 'aside', 'main', 'ul', 'li', 'ol', 'p', 'span', 'h1', 'h2', 'h3', 'h4',
  'h5', 'h6', 'img' }

local snippets = {}

for _, element in ipairs(commonTags) do
  table.insert(snippets, createTag(element))
end

ls.add_snippets('typescriptreact', snippets)
ls.add_snippets('html', snippets)

------------------------------------------------- LARGE SNIPPETS -----------------------------------------------

ls.add_snippets('typescriptreact', {
  s(
    'mkcomp', -- make component
    fmt(
      [[
type T{} = {{}};

export function {}(props:T{}) {{
	console.log('props', props)
  return (
    <div>
      <p>{}</p>
    </div>
  );
}};
      ]],
      {
        i(1, 'MyComponent'),
        rep(1),
        rep(1),
        rep(1),
      }
    )
  ),
})

ls.add_snippets('typescriptreact', {
  s(
    'mktest', -- make new test
    fmt(
      [[
        import {{ describe, it, expect }} from 'vitest';
        import {{ render }} from '@testing-library/react';
        import {{ {} }} from '..';

        describe('Suite test for {} , () => {{
          it('Should be render correcly', () => {{
            const screen = render(<{} />);

            expect(screen.container).toBeInTheDocument()
          }})

        }})
      ]],
      {
        i(1, 'Component'),
        rep(1),
        rep(1),
      }
    )
  ),
})

---------------------------------- REACT QUERY SNIPPETS --------------------------------

local creayeQuery = {
  s(
    'mkquery', --- useQuery
    fmt(
      [[

        import {{ AxiosError }} from 'axios';
        import {{ useQuery }} from 'react-query';

        type TParams = {{

        }};

        type TResponse = {{

        }}

        const {} = async(params: TParams) => {{
          try {{
            const response = await API.get<TResponse>();

            return response.data;
          }} catch (e) {{
              const error = e as AxiosError;

              throw new Error(error.message)
          }}
        }};

        export const useGet{hook} = (params: TParams) => {{
          return useQuery(['GET_{}', params], async() => await {}(params))
        }}
      ]],
      {
        i(1, ''),
        hook = l(l._1:sub(1, 1):upper() .. l._1:sub(2, -1), 1),
        rep(1),
        rep(1),
      }
    )
  ),
}
ls.add_snippets('typescriptreact', creayeQuery)
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

return {}
