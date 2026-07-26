#pragma once

#include <filesystem>

class Solution {
    std::filesystem::path input_dir, output_dir;

public:
    virtual void answer();
};