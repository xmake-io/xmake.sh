#include <iostream>
#include "../foo/foo.h"

using namespace std;

int main(int argc, char** argv) {
    cout << "HELLO_REPLACE" << endl;
    cout << "VERSION_REPLACE" << endl;
    cout << "add(1, 2) = " << add(1, 2) << endl;
    return 0;
}
