int binarySearch(int arr[], int n, int Target){
    int s = 0, e = n-1;

    //int found = 0;

    while (s <= e)
    {
        int mid = s + (e-s)/2;
        if(arr[mid] == Target){
            return mid+1;
        }
        else if(arr[mid] < Target){
            s = mid + 1;
        }
        else{
            e = mid - 1;
        }
    }
    return -1;
}

int main(){
    int arr[] = {9, 10, 11, 77,100};
    int T = 12;
    int r = binarySearch(arr, 5, T);
}