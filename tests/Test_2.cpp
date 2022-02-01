#include<iostream>
#include<cmath>
using namespace std;
#define ll long long 
const int Z=1e6+5;
ll mod=1e9+7;
ll fac[Z];

struct testing{
  int a;
  long b;
  char c;
};

void factorial(){
    fac[0] = 1;
    for (ll i = 1; i < Z; i++)fac[i] = (fac[i - 1]%mod * (i%mod)) % mod;
}

int main(){
  int N;
  cin >> N;
  factorial();
  cout << fac[N] << endl;
  return 0;
}
