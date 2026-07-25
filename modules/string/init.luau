--!strict

--[=[
	@class String

	A module providing string utilities.
]=]

local String = {}

--[=[
	@within String
	@param b number?
	@return boolean

	Checks if a byte is a UTF-8 continuation byte (10xxxxxx).
]=]
function String.IsContinuation(b: number?): boolean
	return b ~= nil and b >= 0x80 and b < 0xC0
end

--[=[
	@within String
	@param prev string
	@param next string
	@return number

	Returns count of bytes shared as a common prefix between `prev` and `next`,
	backing off if it would land mid UTF-8 codepoint.
]=]
function String.CommonPrefixBytes(prev: string, next: string): number
	local limit = math.min(#prev, #next)

	local i = 1
	while i <= limit and prev:byte(i) == next:byte(i) do
		i += 1
	end

	while i > 1 and String.IsContinuation(next:byte(i)) do
		i -= 1
	end

	return i - 1
end

--[=[
	@within String
	@param prev string
	@param next string
	@return (number, string)

	Diffs `next` against `prev`, returning the number of bytes kept from `prev`
	and the remaining suffix of `next` that changed.
]=]
function String.Diff(prev: string, next: string): (number, string)
	local kept = String.CommonPrefixBytes(prev, next)
	return kept, next:sub(kept + 1)
end

--[=[
	@within String
	@param str string
	@return number?

	Returns the number of UTF-8 codepoints in `str`, as opposed to `#str`
	which counts bytes.
]=]
function String.TrueLength(str: string): number?
	return utf8.len(str)
end

--[=[
	@within String
	@param str string
	@param prefix string
	@return boolean
]=]
function String.StartsWith(str: string, prefix: string): boolean
	return str:sub(1, #prefix) == prefix
end

--[=[
	@within String
	@param str string
	@param suffix string
	@return boolean
]=]
function String.EndsWith(str: string, suffix: string): boolean
	return suffix == '' or str:sub(-#suffix) == suffix
end

--[=[
	@within String
	@param str string
	@param sub string
	@return number

	Counts occurrences of `sub` in `str`.
]=]
function String.CountOccurrences(str: string, sub: string): number
	if sub == '' then return 0 end

	local count = 0
	local i = 1
	while true do
		local s = str:find(sub, i, true)
		if not s then break end
		count += 1
		i = s + #sub
	end

	return count
end

--[=[
	@within String
	@param s1 string
	@param s2 string
	@return string

	Returns the longest common subsequence of `s1` and `s2`.
]=]
function String.LCS(s1: string, s2: string): string
	local m = #s1
	local n = #s2

	local L = {}
	for i = 0, m do
		L[i] = {}
		for j = 0, n do
			L[i][j] = 0
		end
	end

	for i = 1, m do
		for j = 1, n do
			if s1:sub(i, i) == s2:sub(j, j) then
				L[i][j] = L[i - 1][j - 1] + 1
			else
				L[i][j] = math.max(L[i - 1][j], L[i][j - 1])
			end
		end
	end

	local lcsStr = {}
	local i = m
	local j = n

	while i > 0 and j > 0 do
		if s1:sub(i, i) == s2:sub(j, j) then
			table.insert(lcsStr, 1, s1:sub(i, i))
			i -= 1
			j -= 1
		elseif L[i - 1][j] > L[i][j - 1] then
			i -= 1
		else
			j -= 1
		end
	end

	return table.concat(lcsStr)
end

do -- Word case conversions
	local function ToWords(str: string): {string}
		local spaced = str:gsub('(%l)(%u)', '%1 %2')
		spaced = spaced:gsub('[_%-]', ' ')

		local words = {}
		for word in spaced:gmatch('%S+') do
			table.insert(words, word:lower())
		end

		return words
	end

	--[=[
		@within String
		@param str string
		@return string

		Capitalizes the first letter of each word, lowercasing the rest.
	]=]
	function String.ToTitleCase(str: string): string
		return (str:gsub("(%a)([%w_']*)", function(first: string, rest: string)
			return first:upper() .. rest:lower()
		end))
	end

	--[=[
		@within String
		@param str string
		@return string

		Converts to camelCase.
	]=]
	function String.ToCamelCase(str: string): string
		local words = ToWords(str)
		if #words == 0 then return '' end

		local result = words[1]
		for i = 2, #words do
			local word = words[i]
			result ..= word:sub(1, 1):upper() .. word:sub(2)
		end

		return result
	end

	--[=[
		@within String
		@param str string
		@return string

		Converts to snake_case.
	]=]
	function String.ToSnakeCase(str: string): string
		return table.concat(ToWords(str), '_')
	end

	--[=[
		@within String
		@param str string
		@return string

		Converts to kebab-case.
	]=]
	function String.ToKebabCase(str: string): string
		return table.concat(ToWords(str), '-')
	end
end

return table.freeze(String)
