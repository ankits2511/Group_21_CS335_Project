int f(int n)
{
  if(n==0)
    return 0;
  f(n-1);
}
void main() 
{ 
   char a = 'b';
   int *d = 34;
   int n = 4;
   int b = a+n;
   int x = f(n);
   int i;
   double c = 0.5;
   for(i=0; i<n;i++)
   {
     n=n-1;
   }
}