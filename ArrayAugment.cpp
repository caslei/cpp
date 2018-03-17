#include<iostream>
#include<vector>
#include <cstring>
#include<string>
#include<algorithm>

using namespace std;

int SUM(std::vector<int> a)
{
	// int num = sizeof(a)/sizeof(a[0]);
	int sum=0;
	for(int i=0; i<a.size();i++){
		sum +=a[i];
		printf("%d\n", a[i]);
	}
	return sum;
}

int main()
{
	std::vector<int> a={1,2,3,4,5};
	int sum = SUM(a);
	printf("%d\n", sum);


	string path1="c:\\Users\\wlei\\Desktop\\test.jpg";
	string path2="c:/Users/wlei/Desktop/test.jpg";

	// string fileName1 = strrchr(path1.c_str(), '\\');
	// string fileName2 = strrchr(path2.c_str(), '/');
	// cout<<fileName1<<"\n"<<fileName2<<"\n";
	// //there is no 'std::string' type for c language so 'string' must be converted to c stlye
	// printf("%s, %s\n", fileName1.c_str(), fileName2.c_str()); 

	replace(path1.begin(), path1.end(), '\\', '/');
	string path3 = path1;
	printf("%s\n", path3.c_str()); 

	// path3= "c:\\Users\\wlei\\Desktop\\test3.jpg";
	// std::ifstream ifile=path3;
	// cout<<ifile.good()<<"\n";

	int num=8;
	cout<<num/2<<"\n"<<num%2<<"\n";	

	// string tmp = std::remove(fileName1.begin(), fileName1.end(), "\\"); printf("%s\n", tmp.c_str());

	// fileName1.erase(tmp, fileName1.end()); printf("%s\n", fileName1.c_str()); //remove "\" from "\model.py"
	// fileName1 = fileName1.erase(fileName1.length() - 3); printf("%s\n", fileName1.c_str());          //remove ".py" from "model.py"

	return 0;
}