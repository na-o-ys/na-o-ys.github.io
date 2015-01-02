---
layout: competition
date: 2014-12-29
contest: Topcoder SRM
competition: 640 Div1
problem_type: Easy
problem_name: ChristmasTreeDecoration
---

特に引っ掛けは無いので, 方針だけ思いつけば簡単な問題.

# 問題

[http://community.topcoder.com/stat?c=problem_statement&pm=13551&rd=16083]

N (<50) 個の星と M (<200) 個のリボンがある. 星はそれぞれ色があり, i 番目の星の色は col[i] で与えられる. リボンは指定された 2 つの星を結ぶことができる. j 番目のリボンは星 x[j] と星 y[j] を結ぶことができる.

このような配列 col, x, y が与えられたときに, リボンを適切に選んで全ての星を連結にしたい. ただし, 同じ色の星を結ぶリボンの数が最も少なくなるようにしたい. 同じ色の星を結ぶリボンの最小値を求めよ.

与えられた全てのリボンを使うと全ての星が連結となることは保証されている.

# 方針

異なる色の星を結ぶリボンのみを使ってグラフを作る. グラフの連結成分の個数 g を求める. 与えられた全てのリボンを使うと全ての星が連結となることが保証されているので, 連結成分同士をつなぐ g-1 個の同色リボンが必ず存在する.よって, g-1 が求める答えとなる.

# 解答

```cpp
class ChristmasTreeDecoration
{
public:
    vector<int> G[51];
    int vis[51] = {};

    int solve (vector <int> col, vector <int> x, vector <int> y)
    {
        int N = col.size(), M = x.size();
        loop (M, i) {
            if (col[x[i]-1] == col[y[i]-1]) continue;
            G[x[i]-1].push_back(y[i]-1);
            G[y[i]-1].push_back(x[i]-1);
        }

        int g = 0;
        loop (N, i) {
            if (vis[i]) continue;
            dfs(i);
            g++;
        }
        return g-1;
    }

    void dfs(int cur)
    {
        if (vis[cur]) return;
        vis[cur] = true;
        for (int nxt : G[cur]) dfs(nxt);
    }
};
```
