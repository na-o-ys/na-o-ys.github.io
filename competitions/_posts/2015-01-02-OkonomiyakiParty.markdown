---
layout: competition
date: 2015-01-02
contest: Topcoder SRM
competition: (unrated) 644
problem_type: Easy
problem_name: OkonomiyakiParty
---

# 問題

N (< 50) 種類のお好み焼きがある. i 番目の大きさは配列 osize[i] (< 10000) で与えられる. このうち M (< N) 種類を選ぶときに, 最も小さいものと最も大きいものの差が K 以下となるような選び方は何通りあるか, 1,000,000,007 の剰余で求めよ.

# 方針

昇順でソートし, 最も小さいお好み焼きを i としたときの選び方を数え上げる.

# 解答

```cpp
using ll = long long;
const int MOD = 1000000007;

class OkonomiyakiParty
{
public:
    int count(vector <int> osize, int M, int K) {
        fill(memo[0], memo[59]+60, -1);
        int N = osize.size();
        sort(all(osize));
        ll ans = 0;
        loop (N, i) {
            int j = i+1;
            while (j < N && osize[j]-osize[i] <= K) j++;
            ans = (ans + cmb(j-i-1, M-1)) % MOD;
        }
        return ans;
    }

    ll memo[60][60];
    ll cmb(ll n, ll r) {
        if (n < 0 || r < 0 || n < r) return 0;
        if (memo[n][r] != -1) return memo[n][r];
        if (!r) return 1;
        return memo[n][r] = (cmb(n-1, r-1) + cmb(n-1, r)) % MOD;
    }
};
```
