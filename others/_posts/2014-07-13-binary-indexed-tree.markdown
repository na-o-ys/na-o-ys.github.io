---
layout: post
date: 2014-07-13
title: Binary Indexed Tree (BIT, Fenwick Tree)
---

# 概要

整数列 $$ a_1, a_2, ..., a_n $$ に対して, 以下のクエリを O(log(n)) で実現するデータ構造.

1. $$ {\rm sum}(i) $$: $$ a_1 + a_2 + ... + a_i $$ を求める
2. $$ {\rm add}(i, x) $$: $$ a_i $$ に $$ x $$ を加える

# 特徴
Segment Tree の機能縮小版で, 実装がむちゃくちゃ簡単.

# 構造
深さ log(n) の二分木であり, 各ノードは以下の法則で値を保持する.

1. *葉*: $$ a_1,\ a_3,\ a_5,\ a_7, \dots $$
2. *葉の親*: $$ a_1+a_2,\ a_5+a_6,\ a_9+a_{10}, \dots $$
3. *葉の親の親*: $$ a_1+a_2+a_3+a_4,\ a_9+a_{10}+a_{11}+a_{12}, \dots $$

クエリ処理は, 葉から根へ高々 log(n) 回の計算で完了する.  
例えば, $$ {\rm sum}(7) $$ は $$ (a_7) + (a_5+a_6) + (a_1+a_2+a_3+a_4) $$ で求められる.

# 用途
転倒数 (inversion) を求めるなど

# 実装に関する補足
木を配列としてうまく持つことで実装がものすごく簡易になる. 詳細は下記ページを参照.

TopCoder Algorithm Tutorial: http://community.topcoder.com/tc?module=Static&d1=tutorials&d2=binaryIndexedTrees  
わかりやすいスライド: http://hos.ac/slides/20140319_bit.pdf

# 実装
```cpp
class BIT
{
public:
    vector<int> bit;
    int M;

    BIT(int M):
        bit(vector<int>(M+1, 0)), M(M) {}

    int sum(int i) {
        if (!i) return 0;
        return bit[i] + sum(i-(i&-i));
    }

    void add(int i, int x) {
        if (i > M) return;
        bit[i] += x;
        add(i+(i&-i), x);
    }
};
```

# 暗唱のポイント

* 1-indexed
* (i&-i) で rightmost set bit だけ取り出せる
* [木](http://3.bp.blogspot.com/-FqWT3_Q3qiQ/TVd0wTX5tUI/AAAAAAAAAAc/d-r3rGxiVXE/s1600/structure+ft.png) について, sum は重ならない方向(左), add は重なる方向(右)
