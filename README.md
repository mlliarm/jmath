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

So, positive infinity has the symbol underscore "_" and the negative infinity the symbol double underscore "__".

There is also a symbol for the indeterminate form, "_.". If we recall from high school, the indetermimnate form is a result of operations such as: infinity - infinity, infinity/infinity, 0^0, 0/0, infinity^infinity. Let's try those out in J:

```j
 _ - _			NB. Infinity - Infinity
|NaN error		NB. Result: NaN error, should have been _.
|   _    -_

_/_				NB. Infinity/Infinity
|domain error	NB. Result: domain error, should have been _.
|   _    /_

   0^0			NB. 0^0
1 				NB. This should have been _.

   0%0			NB. 0/0
0				NB. This should have been _.
   
	_^_			NB. Infinity^Infinity
_				NB. Result: Infinity, should have been _.
```

So we see that currently there are some issues with `j903` regarding infinities. But not all is bad:

```j
	1-_			NB. 1 - Infinity
__				NB. Result: -Infinity, correct.

	1+_ 		NB. 1 + Infinity
_ 				NB. Result: Infinity, correct.

	1%0 		NB. 1/0
_ 				NB. Result: Infinity, correct.

	1%_ 		NB. 1/Infinity
0 				NB. Result: 0, correct.

	_+_ 		NB. Infinity + Infinity
_ 				NB. Result: Infinity, correct.

	_-__ 		NB. Infinity - (-Infinity)
_ 				NB. Infinity, correct.

	_*_ 		NB. Infinity*Infinity
_ 				NB. Infinity, correct (I guess).
```

An interesting article that discusses various implementations and uses of infinities with APL is [this one](https://www.jsoftware.com/papers/eem/infinity.htm).
