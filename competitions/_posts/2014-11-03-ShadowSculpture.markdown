---
layout: competition
date: 2014-11-03
contest: Topcoder SRM
competition: '638'
problem_type: Div1 Easy
problem_name: ShadowSculpture
---

# 問題

[http://community.topcoder.com/stat?c=problem_statement&pm=13355&rd=16081]

N\*N\*N (N <= 10) の空間に 1\*1\*1 のキューブをいくつか配置する. XY・YZ・ZX平面の投影図がそれぞれ与えられる. 配置したキューブは全て隣接し得るかどうか答えよ.

# 方針

座標 (i, j, k) にキューブが存在し得る条件: XY[i][j] && YZ[j][k] && ZX[k][i]

- 各座標について,
    - DFSで存在し得る隣接キューブにマークを付ける
    - マークがついたキューブから 3 平面の投影図を作り, 入力と一致するかどうかチェックする

# 解答
```cpp
#include <iostream>
#include <vector>
#include <algorithm>
 
#define loop(n, i) for(int i=0;i<n;i++)
#define from_to(from, to, i) for(int i=from;i<=to;i++)
 
using namespace std;
 
class ShadowSculpture
{
public:
    string possible (vector <string> XY, vector <string> YZ, vector <string> ZX)
    {
        this->XY = XY;
        this->YZ = YZ;
        this->ZX = ZX;
        N = XY.size();
        loop (N, i) loop (N, j) loop (N, k) {
            if (XY[i][j] == 'Y' && YZ[j][k] == 'Y' && ZX[k][i] == 'Y') {
                A[i][j][k] = 1;
            }
        }
 
        loop (N, i) loop (N, j) loop (N, k) used[i][j][k] = 0;
 
        loop (N, i) loop (N, j) loop (N, k) {
            loop (N, i) loop (N, j) loop (N, k) visited[i][j][k] = 0;
            dfs(i, j, k);
            if (check()) return "Possible";
        }
        return "Impossible";
    }
 
    vector<string> XY, YZ, ZX;
    int N;
    int A[10][10][10] = {};
    int used[10][10][10];
    int visited[10][10][10];
 
    void dfs(int i, int j, int k) {
        if (used[i][j][k] || !A[i][j][k]) return;
        used[i][j][k] = visited[i][j][k] = 1;
        if (i-1 >= 0) dfs(i-1, j, k);
        if (i+1 < N)  dfs(i+1, j, k);
        if (j-1 >= 0) dfs(i, j-1, k);
        if (j+1 < N)  dfs(i, j+1, k);
        if (k-1 >= 0) dfs(i, j, k-1);
        if (k+1 < N)  dfs(i, j, k+1);
    }
 
    bool check() {
        int xy[10][10] = {}, yz[10][10] = {}, zx[10][10] = {};
        loop (N, i) loop (N, j) loop (N, k) {
            if (visited[i][j][k]) {
                xy[i][j] = yz[j][k] = zx[k][i] = 1;
            }
        }
        loop (N, i) loop (N, j) {
            if (XY[i][j] == 'Y' && !xy[i][j]) return false;
            if (YZ[i][j] == 'Y' && !yz[i][j]) return false;
            if (ZX[i][j] == 'Y' && !zx[i][j]) return false;
        }
        return true;
    }
};
```
