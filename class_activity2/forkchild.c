#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>

int main() {
    pid_t pid;

    printf("Parent process ID: %d\n", getpid());
    pid = fork();   // Create child process

    if (pid < 0) {
        perror("Fork failed");
        exit(1);
    }
    else if (pid == 0) {
        // Child process
        printf("Child process created. PID: %d\n", getpid());
        printf("Executing 'ls' command using execvp...\n");

        char *args[] = {"ls", NULL};
        execvp("ls", args);

        // execvp() only returns if it fails
        perror("exec failed");
        exit(1);
    }
    else {
        // Parent process
        wait(NULL);
        printf("Child process completed.\n");
    }

    return 0;
}
