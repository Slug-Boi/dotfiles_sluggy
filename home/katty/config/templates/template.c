#include <stdio.h>

int main() {
    // Read number of inputs
    long n;
    scanf("%ld", &n);

    long xs[n];
    long i;
    long x;
    for (i = 0; i < n; i++) {
        scanf("%ld", &x);
        xs[i] = x;
    }

    // Just printing it 
    printf("[");
    for (i = 0; i < n; i++) {
        printf("%ld", xs[i]);
        if (i != n-1) {
            printf(", ");
        }
    }
    printf("]\n");
}
