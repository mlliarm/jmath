NB. 01_Exploring_infinity.md J code

NB. First encounters with infinities ---------------------------------------------------------------------------
1%0

-1%0

NB. Should (?) be indeterminate forms ---------------------------------------------------------------------------
0%0             NB. 0/0

0*_             NB. 0*Infinity

_%_             NB. Infinity/Infinity

_-_             NB. Infinity - Infinity

0^0             NB. 0^0

_^0             NB. Infinity^0.

1^_             NB. 1^Infinity

NB. More infinities
1-_              NB. 1 - Infinity

1+_              NB. 1 + Infinity

1%0              NB. 1/0

-1%0             NB. -1/0

1%_              NB. 1/Infinity

_+_              NB. Infinity + Infinity

_-__             NB. Infinity - (-Infinity)

_*_              NB. Infinity*Infinity

NB. Using indeterminate form with data analytics -----------------------------------------------------------------

NB. Creating a string of an array that contains bad data inside.
   z=: '.2 0.2 2.45 3E56 3F56 _1 _0 77'

NB. (".) accepts non-J-numerals like '.2' and '3E56' but not '3F56'.
   ".z            NB. returns 'ill-formed number' error

NB. Replacing ill formed numbers with indeterminate form _.
   _. ".z         NB. 0.2 0.2 2.45 3e56 _. _1 0 77

NB. replace bad-numerals by ZERO
   0 ".z          NB. 0.2 0.2 2.45 3e56 0 _1 0 77

NB. replace bad-numerals by INFINITY
   _ ".z          NB. 0.2 0.2 2.45 3e56 _ _1 0 77

NB. Ideas from the community -------------------------------------------------------------------------------------

(% :: (_."_))/ 2  0 _
NB. _

(% :: (_."_))/ 2  0 _ _
NB. _.

% 2 0 _        NB. Calculate 1%2 1%0 1%_
NB. 0.5 _ 0

% 2 0 _ _      NB. Calculate 1%2 1%0 1%_ 1%_
NB. 0.5 _ 0 0

% / 2 0 _      NB. Is the same as 2%0%_ which is 2%(0%_) so it gives in math notation 2/(0/Inf.) = 2/0 = Inf.
NB. _

% / 2 0 _ _    NB. Is the same as 2%0%_%_ which is 2%(0%(_%_)) so it gives a NaN error, because that's what _%_ gives 
NB. |NaN error
NB. |       %/2 0 _ _

(% _. "_)/ 2 0 _ _   NB. Apply division `%` to the nouns on the left, and if you encounter NaN replace with `_.`
NB. _.

(% _ "_)/ 2 0 _ _   NB. Apply division `%` to the nouns on the left, and if you encounter NaN replace with `_`
NB. |NaN error
NB. |       (%_"_)/2 0 _ _

(% 0 "_)/ 2 0 _ _   NB. Apply division `%` to the nouns on the left, and if you encounter NaN replace with `0`
NB. _

". '1 2 3 4 mlliarm'   NB. If what's on the rhs of `".` is a number return the number. If not, throw an error.
NB. |syntax error
NB. |       1 2 3 4 mlliarm

(". :: 'error, please remove non-numbers from your data') '1 2 3 4 mlliarm'
NB. error, please remove non-numbers from your data

