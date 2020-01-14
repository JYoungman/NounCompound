# NounCompound
Utility for generating imaginary words with consistent orthography to imply a shared source language.

To use, run NounCompound.lua in the Lua binary of your chosing, with the name of the language file
to be used as the first parameter. By default, generates a single word. This can be overwritten by
passing a number as the second parameter. Will display generated words in the command prompt in
addition to writing them to a plain text file with a name format of [language file filename][system time].txt

Additional optional parameters that can be passed after the word count parameter:
u - Only output unique words. Note that this works by removing redundant words from the output list, and
may therefore output fewer words than the number specified.

c - Capitalize starting letter of each word.

The format of language files is demonstrated in TemplateLanguage.lua. For both vowels and consonants, the
following sets are specified:

Letters that can be used only as the first letter in a word
Letters that can be used only as the last letter in a word
Letters that cannot be used as the first or last letter in a word
Letters that can be used anywhere in a word.

Note that "letters" in the context of the language file are normal Lua strings; it is therefore possible to
define compound glyphs, such as "ch" or "qu".

Additionally, the letter patterns which can be used to make a valid word are defined as a string consisting
exclusively of the characters c and v. When generating a word, any position in the pattern string with the
character c will contain a consonant, and any position with a v will contain a vowel.

Tested using Lua 5.3 binary from Lua.org in Windows 10.
