#pragma once

#include <filesystem>
#include <fstream>

namespace util {

namespace fs = std::filesystem;

class Problem {
public:
    Problem() = delete;
    Problem(const fs::path& problem_input_path);
    virtual ~Problem();
    virtual void solve() const = 0;
protected:
    std::ifstream input_file;
    std::ofstream output_file;
};

} // namespace util