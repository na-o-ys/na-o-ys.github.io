---
layout: commentary
date: 2014-12-21
type: commentary
contest: Topcoder SRM
competition: 642 Div1
problem_type: Med
problem_name: TaroCutting
---

Med は難しい...

# 問題

[http://community.topcoder.com/stat?c=problem_statement&pm=13319&rd=16085]

木が N 本ある. n 番目の木は高さ height[n] であり, 1 日に add[n] だけ伸びる. また, カッターが M 個ある. m 番目のカッターをある木に対して使うと, 木の高さは device[m] になる.

太郎は 1 日の終わりにカッターで木を切る. 各々のカッターは 1 日に 1 回, 1 つの木に対してのみ使うことが出来る.

カッターを上手く使って, time 日目の終わり時点（カッターを使った後）での木の高さの和を最小にしたい. その時の和を求めよ.

- N, M, time <= 150
- height[n], add[n], device[m] <= 10000

# 方針

1 つの木を 2 回以上切っても無意味なので, 1 つの木を切るのは 0 回または 1 回である. また, add が大きい木は出来るだけ遅い日に切った方が良い.

add が大きい木を優先的に切るために, 木を add の降順でソートする.

dp(t, i, j) を「（t+1 日目以降で最適な切り方をした時の）t 日目に, i 番目までの木に対して, j 番目までのカッターをうまく使った時の, i 番目までの木の総長」とすると, 次の漸化式が得られる.

- dp(t, i, -1) = dp(t+1, i, M-1)
    - カッターを使わない場合は, t+1 日目以降の最適値と一致する
- dp(t, i, j) = 以下の最小値
    - dp(t, i-1, j) + height[i] + time * add[i]
    - dp(t, i-1, j-1) + device[i] + (time-t) * add[i]
    - dp(t, i, j-1)

上の漸化式をメモ化再帰で実装する.

# 解答

```cpp
using P = pair<int, int>;
const int INF = 1<<29;

class TaroCutting
{
public:
    int N, M;
    vector<P> tree;
    vector<int> device;
    int time;

    int getNumber (vector <int> height, vector <int> add, vector <int> device, int time)
    {
        N = height.size();
        M = device.size();
        this->device = device;
        this->time = time;
        loop (N, i) tree.emplace_back(add[i], height[i]);
        sort(tree.begin(), tree.end(), greater<P>());
        fill(memo[0][0], memo[0][0]+160*160*160, -1);

        return rec(1, N-1, M-1);
    }

    int memo[160][160][160];
    int rec (int t, int i, int j) {
        if (t > time) return INF;
        if (i < 0) return 0;
        if (j < 0) return rec(t+1, i, M-1);

        if (memo[t][i][j] != -1) return memo[t][i][j];

        int ans = rec(t, i-1, j) + time * tree[i].first + tree[i].second;
        ans = min(ans, rec(t, i-1, j-1) + device[j] + (time-t) * tree[i].first);
        ans = min(ans, rec(t, i, j-1));

        return memo[t][i][j] = ans;
    }
};
```

# 考察

本番で漸化式作って証明までするのは不可能だと思う. おとなしく最小費用流で書くべき((https://tatsyblog.wordpress.com/2014/12/18/topcoder-srm-642-div1/))な気がする.
