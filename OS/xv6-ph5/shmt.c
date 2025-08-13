#include "types.h"
#include "stat.h"
#include "user.h"

#define SIZE 6
#define ITERATIONS 1000

int
main() {
    int init_array[SIZE] = {1, 1, 1, 1, 1, 1};


    if (monitor_init(1, init_array, SIZE) < 0) {
        printf(1, "monitor_init failed\n");
        exit();
    }

    int pid1 = fork();
    if (pid1 == 0) {
        // child 1
        for (int i = 0; i < ITERATIONS; i++) {
            monitor_increase_all_elems(1);
        }
        exit();
    }

    int pid2 = fork();
    if (pid2 == 0) {
        // child 2
        for (int i = 0; i < ITERATIONS; i++) {
            monitor_increase_all_elems(1);
        }
        exit();
    }

    wait();
    wait();

    int result[SIZE];
    if (monitor_read_shared_mem(1, result) < 0) {
        printf(1, "monitor_read_shared_mem failed\n");
        exit();
    }

    printf(1, "Final shared memory values after increments:\n");
    for (int i = 0; i < SIZE; i++) {
        printf(1, "result[%d] = %d\n", i, result[i]);
    }

    exit();
}