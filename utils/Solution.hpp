#pragma once

#include <filesystem>

class Solution {
protected:
    std::filesystem::path input_dir, output_dir;
    
public:
    virtual void answer() = 0;
};