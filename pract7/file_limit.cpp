#include <iostream>
#include <fstream>
#include <vector>
#include <thread>
#include <chrono>
#include <string>

using namespace std;

int main() {
    vector<std::ofstream> files;
    int create_files = 1000;
    int total_amount = 100000;

    for (int i = 0; i < total_amount; i += create_files) {
        for (int j = 0; j < create_files; ++j) {
            string filename = "testf_" + to_string(i + j) + ".txt";
            files.emplace_back(filename);
            if (!files.back().is_open()) {
                cerr << "Reached file-descriptor limit at " << (i + j) << "  num of files\n";
                break;
                return 1;
            }
        }

        cout << "Opened " << i + create_files << " files\n";
        this_thread::sleep_for(chrono::seconds(1));
    }

    cout << "Press Enter to close\n";
    cin.get();
    
    return 0;
}
