---
layout: commentary
date:   2014-12-30 03:02:05
type: commentary
contest: Topcoder SRM
competition: 643 Div1
problem_type: Med
problem_name: TheKingsArmyDiv1
---

コーナーケースに気をつけて慎重に戦略を考える問題（もしくはDP解法）. 本番では題意を微妙に取り違えていて, なぜか pretest 通ってしまい, 呆気無く撃墜された.

# 問題

http://community.topcoder.com/stat?c=problem_statement&pm=13526&rd=16086

2N 人の兵士が 2 行 N 列に並んでいる. 各兵士は Happy/Sad のどちらかの状態を持っている. 兵士 X が兵士 Y に話しかけると, 兵士 Y の状態が兵士 X と同じになる. あなたは次の命令ができる.

1. 一人の兵士を選び, 隣（上下左右）の誰かに話しかけさせる.
2. ある行の隣り合う 2 人以上の兵士を選び, 同列他行の兵士に話しかけさせる.
3. ある列の兵士（2人）を選び, 隣の列の兵士に話しかけさせる.

全員を Happy にするための最小命令回数を求めよ. 不可能な場合は -1 を出力する.

# 方針

基本的に 2. の命令が最も効率的なので, 2. を使う戦略を考える. 

## 上下の状態が全て異なる場合

```
HHSSHHSSHH
SSHHSSHHSS
```

上記の場合, 次の 3 命令で全員 Happy にできる.

- 1 行 2~3 列の兵士に 2. を命令
- 1 行 6~7 列の兵士に 2. を命令
- 0 行 0~9 列の兵士に 2. を命令

よって, 横に状態が等しい隣接ブロックの数を B とすると, 命令回数は B/2 + 1 回となる.

## 上下どちらも Happy のペアがいる場合

```
HHH
SHS
```

上記の場合, 0 行 0~2 列の兵士に 2. を命令すれば良い. すなわち, 上下 Happy のペアを無視して, 前述の上下が全て異なる場合と同じ計算を適用できる.

## 上下どちらも Sad のペアがいる場合

```
HSH
SSS
```

この場合もまず, 0 行 0~2 列の兵士に 2. を命令する. 次に, 0 列の兵士に右隣に話しかけさせれば良い（命令 3）. すなわち, 上下 Sad のペアを無視して, 最後に命令 3. を上下 Sad の個数だけ行う.

## まとめ

次の計算で最小命令数が計算できる

1. 上下どちらも Happy なペアを除外する.
2. 上下どちらも Sad なペアを除外し, その数だけ ans++ する.
3. 隣接ブロックの数 B を計算し, ans += B/2 + 1 とする.

あとは, 全員 Sad の場合と, 上下が全て等しい場合だけ分岐すれば OK.

# 解答

```cpp
class TheKingsArmyDiv1
{
public:
    int getNumber (vector <string> state)
    {
        int N = state[0].length();

        if (state[0] == string(N, 'S') && state[1] == string(N, 'S')) return -1;

        int ans = 0;
        string different;
        for (int i = 0; i < N; i++) {
            if (state[0][i] != state[1][i]) {
                different.push_back(state[0][i]);
            }
            else if (state[0][i] == 'S') ans++;
        }
        int M = different.length();

        if (M == 0) return ans;

        int blocks = 1;
        for (int i = 0; i < M-1; i++) if (different[i] != different[i+1]) blocks++;

        return ans + blocks/2 + 1;
    }
};
```

# (おまけ) 区間 DP 解法

区間 [l, r) について, 配列 dp(l, r, k) を次のように持つ.

- 0 行目を全て H にする手数 (k = 0)
- 1 行目を全て H にする手数 (k = 1)
- 全て H にする手数 (k = 2)

幅 (r-l) を 1 から N まで更新しながら, dp を埋めていく.

```cpp
class TheKingsArmyDiv1
{
public:
    int getNumber (vector <string> state)
    {
        int N = state[0].length();
        int dp[201][201][3];
        fill(dp[0][0], dp[200][200]+3, INF);

        // 幅 1 の初期値
        for (int i = 0; i < N; i++) {
            if (state[0][i] == 'H') dp[i][i+1][0] = 0; // HS or HH
            if (state[1][i] == 'H') dp[i][i+1][1] = 0; // SH or HH
            if (state[0][i] == 'H' && state[1][i] == 'H') dp[i][i+1][2] = 0; // HH
        }

        for (int w = 1; w <= N; w++) {
            for (int l = 0; l+w <= N; l++) {
                for (int k = l+1; k <= l+w; k++) {
                    int r = l+w;
                    // 区間[l,r)
                    // HS or HH にするコスト
                    dp[l][r][0] = min({
                            dp[l][r][0],
                            dp[l][k][0] + dp[k][r][0],
                            dp[l][k][0] + r-k,
                            k-l + dp[k][r][0]});
                    // SH or HH にするコスト
                    dp[l][r][1] = min({
                            dp[l][r][1],
                            dp[l][k][1] + dp[k][r][1],
                            dp[l][k][1] + r-k,
                            k-l + dp[k][r][1]});
                    // HH にするコスト
                    dp[l][r][2] = min({
                            dp[l][r][2],
                            dp[l][k][2] + dp[k][r][2],
                            min(dp[l][r][0], dp[l][r][1]) + 1,
                            dp[l][k][2] + r-k,
                            k-l + dp[k][r][2]});
                    dp[l][r][0] = min(dp[l][r][0], dp[l][r][2]);
                    dp[l][r][1] = min(dp[l][r][1], dp[l][r][2]);
                }
            }
        }

        return dp[0][N][2] >= INF ? -1 : dp[0][N][2];
    }
};
```
