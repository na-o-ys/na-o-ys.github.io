---
layout: post
date: 2015-01-22
title: 競技プログラミング初期のソースコードと変遷
---

競技プログラミングを始めた最初期の頃 (2014年2月) のコードが見つかったので, 同じ問題を今あらためて解いてみました.

全然違うコードになってておもしろいです.

# 問題

Cup (by JOI 2005) <http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=0503>

A <-> B の移動と B <-> C の移動が交互に繰り返されます. 最初の一手のみ選ぶと, 以降の移動は一意に定まります.

最初の選び方二通りについて, 移動をシミュレートすれば, 最小回数が求まります.

# 初期のコード

<script src="https://gist.github.com/na-o-ys/893133b3d0a49f56d6c9.js?file=0503_early.cpp"></script>

長いですね. 当時はこれを組むのに丸一日かかってました.

ポインタとか stack とか, 今では馴染みがないですが, 当時は色々試行錯誤して使っていました.

# 現在のコード

<script src="https://gist.github.com/na-o-ys/893133b3d0a49f56d6c9.js?file=0503_now.cpp"></script>

データ構造としての int は, かなり, 便利です. and/or/xor/反転/シフトをうまく使えば, 多くの操作が短く表現できます.

これくらいの行数なら一画面におさまるのでデバッグもスムーズにできると思います.

ちなみにこの解法は最悪 10^8 回ループなので, 計算量が危ういです. この問題には [ハノイの塔](http://ja.wikipedia.org/wiki/%E3%83%8F%E3%83%8E%E3%82%A4%E3%81%AE%E5%A1%94) みたいなキレイな解法があって, 計算量がぐっと縮んで実装もシンプルになります. [(source)](https://gist.github.com/na-o-ys/893133b3d0a49f56d6c9#file-0503_hanoi-cpp)
