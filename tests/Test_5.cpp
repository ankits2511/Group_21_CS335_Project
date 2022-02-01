// Program for Nth Fibonacci Number
#include<iostream>
#include<cmath>
using namespace std;

int Fibonacci(int n){
  int f[n + 2];
  // 0th and 1st number of the series are 0 and 1
  f[0] = 0;
  f[1] = 1;
  for(int i = 2; i <= n; i++){
    f[i] = f[i - 1] + f[i - 2];
  }
  return f[n];
}

int main (){
  int T;
  cin >> T;
  while(T--){
    int n;
    cin >> n;

    cout << n << "th Fibonacci number is : " << Fibonacci(n) << endl;
  }
  return 0;
}