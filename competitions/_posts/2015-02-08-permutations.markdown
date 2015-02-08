---
layout: competition
date: 2015-02-08
contest: Codeforces
competition: Rockethon 2015
problem_type: B2
problem_name: Permutations
---

# 問題

<http://codeforces.com/contest/513/problem/B2>

# 解法

f(p) が最大となる必要十分条件は, 任意の数 i (1 <= i <= n) について, i より大きい数が全て i の左右に連続して表れることである.

これは, 次の命題と同値である.

- 任意の区間について, 区間内の最も小さい数は区間の両端どちらかに配置されている

このような配列は, 1 から順に空き区間の両端どちらかに配置していくことで構成できる. 長さ n の数列について, 条件を満たすものは 2^(n-1) パターンある.

パターン数をカウントしながら, 1 から順にどちらの端に配置するかを決めていけば良い.

# 解答

<script src="https://gist.github.com/na-o-ys/920922ef5803f6c01e75.js?file=b2.cpp"></script>
