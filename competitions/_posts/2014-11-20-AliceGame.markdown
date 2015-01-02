---
layout: commentary
date: 2014-11-30
type: commentary
contest: Topcoder SRM
competition: 639 Div1
problem_type: Easy
problem_name: AliceGame
---

# 問題

[http://community.topcoder.com/stat?c=problem_statement&pm=13490&rd=16082]

Alice, Kirito 2人がゲームをする. ゲームはターン1から始まり有限ターンからなる. 各ターンでそれぞれ勝者が決まり, i ターン目で勝利すると2*i-1ポイントもらえる. 
long long int x, y が与えられる. ゲーム終了時に Alice が x ポイント, Kirito が y ポイントとなるようなパターンは存在するか. 存在するならば Alice が勝利する必要がある最小ターン数を出力せよ. 存在しないならば -1 を出力せよ.

0 <= x, y <= 10^12

# 方針

ターン数 T は √(x+y) で得られる.

計 i ターンの勝利で x ポイント稼げる必要十分条件:

- x が 1 以上 2*T-1 以下の相異なる i 個の奇数の和で表せる
- ⇔ (x+i)/2 が 1 以上 T 以下の相異なる i 個の整数の和で表せる

この条件を満たすかどうかを i = 1 .. T で確かめれば良い.

# 解答
```cpp
class AliceGame
{
public:
    long long findMinimumValue(long long x, long long y) {
        ll turns = sqrt(x+y)+0.01;
        if (turns*turns != x+y) return -1;

        for (ll i = 0; i <= turns; i++) {
            ll min = i*(i+1)/2, max = (2*turns-i+1)*i/2;
            if ((x+i) % 2 == 0 && (x+i)/2 >= min && (x+i)/2 <= max) return i;
        }
        return -1;
    }
};
```

# 雑感

大きい奇数から順に足していく方法だと, 2 が残る場合のコーナーケースがあり, ここで大勢落ちていたっぽい. 2 が残る場合だけ除外するとそれでも通るが, 証明がわからない.
