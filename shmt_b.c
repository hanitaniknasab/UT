#include "types.h"
#include "stat.h"
#include "user.h"

#define ITERATIONS 1000

int
main() {

    int *shared_counter = (int*) open_shared_mem(1);
    if ((int)shared_counter == -1) {
        printf(1, "open_shared_mem failed\n");
        exit();
    }

    *shared_counter = 0;  

    int pid1 = fork();
    if (pid1 == 0) {
     
        for (int i = 0; i < ITERATIONS; i++) {
            *shared_counter = *shared_counter + 1;
        }
        exit();
    }

    int pid2 = fork();
    if (pid2 == 0) {

        for (int i = 0; i < ITERATIONS; i++) {
            *shared_counter = *shared_counter + 1;
        }
        exit();
    }

    wait();
    wait();

    printf(1, "Final value of shared_counter: %d\n", *shared_counter);

    close_shared_mem(1);
    exit();
}
