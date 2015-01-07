---
layout: competition
date: 2015-01-07
contest: Topcoder SRM
competition: '641'
problem_type: Div1 Med
problem_name: ShufflingCardsDiv1
---

Div1Med が初めて解けた. 逆にしたり傾けたりと, 条件を変形することで急に簡単になるタイプの問題.

# 問題

<http://community.topcoder.com/stat?c=problem_statement&pm=13541&rd=16084>

1 から 2N までの数字が書かれた 2N 枚のカードがある. 1 回のシャッフルは次の順序で行われる.

1. 上から N 枚目までを山 A, 残りを山 B とする
2. A, B 内で自由に並び替える 
3. A, B から交互に 1 枚ずつ取り出してまとめる
    A[0], B[0], A[1], B[1], ...

順序 perm が与えられる. 初期状態ではカードは昇順に並んでいる. シャッフルを繰り返して, カードの並びを perm と一致させたい. 最小シャッフル回数を求めよ. 並び替えできない場合は -1 を出力せよ

# 方針

逆で考えると楽. perm の順序で並んだカードについて, シャッフルを繰り返して昇順に並べる. シャッフルの逆操作は, 次と等価である.

- (最初のみ) 奇数番目を取り出して上半分に, 偶数番目を下半分に移動する
- (2回目以降) 上半分の任意の N/2 枚と, 下半分の任意の N/2 枚を交換する

最初に奇数番目, 偶数番目で分けて, 偶数番目に 1~N のカードが何枚あるか数えれば, シャッフル回数はすぐ求まる.

# 解答

```cpp
#define loop(n, i) for(int i=0;i<n;i++)

using namespace std;
using ll = long long;

class ShufflingCardsDiv1
{
public:
    int shuffle(vector <int> perm)
    {
        int N = perm.size() / 2;
        loop (2*N, i) {
            if (perm[i] != i+1) break;
            if (i == (2*N-1)) return 0;
        }
        vector<int> V(2*N);
        loop (N, i) V[i] = perm[2*i];
        loop (N, i) V[i+N] = perm[2*i+1];
        int cnt = 0;
        loop (N, i) if (V[N+i] <= N) cnt++;
        int ans = 1;
        if (cnt > 0 && cnt < N/2) ans += 2;
        else ans += ((cnt + (N/2) - 1) / (N/2));
        return ans;
    }
};
```
