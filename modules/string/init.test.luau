--!strict

local test = require('@std/test')
local String = require('../string')

test.case('IsContinuation', function(a)
	a.eq(String.IsContinuation(0x80), true)
	a.eq(String.IsContinuation(0xBF), true)
	a.eq(String.IsContinuation(0xC0), false)
	a.eq(String.IsContinuation(0x41), false)
	a.eq(String.IsContinuation(nil), false)
end)

test.case('CommonPrefixBytes', function(a)
	a.eq(String.CommonPrefixBytes('hello', 'help'), 3)
	a.eq(String.CommonPrefixBytes('abc', 'xyz'), 0)
	a.eq(String.CommonPrefixBytes('abc', 'abc'), 3)
	a.eq(String.CommonPrefixBytes('', 'abc'), 0)

	-- é encoded as 0xC3 0xA9; prev has 'caf' + é, next has 'caf' + different continuation
	local prev = 'caf\xC3\xA9'
	local next = 'caf\xC3\xA8'
	a.eq(String.CommonPrefixBytes(prev, next), 3)
end)

test.case('Diff', function(a)
	local kept, suffix = String.Diff('hello', 'help')
	a.eq(kept, 3)
	a.eq(suffix, 'p')

	local kept2, suffix2 = String.Diff('abc', 'xyz')
	a.eq(kept2, 0)
	a.eq(suffix2, 'xyz')
end)

test.case('TrueLength', function(a)
	a.eq(String.TrueLength('hello'), 5)
	a.eq(String.TrueLength('café'), 4)
	a.eq(String.TrueLength(''), 0)
end)

test.case('StartsWith', function(a)
	a.eq(String.StartsWith('hello world', 'hello'), true)
	a.eq(String.StartsWith('hello world', 'world'), false)
	a.eq(String.StartsWith('hi', ''), true)
end)

test.case('EndsWith', function(a)
	a.eq(String.EndsWith('hello world', 'world'), true)
	a.eq(String.EndsWith('hello world', 'hello'), false)
	a.eq(String.EndsWith('hi', ''), true)
end)

test.case('CountOccurrences', function(a)
	a.eq(String.CountOccurrences('abababab', 'ab'), 4)
	a.eq(String.CountOccurrences('aaaa', 'aa'), 2)
	a.eq(String.CountOccurrences('hello', 'z'), 0)
	a.eq(String.CountOccurrences('hello', ''), 0)
end)

test.case('LCS', function(a)
	a.eq(String.LCS('ABCBDAB', 'BDCABA'), 'BDAB')
	a.eq(String.LCS('abc', 'abc'), 'abc')
	a.eq(String.LCS('abc', 'xyz'), '')
end)

test.case('ToTitleCase', function(a)
	a.eq(String.ToTitleCase('hello world'), 'Hello World')
	a.eq(String.ToTitleCase('HELLO world'), 'Hello World')
end)

test.case('ToCamelCase', function(a)
	a.eq(String.ToCamelCase('hello_world'), 'helloWorld')
	a.eq(String.ToCamelCase('hello-world'), 'helloWorld')
	a.eq(String.ToCamelCase('HelloWorld'), 'helloWorld')
	a.eq(String.ToCamelCase('hello world'), 'helloWorld')
end)

test.case('ToSnakeCase', function(a)
	a.eq(String.ToSnakeCase('helloWorld'), 'hello_world')
	a.eq(String.ToSnakeCase('hello-world'), 'hello_world')
	a.eq(String.ToSnakeCase('Hello World'), 'hello_world')
end)

test.case('ToKebabCase', function(a)
	a.eq(String.ToKebabCase('helloWorld'), 'hello-world')
	a.eq(String.ToKebabCase('hello_world'), 'hello-world')
	a.eq(String.ToKebabCase('Hello World'), 'hello-world')
end)
