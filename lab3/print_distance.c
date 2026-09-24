#include <stdio.h>

extern long hamming_distance(void);

int main() {
    long total_distance =  hamming_distance();

    printf("Hamming Distance: %ld\n",total_distance);

    return 0;
}
