# legacy-program
WORD JUMBLE
An
anagram
is a type of
word play, the result of  rearranging the letters of  a word or phrase to 
produce a new word or phrase. For example the anagram of  
tea
 is tea, tae, eat, eta, aet, ate. 
Anagrams can be used to solve word jumble problems. If  a user provides a series of  jumbled 
letters, all anagrams of  the letters can be generated and then checked to see if  they exist in a 
dictionary. The anagrams appearing in the dictionary are printed as potential solutions to the 
puzzle.

Design and implement an Ada program (
solveJumble
) which solves the individual word 
jumbles and uses a recursive (or non-recursive if  you like) function to generate anagrams from a 
series of  letters. This involves the following series of  modules for each of  the 
n
 jumbles:
1.
A subroutine, 
inputJumble()
, to obtain user input for the set of  jumbles, i.e. jumbled 
letters NELIR, GURPE.
2.
A subroutine, 
generateAnagram()
, to generate the anagrams from the letters for each 
jumbled word.
3.
A subroutine, 
buildLEXICON()
, which builds a dictionary to search for the anagram in, 
from the system dictionary (this should be done once for each session). On OSX the 
dictionary file on OS/X is located in 
/usr/share/dict/words
. Use a data structure of  
some form.
4.
A subroutine, 
findAnagram()
, to search for the anagrams in a dictionary, printing all 
results.
