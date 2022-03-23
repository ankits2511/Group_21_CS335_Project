//Insertion sort
#include<iostream>
#include<cmath>
using namespace std;


int main(){
  int n;
  cin >> n;
  int A[n];
  for(int i=0;i<n;i++){
    cin >> A[i];
  }
  for(int i=0;i<n;i++){
    //storing current element whose left side is checked for its correct position.
    int temp = A[i];
    int j = i;
    //check whether the adjacent element in left side is greater or less than the current element.
    while(  j > 0  && temp < A[ j -1]) {
      // moving the left side element to one position forward.
      A[ j ] = A[ j-1];   
      j= j - 1;
    }
    // moving current element to its  correct position.
    A[ j ] = temp;       
  }
  cout << "Sorted Array :";
  for(int i=0;i<n;i++){
    cout << " " << A[i];
  }
  cout << endl;// cout << "\n";
  return 0;
  /* Multiline 
    comment
    */
}