---
layout: competition
date: 2015-03-26
contest: Topcoder SRM
competition: '654'
problem_type: Div1 Easy
problem_name: SquareScores
---

# 問題

<http://community.topcoder.com/stat?c=problem_statement&pm=13694&rd=16318>

a-z および '?' の文字からなる長さ 1000 以下の文字列 S と, 整数配列 P が与えられる.

'?' には a-z の何れかが入る. ある '?' に a が入る確率は P[0], b が入る確率は P[1] で, c は P[2], ... でそれぞれ与えられる.

S の部分文字列のうち, 単一の文字からなるものの個数の期待値を求めよ.

# 解法

位置 i から位置 j までの部分文字列が文字 c のみからなる確率を dp[c][i][j] で表す.

```
dp[c][i][j] = dp[c][i][j-1]        (j 文字目が文字 c の場合)
            = dp[c][i][j-1] * P[c] (j 文字目が '?' の場合)
            = 0                    (otherwise)
```

で表せる. 求める答えは Σdp である. c, i, j の順番でループを回せば dp を配列に持たずに答えが計算できる.


# 解答

<script src="https://gist.github.com/na-o-ys/e2c87202d2acc7584c97.js"></script>

