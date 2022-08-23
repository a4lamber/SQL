# 7-7 Running product in SQL
---
> Running product: number multiplication of running product

Goal:
- running product of a $a_n$ series $a_0$, $a_1$,.....$a_n$

Solution:
- Take the running total of their logarithmic form as $b_n$ series such as $ln(a_0)$, $ln(a_0) + ln(a_1)$,$ln(a_0) + ln(a_1) + ln(a_2)$,....
- then, $ln(a_0)$, $ln(a_0\times a_1)$,$ln(a_0\times a_1\times a_2)$,....
- take the exponential of each item in $b_n$ series, there we go $e^{b_n}$ to get the running product

Takehome:
- instead of writing a new UDF, you could take advantage of combining existing functions together will a little trickiness.
