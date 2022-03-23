#include<iostream>
#include<cmath>
using namespace std;

bool isprime(int x){
  int sq=sqrt(x),i;
  if(x==2){
    return true;
  }
  if(x%2==0){
    return false;
  }
  for(i=3;i<=sq;i+=2){
    if(x%i==0){
      return false;
    }
  }
  return true;
}

int main(){
  int n;
  cin >> n;
  if(isprime(n)==true){
    cout << n << " is Prime\n";
  }
  else cout << n << " is not Prime" << endl;
  return 0;
}