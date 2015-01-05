---
layout: competition
date: 2015-01-05
contest: New Year Contest 2015
problem_type: B
problem_name: 鏡餅
---

「わからんかったらとりあえずソート」

# 問題

http://nyc2015.contest.atcoder.jp/tasks/nyc2015_2

# 方針

一番上にくる餅は, 一番軽い餅が良い. 二番目の餅は, 一番目より重い中で最も軽い餅が良い. 三番目の餅は, 一番目と二番目の合計より重い中で最も軽い餅が良い. 以下同様.

# 解答

```cpp
#define loop(n, i) for(int i=0;i<n;i++)
#define all(vec) vec.begin(),vec.end()
 
using namespace std;
using ll = long long;
 
int main(int argc, char const* argv[])
{
    int N; cin >> N;
    vector<ll> a(N);
    loop (N, i) cin >> a[i];
    sort(all(a));
    int ans = 0;
    ll w = 0;
    for (ll v : a) {
        if (v <= w) continue;
        w += v;
        ans++;
    }
    cout << ans << endl;
 
    return 0;
}
```
