-------------------------------------------------
--				NounCompound.lua
--
--	A tool for generating groups of fake words
--	with consistent orthographic rules to
--	suggest a single (fictional) source language
--
--	arg[1] is a Lua file with the definition of a
--	language as templated in TestLang.lua
--
--	arg[2] (optional) is the desired amount of
--	words to generate. Defaults to one (1).
--	Note: Does NOT guarantee unique results.
--
--	Additional optional parameters:
-- 	"u" - Only output unique results
--	Note: Will result in fewer than arg[2] words
--	in final output.
--
--	"c" - Capitalize first letters of each word
--
--	Developed by James Youngman
--	github:	JYoungman
--	Twitter: LazyAhab
-------------------------------------------------

-------------------------------------------------
--Support Function(s)
-------------------------------------------------
--Build a single table of all letters usable 
--in a given position in a word
function GenerateLetterBank(localBank, globalBank)

	local globalIdx = 1
	local bridgeIdx = #localBank + 1
	concatBank = localBank
	
	for letterIdx = bridgeIdx, bridgeIdx + #globalBank do
		concatBank[letterIdx] = globalBank[globalIdx]
		globalIdx = globalIdx + 1
	end
	
	return concatBank
end

--Given an array of words, return only those that
--are unique
function TrimRendundantWords(wordBank)
	
	uniqueWords = {}
	uniqueWords[1] = wordBank[1]
	
	wordCount = #wordBank
	if wordCount > 1 then
		--Compare each word in wordBank against each word
		--currently in the unique bank, adding unique words
		--as the loop progresses
		for bankIdx = 2, wordCount do
			local redundant = false
			for uniqueIdx = 1, #uniqueWords do
				if wordBank[bankIdx] == uniqueWords[uniqueIdx] then
					redundant = true
					break
				end
			end
			
			--Add unique words to the unique list
			if not redundant then
				uniqueWords[#uniqueWords + 1] = wordBank[bankIdx]
			end
		end
	end	
	
	return uniqueWords
end

-------------------------------------------------
--Main Program
-------------------------------------------------
--Validate and process command line arguments
if(arg[1] == nil) then
	print("Please provide a language definition file.")
	os.exit()
end

langDef = dofile(arg[1])
wordCount = 1

if(arg[2] ~= nil) then
	wordCount = arg[2]
end

unique = false
capitalize = false

if(#arg > 2) then
	for curArg = 3, #arg do
		if arg[curArg] == "u" then
			unique = true
		elseif arg[curArg] == "c" then
			capitalize = true
		end
	end
end

--Build tables containing all letters that can be used for each position
letterBanks = {}
letterBanks["cStart"] = GenerateLetterBank(langDef.startingConsonants, langDef.consonants)
letterBanks["cMid"] = GenerateLetterBank(langDef.middleConsonants, langDef.consonants)
letterBanks["cEnd"] = GenerateLetterBank(langDef.endConsonants, langDef.consonants)

letterBanks["vStart"] = GenerateLetterBank(langDef.startingVowels, langDef.vowels)
letterBanks["vMid"] = GenerateLetterBank(langDef.middleVowels, langDef.vowels)
letterBanks["vEnd"] = GenerateLetterBank(langDef.endVowels, langDef.vowels)

--Generate words
math.randomseed(os.time())
words = {}

for word = 1, wordCount do

	local glyphPattern = string.lower(langDef.patterns[math.random(#langDef.patterns)])
	local patternLen = #glyphPattern
	
	local firstChar = string.sub(glyphPattern, 1, 1)
	newWord = letterBanks[firstChar.."Start"][math.random(#letterBanks[firstChar.."Start"])]
	
	if(patternLen > 1) then
		for chr = 2, patternLen do
			curChar = string.sub(glyphPattern, chr, chr)
			
			--Special case for ending characters
			if(chr == string.len(glyphPattern)) then
				newWord = newWord..letterBanks[curChar.."End"][math.random(#letterBanks[curChar.."End"])]
				
			--Otherwise add an appropriate midword character
			else
				newWord = newWord..letterBanks[curChar.."Mid"][math.random(#letterBanks[curChar.."Mid"])]
			end
		end
	end
	
	words[word] = newWord
end

--Optional word list processesing
if unique then
	words = TrimRendundantWords(words)
end

if capitalize then
	for curWord = 1, #words do
		--Simpler process for single letter words
		if #words[curWord] == 1 then
			words[curWord] = string.upper(words[curWord])
		--General case
		else
			firstChar = string.upper(string.sub(words[curWord], 1, 1))
			words[curWord] = firstChar..string.sub(words[curWord], 2)
		end
	end
end

--Generate output file name
fileName = ""
dotIdx = string.find(arg[1], "%.")

if dotIdx then
	fileName = string.sub(arg[1], 1, dotIdx - 1)..os.time()..".txt"
else
	fileName = arg[1]..os.time()..".txt"
end

--Display and log created words
wordFile = io.open(fileName, "w")
for dispWord = 1, #words do
	print(words[dispWord])
	wordFile:write(words[dispWord].."\n")
end
wordFile:close()
os.exit()