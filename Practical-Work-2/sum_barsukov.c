#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int main(void) {
    pid_t pid = fork();

    if (pid < 0) {
        perror("fork");
        return EXIT_FAILURE;
    }

    if (pid == 0) {
        char *const args[] = {"sum", "-r", "/etc/passwd", NULL};

        printf("the child of Barsukov executes: sum\n");
        fflush(stdout);
        sleep(1);
        execv("/usr/bin/sum", args);

        perror("execv");
        _exit(errno == ENOENT ? 127 : 126);
    }

    int status = 0;
    if (waitpid(pid, &status, 0) < 0) {
        perror("waitpid");
        return EXIT_FAILURE;
    }

    if (WIFEXITED(status)) {
        printf("parent: child process %ld exited with status %d\n",
               (long)pid, WEXITSTATUS(status));
        return WEXITSTATUS(status);
    }

    fprintf(stderr, "parent: child process ended abnormally\n");
    return EXIT_FAILURE;
}
