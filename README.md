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

## 2. An infinite sum of square roots