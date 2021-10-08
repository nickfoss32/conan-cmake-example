#include <iostream>
#include <fmt/core.h>

int main()
{
    // std::string s = fmt::format("{:d}", "I am not a number");
    std::string s = fmt::format("The answer is {}.", 42);
    fmt::print(s);
    return 0;
}