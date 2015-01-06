---
layout: competition
date: 2014-12-30
contest: Codeforces
competition: Good Bye 2014
problem_type: D
problem_name: New Year Santa Network
---

方針を考えるのが楽しい問題だった.

# 問題

<http://codeforces.com/contest/500/problem/D>

ノード数 N (< 100000) の木が与えられる. 各辺は長さを持つ. 1 年に一回, ある辺の長さが更新される. 3 頂点 a, b, c を一様ランダムに選んだ時の, D = distance(a, b) + distance(b, c) + distance(c, a) の期待値を q (< 100000) 年分に求めよ.

# 方針

各辺について, 辺が D に含まれる（a-b-c のパスの一部になる）確率を求め, 期待値計算をする. 年毎に期待値を更新して出力する.

ある辺について考えた時に, 辺が D に含まれる回数は 0 回または 2 回である. 0 回となるのは, 辺のどちらか片側に a, b, c が全て含まれる場合である.

そこで各辺について, 辺の片側に a, b, c が全て含まれる確率を計算する. 辺の片側のノード数が分かればこれは計算できる.

辺の片側のノード数は, 深さが大きい方の端点の子の数と一致する. よって事前に各頂点の深さと子の数を DFS で計算しておく.

# 解答

```cpp
using ll = long long;
using P = pair<int, int>;

const int MAX = 100010;

int degree[MAX] = {};
int children[MAX] = {};
P road[MAX];
double prob[MAX];
vector<int> G[MAX];

int dfs(int prev, int cur, int d)
{
    degree[cur] = d;
    for (int nxt : G[cur]) {
        if (nxt == prev) continue;
        children[cur] += dfs(cur, nxt, d+1)+1;
    }
    return children[cur];
}

ll perm3(ll m)
{
    return m * (m-1) * (m-2);
}

int main(int argc, char const* argv[])
{
    int n; cin >> n;
    vector<P> road;
    vector<int> len;
    loop (n-1, i) {
        int a, b, l; cin >> a >> b >> l;
        a--; b--;
        G[a].push_back(b);
        G[b].push_back(a);
        road.emplace_back(a, b);
        len.push_back(l);
    }

    // 各 node の深さと子の数計算
    dfs(-1, 0, 0);

    loop (n-1, i) {
        int a = road[i].first, b = road[i].second;
        if (degree[a] > degree[b]) swap(a, b);

        // road[i] の方側のノード数
        int count = children[b]+1;

        double probZero = (1.0*perm3(count) + perm3(n-count)) / perm3(n);
        // 3 点が road[i] をまたぐ確率
        prob[i] = 1.0 - probZero;
    }

    // 期待値初期値
    double exp = 0;
    loop (n-1, i) exp += prob[i] * len[i] * 2;

    int q; cin >> q;
    vector<int> r(q), w(q);
    loop (q, i) { cin >> r[i] >> w[i]; r[i]--; }

    cout << setprecision(10) << fixed;
    loop (q, i) {
        int idx = r[i];
        exp -= prob[idx] * len[idx] * 2;
        len[idx] = w[i];
        exp += prob[idx] * len[idx] * 2;
        cout << exp << endl;
    }

    return 0;
}
```
