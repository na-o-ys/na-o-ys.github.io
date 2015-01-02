---
layout: competition
date: 2014-11-04
contest: Topcoder SRM
competition: 638 Div1
problem_type: Med
problem_name: NarrowPassage2
---

本番では解けなかったけど, 綺麗な DP 問題だった.

# 問題

[http://community.topcoder.com/stat?c=problem_statement&pm=13295]

廊下に N (<= 50) 匹の狼が配置されている. 各狼のサイズは vector<int\> size で与えられている. 二匹の狼がすれ違えるのは, サイズの合計が maxSumSize 以下の場合のみである. 狼の並び方の総数を 1000000007 の剰余で答えよ.

# 方針

最小の狼 m について考える. m がすれ違えない狼は, m 以外のどの狼ともすれ違えないので, 位置は固定.

よって答えは以下の再帰式で表せる.

count(size, maxSumSize) = m が動ける範囲 * count(m を除いた size, maxSumSize)

# 解答
```cpp
#include <algorithm>
#include <vector>
#include <iostream>

using namespace std;
using ll = long long;
const ll MOD = 1000000007;

class NarrowPassage2
{
public:
    int count(vector <int> size, int maxSizeSum)
    {
        int N = size.size();
        if (!N) return 1;
        auto m = min_element(size.begin(), size.end());
        int idx = distance(size.begin(), m);
        ll cnt = 1;
        for (int i = idx+1; i < N && size[i]+*m <= maxSizeSum; i++) cnt++;
        for (int i = idx-1; i >= 0 && size[i]+*m <= maxSizeSum; i--) cnt++;
        size.erase(m);
        return (cnt * count(size, maxSizeSum)) % MOD;
    }
};
```
