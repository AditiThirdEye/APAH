#include<bits/stdc++.h>
#include <chrono>
#include <thread>
using namespace std;

int main(){
	std::chrono::duration<int, std::milli> timespan(1000);

	for(int i=0; i<100000; i++){
		cout<<i<<" ";
		cout.flush();
		std::this_thread::sleep_for(timespan);
	}
	return 0;
}
