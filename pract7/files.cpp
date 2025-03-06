#include <iostream>
#include <fstream>
#include <vector>
#include <string>

using namespace std;

int main() {
    std::vector<std::ofstream> files;
    int max_files = 10;

    for (int i = 0; i < max_files; ++i) {
        std::string filename = "filenum_" + std::to_string(i) + ".txt";
        files.emplace_back(filename);
        
        if (!files.back().is_open()) {
            std::cerr << "Could not open file " << filename << ".\n";
            break;
        }
        std::cout << "Opened file: " << filename << std::endl;
    }

    std::cout << "Press Enter to close files \n";
    std::cin.get();  // files will be still open to check

    return 0;
}
