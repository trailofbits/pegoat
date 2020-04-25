#include <iostream>

int buffer_overflow(void) {
    char buf[10];
    scanf("%s", buf);
    return 1;
}

int main(int argc, char *argv[], char *envp[]) {
    std::cout << "baa!" << std::endl;
    return buffer_overflow();
}
