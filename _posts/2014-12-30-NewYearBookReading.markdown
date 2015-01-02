---
layout: commentary
date: 2014-12-30
type: commentary
contest: Codeforces
competition: Good Bye 2014
problem_type: C
problem_name: New Year Book Reading
---

# 問題

[http://codeforces.com/contest/500/problem/C]

本が N (< 500) 冊ある. それぞれの本には重さがある. 本は全て重ねて積んだ状態である. 上から I 番目の本を読む場合には, I 番目の本を取り出して山の一番上に移動させる. この時, あなたには 1~I-1 番目の本の重量分の負荷がかかる.

M (< 1000) 日間, 1 日 1 冊の本を読みたい. I 日目に読む本は b[i] で与えられる. 同じ本を複数の日に読む場合もある. M 日間の負荷の最小値を求めよ.

# 方針

読み終わった本を上に重ねるので, 新しい本 B を読む場合の負荷は「B より前に読んだ本の重さ + B の上にある未読本の重さ」となる. 本を初めて読む順番で積んでおけば, 後者がゼロになる.

# 解答

```cpp
int main(int argc, char const* argv[])
{
    int n, m; cin >> n >> m;
    vector<int> weight(n), b(m);
    loop (n, i) cin >> weight[i];
    loop (m, i) { cin >> b[i]; b[i]--; }

    vector<int> order;
    loop (m, i) if (find(all(order), b[i]) == order.end()) {
        order.push_back(b[i]);
    }

    int ans = 0;
    loop (m, i) {
        int j = 0;
        while (order[j] != b[i]) {
            ans += weight[order[j]];
            j++;
        }
        order.erase(order.begin()+j);
        order.insert(order.begin(), b[i]);
    }

    cout << ans << endl;
    return 0;
}
```
