# 01. Exploring infinity

J supports infinities, as entities.

For example, if we divide one with zero we get positive infinity:

```j
   1%0
_
```

And if we divide minus one with zero we get negative infinity:

```j
   -1%0
__
```

So, positive infinity has the symbol underscore and the negative infinity the symbol double underscore.

There is also a symbol for the [indeterminate form](https://code.jsoftware.com/wiki/Vocabulary/underdot), the underscore dot character. If we recall from high school, the indetermimnate form is a result of operations such as: infinity - infinity, infinity/infinity, 0^0, 0/0, infinity^infinity (taken from [Wolfram Mathworld](https://mathworld.wolfram.com/Indeterminate.html)). Let's try those out in J:

```j
   0%0             NB. 0/0
0                  NB. Result: 0, should have been _.

   0*_             NB. 0*Infinity
0                  NB. Result: 0, should have been _.

   _%_             NB. Infinity/Infinity
|NaN error         NB. Result: NaN error, should have been _.
|   _    %_

   _-_             NB. Infinity - Infinity
|NaN error         NB. Result: NaN error, should have been _.
|   _    -_

   0^0             NB. 0^0
1                  NB. Result: 1, should have been _.

   _^0             NB. Infinity^0.
1                  NB. Result: 1, should have been _.

   1^_             NB. 1^Infinity
1                  NB. Result: 1, should have been _.

```

So we see that currently there are some issues with `j903` regarding infinities, or more specifically, the indeterminate form doesn't arise in places where it did in mathematics. It seems that this was designed like that on purpose (see [this lemma](https://www.jsoftware.com/help/dictionary/d031.htm) from the jdictionary), so it's working as expected.

That being said, we can still play around with infinities successfully, with results that match our mathematical expectations:

```j
   1-_              NB. 1 - Infinity
__                  NB. Result: -Infinity, correct.

   1+_              NB. 1 + Infinity
_                   NB. Result: Infinity, correct.

   1%0              NB. 1/0
_                   NB. Result: Infinity, correct.

   -1%0             NB. -1/0
__                  NB. Result: -Infinity, correct.


   1%_              NB. 1/Infinity
0                   NB. Result: 0, correct.

   _+_              NB. Infinity + Infinity
_                   NB. Result: Infinity, correct.

   _-__             NB. Infinity - (-Infinity)
_                   NB. Infinity, correct.

   _*_              NB. Infinity*Infinity
_                   NB. Infinity, correct (I guess).
```

Reading further the [article](https://code.jsoftware.com/wiki/Vocabulary/underdot) shared earlier on indeterminater forms, we understand that the correct J code should use the underdot character only as a flag for badly formed data in our dataset. An example taken from that page due to [Ian Clark](https://code.jsoftware.com/wiki/User:Ian_Clark) follows:

```j
NB. Creating a string of an array that contains bad data inside.
   z=: '.2 0.2 2.45 3E56 3F56 _1 _0 77'
z=: '.2 0.2 2.45 3E56 3F56 _1 _0 77'

NB. (".) accepts non-J-numerals like '.2' and '3E56' but not '3F56'.
   ".z
|ill-formed number
|   .2 0.2 2.45 3E56 3F56 _1 _0 77
|    ^
|       ".z

NB. Replacing ill formed numbers with indeterminate form _.
   _. ".z
0.2 0.2 2.45 3e56 _. _1 0 77

NB. replace bad-numerals by ZERO
   0 ".z
0.2 0.2 2.45 3e56 0 _1 0 77

NB. replace bad-numerals by INFINITY
   _ ".z
0.2 0.2 2.45 3e56 _ _1 0 77
```

The interested reader can further their knowledge on infinities and indeterminate forms reading the following articles:
- [Roger Hui, 2008](https://code.jsoftware.com/wiki/Essays/Indeterminate): an essay on the indeterminate forms.
- [E.E. McDonnell, Jeffrey O. Shallit](https://www.jsoftware.com/papers/eem/infinity.htm), APL 80 Conference Proceedings, 1980 6 24.
- [R. W.W. Taylor, 1982](https://dl.acm.org/doi/10.1145/390006.802264), Indexing infinite arrays: Non-finite mathematics in APL.
- [Harvey Davies, 1995](https://dl.acm.org/doi/10.1145/206913.206953), Infinity arithmetic, comparisons and J.