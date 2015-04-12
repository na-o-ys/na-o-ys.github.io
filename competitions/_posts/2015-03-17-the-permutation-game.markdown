---
layout: competition
date: 2015-03-17
contest: Topcoder SRM
competition: '652'
problem_type: Div1 Easy
problem_name: ThePermutationGame
---

# 問題

<http://community.topcoder.com/stat?c=problem_statement&pm=13229&rd=16316>

整数 N (< 100,000) が与えられる. 1 ~ N の置換 (1 ~ N を並び替えた配列) P を考える. 置換 P を m 回適用した結果を f(m) とする. f(1) = P(1), f(2) = P(P(1)), ...

長さ N の任意の置換について, f(x) = 1 となるような最小の x を求めよ. 答えを 1,000,000,007 の剰余で出力せよ.

# 解法

1 ~ N の最小公倍数を求めれば良い. 各素因数の最大指数を取り出していく.

# 解答

<script src="https://gist.github.com/na-o-ys/902899311a3983aeac56.js"></script>

