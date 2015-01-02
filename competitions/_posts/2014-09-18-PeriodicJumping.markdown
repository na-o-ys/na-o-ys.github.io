---
layout: commentary
date: 2014-09-18
type: commentary
contest: Topcoder SRM
competition: 633 Div1
problem_type: Easy
problem_name: PeriodicJumping
---

# 問題
[http://community.topcoder.com/stat?c=problem_statement&pm=13234&rd=16076]

int x, vector<int\> jumpLengths が与えられる.  
二次元平面上の原点 (0, 0) からスタートして, 点 (x, 0) に到達したい.  
平面上を jumpLengths で与えられた距離だけ順に移動する. (jumpLengths = {2, 5} の場合は, 距離 2, 5, 2, 5, .... ずつ移動する. )  
最短何回の移動で到達できるか.

- -10^9 <= x <= 10^9
- jumpLength contains 1 between 50 elements.
- a ∈ jumpLength について, -10^9 <= a <= 10^9

# 方針
多角形の成立条件: 最大辺の長さ <= その他の辺の合計長  
を使う.  
n 回の移動で辺 (0, 0) to (x, 0) を含む多角形を構成できるかどうかを確かめる.

N = len(jumpLength), S = sum(jumpLength) とする.

1. x == 0 の場合
    - 解は 0
2. x > S の場合
    - 最大辺の長さは x
    - 移動距離の合計が初めて x を超えた時の移動回数を求めれば良い
3. x <= S の場合
    - 最大辺の長さは max(x, max(jumpLength))
    - 少なくとも 2N 回の移動で多角形を構成できる.
    - n = 1, ..., 2N について, n 回の移動で多角形を構成できるかどうか確かめれば良い.

# 解答
```cpp
class PeriodicJumping
{
public:
    int minimalTime(int x, vector <int> jumpLengths)
    {
        x = abs(x);
        int N = jumpLengths.size();
        ll S = 0;
        for (int l : jumpLengths) S += l;
        if (x == 0) return 0;
        if (x <= S) {
            loop (N*2, i) {
                ll m = 0, len = 0;
                loop (i+1, j) m = max(m, (ll)jumpLengths[j%N]);
                m = max(m, (ll)x);
                loop (i+1, j) len += jumpLengths[j%N];
                len += x;
                if (m <= len/2) return i + 1;
            }
        }
        if (x > S) {
            int ans = N * (x/S);
            x %= S;
            for (int l : jumpLengths) {
                if (x <= 0) break;
                ans++;
                x -= l;
            }
            return ans;
        }
        return -1; // dummy
    }
};
```

# 感想
本番では, 愚直に移動回数毎の移動可能範囲を求めて解いた. 2N 回の移動で半径 2S の範囲をカバーできることに気付くまでに時間がかかった. 凡ミスで failed systest.

まともな幾何の問題は初めてだった. 素振りが足りない.
