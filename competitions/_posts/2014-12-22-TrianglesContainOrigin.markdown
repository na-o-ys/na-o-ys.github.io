---
layout: commentary
date: 2014-12-22
type: commentary
contest: Topcoder SRM
competition: 641 Div1
problem_type: Easy
problem_name: TrianglesContainOrigin
---

# 問題

[http://community.topcoder.com/stat?c=problem_statement&pm=13309&rd=16084]

2 次元平面上の点が N (< 2500) 個与えられる. これらの点が構成する三角形のうち, 内側に原点を含むものの個数を求めよ.

# 方針

偏角でソートし, 全ての点 i, j (i < j) について, 条件を満たす点 k (> j) の個数を二分探索で求める.

# 解答

```cpp
using ll = long long;
const double PI = atan(1)*4;

class TrianglesContainOrigin
{
public:
    long long count (vector <int> x, vector <int> y)
    {
        int N = x.size();
        vector<double> args(N);
        loop (N, i) args[i] = atan2(y[i], x[i]);
        sort(args.begin(), args.end());

        ll ans = 0;
        loop (N, j) loop (j, i) {
            if (args[j] > args[i]+PI) continue;
            auto s = lower_bound(args.begin(), args.end(), args[i] + PI);
            auto t = lower_bound(args.begin(), args.end(), args[j] + PI);
            ans += distance(s, t);
        }

        return ans;
    }
};
```
