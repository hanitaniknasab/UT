#include "types.h"
#include "stat.h"
#include "user.h"

int
main() {
    int init_array[5] = {1, 2, 3, 4, 5};

    if (monitor_init(1, init_array, 5) < 0) {
        printf(1, "monitor_init failed\n");
        exit();
    }

    if (monitor_increase_all_elems(1) < 0) {
        printf(1, "monitor_increase_all_elems failed\n");
        exit();
    }

    int data[5];
    if (monitor_read_shared_mem(1, data) < 0) {
        printf(1, "monitor_read_shared_mem failed\n");
        exit();
    }

    printf(1, "Data read from shared memory:\n");
    for (int i = 0; i < 5; i++) {
        printf(1, "data[%d] = %d\n", i, data[i]);
    }

    if (monitor_close_shared_mem(1) < 0) {
        printf(1, "monitor_close_shared_mem failed\n");
        exit();
    }
    printf(1, "monitor_close_shared_mem was successful.\n");


    exit();
}
