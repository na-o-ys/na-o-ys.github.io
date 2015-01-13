---
layout: competition
date: 2015-01-10
contest: Topcoder SRM
competition: '636'
problem_type: Div1 Easy
problem_name: ChocolateDividingEasy
---

# 問題

<http://community.topcoder.com/stat?c=problem_statement&pm=13497&rd=16079>

# 方針

累積和 + greedy

# 解答

```cpp
#include <bits/stdc++.h>
 
#define loop(n, i) for(int i=0;i<n;i++)

using namespace std;

class ChocolateDividingEasy
{
public:
    int findBest (vector <string> chocolate)
    {
        int N = chocolate.size(), M = chocolate[0].length();
        int ql[52][52] = {};
        loop (N, i) loop (M, j) ql[i+1][j+1] = chocolate[i][j] - '0';
        loop (N, i) loop (M+1, j) ql[i+1][j] += ql[i][j];
        loop (N+1, i) loop (M, j) ql[i][j+1] += ql[i][j];
        int ans = -1;
        loop (N-1, i1) loop (N-1, i2) loop (M-1, j1) loop (M-1, j2) {
            if (i1 >= i2 || j1 >= j2) continue;
            int I[4] = { 0, i1+1, i2+1, N };
            int J[4] = { 0, j1+1, j2+1, M };
            int area = 1<<29;
            loop (3, i) loop (3, j) {
                area = min(area, ql[I[i+1]][J[j+1]] - ql[I[i]][J[j+1]] - ql[I[i+1]][J[j]] + ql[I[i]][J[j]]);
            }
            ans = max(ans, area);
        }
        return ans;
    }
};
```
