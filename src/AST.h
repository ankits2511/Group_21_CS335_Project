#include <bits/stdc++.h>
using namespace std;


typedef struct{
	long unsigned int node_id;
	long long int size;
	string node_name;
	string type;
	int expType;	// 1 -> Variable, 2 -> Array, 3-> Function, 4 -> Constant, 5 -> string  			 	
	int isInit;
	long long int intVal;
	long double realVal;
	string strVal;

	string temp_name;
}treeNode;


typedef struct{
	string str;
	string type;
	long long int intVal;
	long double realVal;
	string strVal;
}constants;


typedef struct{
	treeNode* node;
	string str;
	bool is_node;
}data; 


   

void startDOT();
void endDOT();

vector<data> makeAttrVec();
void pushAttr(vector<data>&, treeNode* , string , int );
treeNode *makeleaf(string);
treeNode *makenode(string , vector<data>&);
