-------------------------------------------------
--				TestLang.lua
--
--	Example language definition file for
--	NounCompound.lua. Demonstrates how to
--	format data such that NounCompound can
--	successfully parse it and use it to 
--	generate fake words.
--
--
--	Developed by James Youngman
--	github:	JYoungman
--	Twitter: LazyAhab
-------------------------------------------------

--Defines the parameters of a language consumed by NounCompound.lua
--Note that consonants and vowels are normal Lua strings, and
--can therefore contains multiple glyphs if desired.

lang = {

	--Consonants that can occur in any part of the word
	consonants =
	{
		"r", "s"
	},
	--Consonants that can only occur at the start of a word
	startingConsonants =
	{
		"b", "d"
	},
	--Consonants that can only occur in the middle of a word
	middleConsonants =
	{
		"m", "n"
	},
	--Consonants that can only occur at the end of a word
	endConsonants =
	{
		"ng", "nd"
	},
	
	--Vowels that can occur in any part of the word
	vowels = 
	{
		"i"
	},
	--Vowels that can only occur at the start of a word
	startingVowels =
	{
		"o"
	},
	--Vowels that can only occur in the middle of a word
	middleVowels =
	{
		"u"
	},
	--Vowels that can only occur at the end of a word
	endVowels =
	{
		"a"
	},
	
	--The patterns of consonants and vowels that can make up a word
	--Use lower case c for consonants and lower case v for vowels
	--Do not use any other characters.
	patterns = {
		"cvc",
		"v",
		"vcvc",
		"cvvc",
		"cvcv"
	}
}

return lang