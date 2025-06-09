#include "types.h"
#include "user.h"

#define PGSIZE 4096
#define SHM_ID 1
#define NUM_CHILDREN 3

void test_shared_memory(int id, int child_num) {

    void *shm_addr = open_shared_mem(SHM_ID);
    if (shm_addr == (void *)-1) {
        printf(1, "Child %d: Failed to open shared memory with id %d\n", child_num, SHM_ID);
        exit();
    }
    printf(1, "Child %d: Opened shared memory at address %p\n", child_num, shm_addr);

    char *data = (char *)shm_addr;
    char message[50];
    strcpy(message, "Hello from child ");
    message[16] = '0' + child_num; 
    message[17] = '\0';
    strcpy(data, message);
    printf(1, "Child %d: Wrote '%s' to shared memory\n", child_num, data);

    sleep(50);

    printf(1, "Child %d: Read '%s' from shared memory\n", child_num, data);

    if (close_shared_mem(SHM_ID) < 0) {
        printf(1, "Child %d: Failed to close shared memory with id %d\n", child_num, SHM_ID);
        exit();
    }
    printf(1, "Child %d: Closed shared memory\n", child_num);
}
void test_error_cases() {
    void *shm_addr = open_shared_mem(-1);
    if (shm_addr == (void *)-1) {
        printf(1, "Error test: Correctly failed to open shared memory with invalid id -1\n");
    } else {
        printf(1, "Error test: Unexpected success for invalid id -1\n");
        exit();
    }

    if (close_shared_mem(999) < 0) {
        printf(1, "Error test: Correctly failed to close non-existent shared memory id 999\n");
    } else {
        printf(1, "Error test: Unexpected success for closing non-existent id 999\n");
        exit();
    }
}

int main(int argc, char *argv[]) {
    printf(1, "Starting shared memory test\n");
    printf(1, "\n=== Testing error cases ===\n");
    test_error_cases();

    printf(1, "\n=== Testing multiple processes with shared memory ===\n");
    for (int i = 0; i < NUM_CHILDREN; i++) {
        int pid = fork();
        if (pid < 0) {
            printf(1, "Fork failed\n");
            exit();
        } else if (pid == 0) {
            test_shared_memory(SHM_ID, i);
            exit();
        }
    }

    for (int i = 0; i < NUM_CHILDREN; i++) {
        wait();
    }
    printf(1, "\n=== Testing memory deallocation ===\n");
    void *shm_addr = open_shared_mem(SHM_ID);
    if (shm_addr == (void *)-1) {
        printf(1, "Failed to open shared memory for deallocation test\n");
        exit();
    }
    printf(1, "Main: Opened shared memory at address %p\n", shm_addr);

    if (close_shared_mem(SHM_ID) < 0) {
        printf(1, "Main: Failed to close shared memory\n");
        exit();
    }
    printf(1, "Main: Closed shared memory\n");
    shm_addr = open_shared_mem(SHM_ID);
    if (shm_addr == (void *)-1) {
        printf(1, "Failed to reopen shared memory\n");
        exit();
    }
    printf(1, "Main: Reopened shared memory at address %p\n", shm_addr);

    if (close_shared_mem(SHM_ID) < 0) {
        printf(1, "Main: Failed to close shared memory\n");
        exit();
    }
    printf(1, "Main: Closed shared memory again\n");

    printf(1, "\nShared memory test completed\n");
    exit();
}