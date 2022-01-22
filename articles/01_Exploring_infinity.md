# 01. Exploring infinity

## Introduction

J supports infinities, as entities.

For example, if we divide one with zero we get positive infinity:

```j
   1%0
_
```

And if we divide minus one with zero we get negative infinity:

```j
   _1%0
__
```

So, positive infinity has the symbol underscore and the negative infinity the symbol double underscore.

## Indeterminate form

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

## Infinities

That being said, we can still play around with infinities successfully, with results that match our mathematical expectations:

```j
   1-_              NB. 1 - Infinity
__                  NB. Result: -Infinity, correct.

   1+_              NB. 1 + Infinity
_                   NB. Result: Infinity, correct.

   1%0              NB. 1/0
_                   NB. Result: Infinity, correct.

   _1%0             NB. -1/0
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

## More on indeterminate forms

Reading further the [article](https://code.jsoftware.com/wiki/Vocabulary/underdot) shared earlier on indeterminate forms, we understand that the correct J code should use the underdot character only as a flag for badly formed data in our dataset. An example taken from that page due to [Ian Clark](https://code.jsoftware.com/wiki/User:Ian_Clark) follows:

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

## Ideas from the community

A user (u/Godspiral) that commented under my [post](https://www.reddit.com/r/apljk/comments/s9ag4k/jmath_answering_to_mathematical_questions_using_j/) in the r/apljk community at Reddit, gave an example where `_.` can arise:

```j
   (% :: (_."_))/ 2  0 _
_

   (% :: (_."_))/ 2  0 _ _
_.

```

If we dissect a bit more the above, it pretty much is an expression created by the verb `(% :: (_."_))`, `/` (reduce) and acts on two lists: `2 0 _` and `2 0 _ _`. Let's take it step by step.

```j
   % 2 0 _        NB. Calculate 1%2 1%0 1%_
0.5 _ 0

   % 2 0 _ _      NB. Calculate 1%2 1%0 1%_ 1%_
0.5 _ 0 0
```

If we use the reduce verb together just before the division verb:

```j
   % / 2 0 _      NB. Is the same as 2%0%_ which is 2%(0%_) so it gives in math notation 2/(0/Inf.) = 2/0 = Inf.
_

   % / 2 0 _ _    NB. Is the same as 2%0%_%_ which is 2%(0%(_%_)) so it gives a NaN error, because that's what _%_ 
|NaN error
|       %/2 0 _ _
```

Now, when we have expressions that return errors related to bad calculations as the above, we can do two things:

1. The old style

Replace the badly formatted result with some other number, like done in the previous example, with the indeterminate form `_.`, with zero `0`, or with infinity `_`. Let's do that.

```j
   (% _. "_)/ 2 0 _ _   NB. Apply division `%` to the nouns on the left, and if you encounter NaN replace with `_.`
_.
```

Let's see what happens if we try to replace the result of `_%_` that gives us headaches with `_` instead:

```j
   (% _ "_)/ 2 0 _ _   NB. Apply division `%` to the nouns on the left, and if you encounter NaN replace with `_`
|NaN error
|       (%_"_)/2 0 _ _
```

Still producing `NaN error` for some reason.

Now, if we replace the result of `_%_` with zero `0` we get:

```j

   (% 0 "_)/ 2 0 _ _   NB. Apply division `%` to the nouns on the left, and if you encounter NaN replace with `0`
_
```

which makes sense, because this is what happens: `2%0%_%_ --> 2%0%0 --> 2%(0%0) --> 2%0 --> _`.


2. The new style

The new style uses the [coco](https://code.jsoftware.com/wiki/Vocabulary/coco) verb `::`. Let's see a simple example first:

```j
   ". '1 2 3 4 mlliarm'   NB. If what's on the rhs of `".` is a number return the number. If not, throw an error.
|syntax error
|       1 2 3 4 mlliarm
```

Now if we use the coco verb, we can make the result instead of throwing a syntax error in our face, to return a more gentle message:

```j
   (". :: 'error, please remove non-numbers from your data') '1 2 3 4 mlliarm'
error, please remove non-numbers from your data
```

We now understand that the suggestion u/Godspiral gave, combined both the old and the new way. In their solution they used the new way to catch the `NaN error`, and then replace the final result of the expression with the indeterminate form `_.`.


## Thanks
- To the users of [r/apljk](https://www.reddit.com/r/apljk/) that bothered to read my article and post a comment:
   - u/hjs2001 for noticing that `-1` should be replaced by `_1` to match the correct J notation of minus one.
   - u/Godspiral for giving the above suggestion on how to get `_.` as a result.
   - u/moonchilled for mentioning that `"_` is redundant in modern versions of J, due to `::` ([coco](https://code.jsoftware.com/wiki/Vocabulary/coco)), and for sharing the reading `5.` below where Eugene defended `0%0` as well as for sharing their viewpoint/best-practices-advice:
   >  Use of `_.` is discouraged; its primary use is interaction with existing arbitrarily-formed ieee-754. The language does not deal consistently with it. I think a better approach would be to maintain a mask identifying indeterminate values, which also allows you to say more about what went wrong.

## Readings

The interested reader can further their knowledge on infinities and indeterminate forms reading the following articles:

1. [Roger Hui](https://code.jsoftware.com/wiki/Essays/Indeterminate): an essay on the indeterminate forms, 2008.
2. [E.E. McDonnell, Jeffrey O. Shallit](https://www.jsoftware.com/papers/eem/infinity.htm), APL 80 Conference Proceedings, 1980 6 24.
3. [R. W.W. Taylor](https://dl.acm.org/doi/10.1145/390006.802264), Indexing infinite arrays: Non-finite mathematics in APL, 1982.
4. [Harvey Davies](https://dl.acm.org/doi/10.1145/206913.206953), Infinity arithmetic, comparisons and J, 1995.
5. [Eugene McDonnell](https://www.jsoftware.com/papers/eem/0div0.htm),Zero divided by zero, APL '76 22 September 1976.