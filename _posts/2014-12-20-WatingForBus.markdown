---
layout: commentary
date: 2014-12-20
type: commentary
contest: Topcoder SRM
competition: 642 Div1
problem_type: Easy
problem_name: WatingForBus
---

DP の練習に良い問題だとおもった

# 問題

[http://community.topcoder.com/stat?c=problem_statement&pm=13540&rd=16085]

同じ停留所に発着するバスが N (< 100) 台あり, 0 から N-1 までの番号が割り当てられている. i 番目のバスが発車してから戻ってくるまでに, time[i] (< 10^5) の時間がかかる. 時刻 0 に, N 台のうちランダムに選ばれた 1 台が発車する. バスが戻ってくると同時に, また N 台のうちランダムに選ばれた 1 台が発車する. これを繰り返す. 同じバスが続けて選ばれることもある. i 番目のバスが選ばれる確率は prob[i] / 100 で与えられる.

あなたは 時刻 s に停留所に到着した. 次のバスが発車するまでの待ち時間の期待値を出力せよ.

# 方針

1. 時刻 0 から s のそれぞれでバスが発（着）車する確率 P を DP で求める  
    ある時刻 i について, P[i] = Σ[j = 0..N-1] P[i-time[j]] * prob[j] / 100
2. 上で求めた確率を使って, 「時刻 s から s+i-1 の間にバスが発（着）車せず、時刻 s+i にバスが発（着）車する確率」P' を求める
3. Σ P' * i が求める期待値

# 解答

```cpp
const int M = 200010;

class WaitingForBus
{
public:
    double whenWillBusArrive (vector <int> time, vector <int> prob, int s)
    {
        int N = time.size();
        vector<double> P(M, 0);
        P[0] = 1;
        loop (M-1, i) {
            loop (N, j) {
                if (i+1 >= time[j]) P[i+1] += P[i+1-time[j]] * prob[j] / 100;
            }
        }
        double ans = 0;
        loop (100001, i) {
            loop (N, j) {
                if (i < time[j] && s+i >= time[j]) ans += i * P[s+i-time[j]] * prob[j] / 100;
            }
        }
        return ans;
    }
};
```
