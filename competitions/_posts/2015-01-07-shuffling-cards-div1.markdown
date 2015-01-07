---
layout: competition
date: 2015-01-07
contest: Topcoder SRM
competition: '641'
problem_type: Div1 Med
problem_name: ShufflingCardsDiv1
---

Div1Med を初めて自力で解いた. 逆にしたり傾けたり云々...することで急に簡単になるタイプの問題.

# 問題

<http://community.topcoder.com/stat?c=problem_statement&pm=13541&rd=16084>

1 から 2N までの数字が書かれた 2N 枚のカードがある. 1 回のシャッフルは次の順序で行われる.

1. 上から N 枚目までを山 A, 残りを山 B とする
2. A, B 内で自由に並び替える 
3. A, B から交互に 1 枚ずつ取り出してまとめる
    A[0], B[0], A[1], B[1], ...

順序 perm が与えられる. 初期状態ではカードは昇順に並んでいる. シャッフルを繰り返して, 順序 perm に並び替えたい. 最小シャッフル回数を求めよ. 並び替えできない場合は -1 を出力せよ

# 方針

逆で考えると楽. 順序 perm から, シャッフルを繰り返して昇順に並べる. 

シャッフルの逆操作は, M = N/2 (繰り上げ) として, 上半分の任意の M 枚と下半分の任意の M 枚を交換する操作と等価である.

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
