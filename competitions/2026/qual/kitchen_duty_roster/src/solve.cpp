#include <iostream>

#include "Problem.hpp"

using namespace util;

class Problem_kitchen_duty_roster : public Problem {
public:
    using Problem::Problem;

    void solve() const override {

    }
};

int main(int argc, char** argv) {
    fs::path problem_input_dir;


    // change to validating function
    if (!fs::exists(problem_input_dir)) {
        std::cerr << "ERROR: directory doesn't exist!\n";
        return 1;
    } else if (!fs::is_directory(problem_input_dir)) {
        std::cerr << "ERROR: given path doesn't point to a directory!\n";
        return 2;
    } else if (fs::is_empty(problem_input_dir)) {
        std::cerr << "ERROR: directory is empty!\n";
        return 3;
    }
    
    for (const auto& filepath : fs::directory_iterator(problem_input_dir)) {
        Problem_kitchen_duty_roster p{filepath.path()};
        p.solve();
    }

    return 0;
}
