#include <fplus/fplus.hpp>
#include <iostream>
#include <string>
#include <stdint.h>
#include <stdio.h>
#include <stddef.h>

extern "C" int LLVMFuzzerTestOneInput(const uint8_t* data, size_t size)
{
    std::string buf(reinterpret_cast<const char*>(data), size);
    buf.push_back('\0');
    std::list<std::string> things = {buf, buf};
    if (fplus::all_the_same(things))
        std::cout << "All things being equal." << std::endl;
    return 0;
}
