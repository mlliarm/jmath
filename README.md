# jmath
Answering to mathematical questions using J.

A series of mini-projects.

## 1. Complex primes

### Problem statement

The other day I was playing with J, and noticed that

```j
	|1j1
1.41421
```

This number looked familiar. 

Of course, it's the square root of 2, since the modulus of a complex number `z = a + j*b` is defined as:

```j
|z = (a*a + b*b)^%2
```

And in our case we had `a = b = 1`, and so:

```j
	|z = (1*1 + 1*1)^%2
1.41421
```

So my question was the following:

- If `1j1` is the complex number whose modulus corresponds to the square root of two (`2^%2`), which complex number corresponds to the square root of three (`3^%2`)? Which one for the square root of five (`5^%2`), which for (`7^%2`), etc... which complex number corresponds to any square root of any odd number?

### Solution

#### Geometric interpretation

First of all let's resort to the complex plane, where the complex numbers live.

Let's assume real numbers a, b and n an odd natural number (n > 0 and ).What's the locus of the equation (how does it look like?):

```j
(a*a + b*b)^%2 = n^%2
```

(I wonder if J supports parametric plots?)

#### a + j\*a

 If `a = b` in the complex number `z = a + j*b`, then one can easily prove that the modulus of this complex number corresponds to square roots with even number under the root:

```j
|aja = n^%2 

(a*a + a*a)^%2 = n^%2

2*a*a = (+/-) n 	NB. and since a must be an integer, we keep only the positive value in the RHS

a = (+/-) (n/2)^%2

NB. Now a above has integer values only if n is even, that is n = 2*k, for k in {1, 2, 3, ...}

a = (+/-) k^%2 	NB. QED.
```

#### a + j\*b, n square

If n is a square then things are simple too, since this problem is being reduced to the problem of the [Pythagorean triples](https://en.wikipedia.org/wiki/Pythagorean_triple), where there [are many](https://en.wikipedia.org/wiki/Formulas_for_generating_Pythagorean_triples) known algorithms for producing them.

#### a + j\*b, n odd

TBD.

#### a + j\*b, n prime

TBD.

## 2. An infinite sum of square roots

## 3. Exploring infinity

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

There is also a symbol for the [indeterminate form](https://code.jsoftware.com/wiki/Vocabulary/underdot), the underscore dot character. If we recall from high school, the indetermimnate form is a result of operations such as: infinity - infinity, infinity/infinity, 0^0, 0/0, infinity^infinity. Let's try those out in J:

```j
 _ - _			NB. Infinity - Infinity
|NaN error		NB. Result: NaN error, should have been _.
|   _    -_

_%_			NB. Infinity/Infinity
|NaN error	NB. Result: domain error, should have been _.
|   _    /_

   0^0			NB. 0^0
1 			NB. This should have been _.

   0%0			NB. 0/0
0			NB. This should have been _.
   
	_^_		NB. Infinity^Infinity
_			NB. Result: Infinity, should have been _.
```

So we see that currently there are some issues with `j903` regarding infinities, or more specifically, the indeterminate form doesn't arise in places where it did in mathematics. But not all is bad:

```j
	1-_		NB. 1 - Infinity
__			NB. Result: -Infinity, correct.

	1+_ 		NB. 1 + Infinity
_ 			NB. Result: Infinity, correct.

	1%0 		NB. 1/0
_ 			NB. Result: Infinity, correct.

	1%_ 		NB. 1/Infinity
0 			NB. Result: 0, correct.

	_+_ 		NB. Infinity + Infinity
_ 			NB. Result: Infinity, correct.

	_-__ 		NB. Infinity - (-Infinity)
_ 			NB. Infinity, correct.

	_*_ 		NB. Infinity*Infinity
_ 			NB. Infinity, correct (I guess).
```

Reading further the [article](https://code.jsoftware.com/wiki/Vocabulary/underdot) shared earlier on indeterminater forms, we understand that the correct J code should use the underdot character only as a flag for badly formed data in our dataset. An example taken from that page due to [Ian Clark](https://code.jsoftware.com/wiki/User:Ian_Clark) follows:

```j
	z=: '.2 0.2 2.45 3E56 3F56 _1 _0 77'

	NB. (".) accepts non-J-numerals like '.2' and '3E56' but not '3F56' ...
   	".z
|ill-formed number
|       ".z

   	_. ".z    NB. Replacing ill formed numbers with indeterminate form _.
0.2 0.2 2.45 3e56 _. _1 0 77

   	0 ".z     NB. replace bad-numerals by ZERO
0.2 0.2 2.45 3e56 0 _1 0 77

   	_ ".z     NB. replace bad-numerals by INFINITY
0.2 0.2 2.45 3e56 _ _1 0 77
```

The interested reader can further their knowledge on infinities and indeterminate forms in the following articles:
- [Roger Hui, 2008](https://code.jsoftware.com/wiki/Essays/Indeterminate): an essay.
- [E.E. McDonnell, Jeffrey O. Shallit](https://www.jsoftware.com/papers/eem/infinity.htm), APL 80 Conference Proceedings, 1980 6 24.
- [R. W.W. Taylor, 1982](https://dl.acm.org/doi/10.1145/390006.802264), Indexing infinite arrays: Non-finite mathematics in APL.
- [Harvey Davies, 1995](https://dl.acm.org/doi/10.1145/206913.206953), Infinity arithmetic, comparisons and J.
