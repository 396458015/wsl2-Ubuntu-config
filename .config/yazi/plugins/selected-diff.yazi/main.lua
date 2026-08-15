--- @sync entry
--- @since 26.5.6

local NVIM = "nvim"

return {
	entry = function()
		local files = {}

		for _, url in pairs(cx.active.selected) do
			table.insert(files, tostring(url))
		end

		if #files ~= 2 then
			ya.notify {
				title = "selected-diff",
				content = "Please select exactly two files, currently selected "
					.. tostring(#files)
					.. ".",
				timeout = 3,
			}
			return
		end

		ya.emit("shell", {
			NVIM
				.. " -d "
				.. ya.quote(files[1])
				.. " "
				.. ya.quote(files[2]),
			block = true,
			confirm = false,
		})
	end,
}
