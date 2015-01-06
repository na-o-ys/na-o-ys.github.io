---
layout: competition
date: 2015-01-05
contest: New Year Contest 2015
problem_type: C
problem_name: 文字列の置き換え
---

変な問題

# 問題

<http://nyc2015.contest.atcoder.jp/tasks/nyc2015_3>

# 方針

先頭から続く文字だけは挿入できない.

snuke -> snnnnnuke は作れるけど, snuke -> sssnuke は作れない.

よって先頭だけ分けて考える.

# 解答

```cpp
int solve(string s, string t)
{
    int i = 0;
    for (; i < t.length() && t[i] == t[0]; i++) {
        if (i >= s.length() || s[i] != t[i]) return 0;
    }
    int j = i;
    for (; i < s.length(); i++, j++) {
        while (j < t.length() && s[i] != t[j]) j++;
        if (j >= t.length()) return 0;
    }
    return 1;
}
 
int main()
{
    string s, t; cin >> s >> t;
    cout << (solve(s, t) ? "Yes" : "No") << endl;
    return 0;
}
```
