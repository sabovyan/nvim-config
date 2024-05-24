local M = {}

M.global_snippets = {
	{ trigger = "bang", body = "#!/bin sh" },
}

M.snippets_by_filetype = {
	lua = {
		{ trigger = "asdf", body = "function ${1:name}(${2:args}) $0 end" },
	},

	typescript = {
		{ trigger = "fn", body = "function ${1:name}(${2:args}) {\n \t $0 \n}" },
	},

	typescriptreact = {
		{
			trigger = "ced",
			body = [[
export default function $TM_FILENAME_BASE(${1:args}) {
  return (
    <div><h1>${2:hello}</h1></div>
  )
}
]],
		},
		{
			trigger = "ce",
			body = [[
export default function ${1:name}(${2:args}) {
  return (
    <div><h1>${3:hello}</h1></div>
  )
}
]],
		},
	},
}

return M
