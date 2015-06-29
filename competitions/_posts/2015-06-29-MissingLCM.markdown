---
layout: competition
date: 2015-06-29
contest: Topcoder SRM
competition: '661'
problem_type: Div1 Easy
problem_name: MissingLCM
---

# 問題

<http://community.topcoder.com/stat?c=problem_statement&pm=13766&rd=16464>

lcm(a, b, c, ...) で a, b, c, ... の最小公倍数を表す.

整数 N (< 10^6) が与えられた時に, lcm(1, ..., N) = lcm(N, ..., M) となるような最小の M を求めよ.

# 解法

1 から N に含まれる数のうち, 素数の冪乗で表されるものを考える.

そのような数を P_i としたとき, 条件を満たすためには P_i * 2 が 1 から M に含まれる必要がある.

よって求める M は, max(P_i) * 2 となる.

# 解答

```cpp
class MissingLCM
{
public:
    int getMin (int N)
    {
        vector<int> isPrime(N+1, 1);
        isPrime[0] = isPrime[1] = 0;
        for (int i = 2; i * i <= N; i++) {
            if (!isPrime[i]) continue;
            for (int j = i * i; j <= N; j += i) isPrime[j] = 0;
        }

        int mx = 1;
        for (ll i = 2; i <= N; i++) {
            if (!isPrime[i]) continue;
            ll b = i;
            while (b * i <= N) b *= i;
            mx = max(mx, (int)b);
        }
        return mx * 2;
    }
};
```
