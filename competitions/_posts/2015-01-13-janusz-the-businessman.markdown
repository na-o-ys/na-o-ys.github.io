---
layout: competition
date: 2015-01-13
contest: Topcoder SRM
competition: '645'
problem_type: Div1 Easy
problem_name: JanuszTheBusinessman
---

DP とかグラフ理論が見える気がするが, どちらもツラめ. 見た目以上に難しいと思う.

# 問題

<http://community.topcoder.com/stat?c=problem_statement&pm=13603&rd=16277&rm=324763&cr=22716052>

あるホテルに宿泊する N (<= 50) 人の旅行者がいる. i 番目の旅行者の到着日, 出発日は arrv[i], dept[i] in { 1, ..., 365 } で与えられる.

i 番目の旅行者に special promotion すると, 全旅行者のうち i 番目と宿泊日が重なっている者 (i 番目を含む) が good review してくれる.

全ての旅行者に good review してもらうためには, 少なくとも何人に special promotion すれば良いか.

# 方針

最も出発日が早い旅行者 i について考える. i と宿泊日が重なっている者のうち, 少なくとも一人を選んで special promotion する必要がある. このうち最も出発日が遅い者 j を選ぶと, 到着日 (arrv) が dept[j] 以前の者は全て good review してくれる.

今度は到着日が dept[j] より後の者のうち, 最も出発日が早い旅行者について考える. 以下同様にこれを繰り返せば良い.

# 解答

```cpp
#define loop(n, i) for(int i=0;i<n;i++)

using namespace std;
const int INF = 1<<20;

class JanuszTheBusinessman
{
public:
    int makeGuestsReturn (vector <int> arrv, vector <int> dept)
    {
        int N = arrv.size();
        int ans = 0;

        int cur = 0;
        while (1) {
            // cur 以下が整理できている状態
            int fastDept = INF;
            loop (N, i) if (arrv[i] > cur) fastDept = min(fastDept, dept[i]);
            if (fastDept == INF) break;

            loop (N, i) if (arrv[i] <= fastDept) cur = max(cur, dept[i]);
            ans++;
        }

        return ans;
    }
};
```

# 感想

本番は寝過ごしたけど, Practice で汚い DP で 2 時間かけて解いた.
