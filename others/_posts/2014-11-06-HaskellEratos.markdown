---
layout: post
date: 2014-11-06 08:54:33
title: Haskellでエラトステネスのふるい (Data.Set編)
---

最近、[Project Euler](https://projecteuler.net) の問題をぽちぽち解いていってます。どうせやるなら慣れていない言語でやろう！ということで Python とか Haskell を触ってるのですが、イミュータブルなデータ構造が基本の Haskell でアレコレやるのは本当に難しい。

例えば [Summation of primes](https://projecteuler.net/problem=10) を考えてみます。

> The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.  
> Find the sum of all the primes below two million.

2\*10^6 未満の素数の和を求めよという問題。**エラトステネスのふるい** で素数リストを作って足せば良い問題です。

# C++

C++ で実装するとこんな感じになります。

```cpp
vector<bool> isPrime(N, true);
isPrime[0] = isPrime[1] = false;
for (int i = 2; i*i < N; i++) {
    if (!isPrime[i]) continue;
    for (int j = i*i; j < N; j += i) isPrime[j] = false;
}
```

比較のために、単純な試し割り法も載せてみます。

```cpp
vector<bool> isPrime(N, true);
isPrime[0] = isPrime[1] = false;
for (int i = 2; i < N; i++) {
    for (int j = 2; j*j <= i; j++) {
        if (i%j == 0) isPrime[i] = false;
    }
}
```

試し割りの場合は二重ループが全て実行されて計算量 O(N√N) であるのに対して、エラトステネスのふるいのループ回数は大体 N/2 + N/3 + N/5 + N/7 + ... で、素数の逆数和 = loglogN より、O(NloglogN) くらいになります。

ポイントは、各値に約数があるかどうかを調べるのではなく、**各値の倍数を素数リストから除外** していること。

# Haskell

Haskell でナイーブな試し割り法を実装するとすごくシンプルになります((ただし、√N で打ち切ること無く N 以下の素数を全部試すので、計算量は O(N^2/logN) くらい))。

```haskell
primes :: [Integer] -> [Integer]
primes [] = []
primes (x:xs) = x : primes [y | y <- xs, mod y x /= 0]
```

一方でエラトステネスの実装はシンプルにはいかないようです。Haskell ではイミュータブルなデータ構造が基本なので、「素数リストから除外」を定数時間で実行させるのが難しい。

例えば C++ の例のように、素数リストを Bool の List で表して除外処理を実装した場合、除外位置より手前の全要素をコピーすることになり、除外処理の計算量は O(N) 、全体の計算量は O(N^2 loglogN) となってしまいます。これではナイーブな試し割りより性能が悪いです。

そこで、Data.Set を使ってみます。これはいわゆる平衡木で、insert と delete が O(logN) で実行できるデータ構造です。コピーして再構成するのに O(N) かかりそうなものだけど、再構成するのは対象ノードからルートまでのパスだけで良いので O(logN) で済むらしい <http://stackoverflow.com/questions/14165989/how-is-insert-ologn-in-data-set>。

[こちらの記事](http://techtipshoge.blogspot.jp/2011/07/haskell4.html) では Data.Set を使って O(N\*log^2 N) のふるいが実装されています。下のコードはこれを少し改良して、C++で書いた上述のアルゴリズムに近づけたものです((全ての整数の倍数を除外するか、素数のみの倍数を除外するかの違い))。

```haskell
seive :: Integer -> Set Integer -> Set Integer
seive p xs
  | p*p > findMax xs = xs
  | otherwise        = seive nextP (xs \\ mults)
    where mults = fromAscList [p*p, (p+1)*p .. findMax xs]
          nextP = fromJust $ lookupGT p xs
primes :: Integer -> [Integer]
primes m = toList $ seive 2 $ fromAscList [2..m]
```

xs (素数候補リスト) から mults (素数の倍数) を除外する処理を繰り返し実行します。一つの値の除外処理に O(logN) かかるので、計算量は O(N\*logN\*loglogN) となります。[Summation of primes](https://projecteuler.net/problem=10) で求められる 2\*10^6 の場合、5秒くらいで計算できました。

# 参考

試し割り: <http://haskell.g.hatena.ne.jp/nobsun/20060618/p1>

優先順位つきキュー O(nlog^2 n): <http://qnighy.hatenablog.com/entry/20100714/1279082530>

Data.Set O(nlog^2 n): <http://techtipshoge.blogspot.jp/2011/07/haskell4.html>

ミュータブルな実装: <http://d.hatena.ne.jp/g940425/20110827/1314442246>
