#include <iostream>
#include <fstream>
#include <thread>
#include <chrono>

using namespace std;

int main() {
    ofstream file("test.txt", ios::app);
    if (!file.is_open()) {
        cerr << "Could not open file\n";
        return 1;
    }

    for (int i = 1; i <= 1000; ++i) {
        file << i << " line" << endl;
        file.flush();
        this_thread::sleep_for(chrono::seconds(1));
    }

    file.close();
    return 0;
}