#include "Problem.hpp"

using namespace util;

Problem::Problem(const fs::path& problem_input_path) : input_file(problem_input_path) {
    output_file.open(problem_input_path.parent_path() / "output" / problem_input_path.stem().concat(".out"), std::ios::out | std::ios::trunc);
}

Problem::~Problem() {
    input_file.close();
    output_file.close();
}
