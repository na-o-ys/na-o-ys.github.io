---
layout: competition
date: 2014-09-10
contest: Topcoder SRM
competition: '632'
problem_type: Div1 Easy
problem_name: PotentialArithmeticSequence
---

# 問題
a[0], ..., a[N-1] の N 個の非負整数がある. ただし, a は与えられない. 代わりに, 2進数表現での trailing zero の数 d[0], ..., d[N-1] が与えられる.
a[0], ..., a[N-1] について, 1 ずつ増加する部分列の個数の最大値を求めよ.

- 1 <= N <= 50
- 0 <= d[i] <= 10^9

# 解法
全ての i, j (i < j) について d[i], ..., d[j] が 1 ずつ増加する数列になりうるかどうかを確かめる.

必要十分条件: 2^(k+1) 個おきに, k が出現する

# 解答
```cpp
class PotentialArithmeticSequence
{
public:
    int numberOfSubsequences (vector <int> d)
    {
        int N = d.size();
        int ans = 0;
        loop (N, i) loop (N, j) {
            if (i > j) continue;

            vector<int> e;
            from_to(i, j, k) e.push_back(d[k]);
            bool ok = true;
            int k = 0;
            for (; ok && e.size() > 1; k++) {
                int l = e[e.size()-1] == k ? e.size()-1 : e.size()-2;
                while (ok && l >= 0) {
                    if (e[l] == k) e.erase(e.begin()+l);
                    else ok = false;
                    l -= 2;
                }
            }
            if (ok && e[0] >= k) ans++;
        }
        return ans;
    }
};

```
