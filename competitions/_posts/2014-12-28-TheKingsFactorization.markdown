---
layout: competition
date: 2014-12-28
contest: Topcoder SRM
competition: '643'
problem_type: Div1 Easy
problem_name: TheKingsFactorization
---

本番は素数リスト作ったけどその必要も無かった.

# 問題

[http://community.topcoder.com/stat?c=problem_statement&pm=13594&rd=16086]

10^18 以下の整数 N が与えられる. N を素因数分解せよ. ただしヒントとして, 昇順 0, 2, 4, 6, ... 番目の素因数が与えられる. (e.g. N = 60 の場合, 素因数 {2, 2, 3, 5} のうち {2, 3} が与えられる.)

# 方針

ヒントを考慮しない場合, √10^18 = 10^9 までの試し割りが必要となり, 計算量オーバーする.

ヒントの素因数以外で, 10^6 を超える素因数は高々 1 つである. よって, 10^6 までを試し割れば良い.

# 解答

```cpp
using ll = long long;
const int MAX = 1000001;

class TheKingsFactorization
{
public:
    vector<long long> getVector (long long N, vector<long long> primes)
    {
        for (ll p : primes) N /= p;

        for (int i = 2; i < MAX; i++) {
            while (N%i == 0) {
                primes.push_back(i);
                N /= i;
            }
        }
        if (N > 1) primes.push_back(N);

        sort(primes.begin(), primes.end());
        return primes;
    }
};
```
