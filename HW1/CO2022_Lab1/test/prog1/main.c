int loop_max = 10;

int main() {
    int *answer = (int *)0x9000;

    int total = 0;

    for (int i = 1 ; i <= loop_max ; i++) {
        total += i;
    }

    *answer = total;

    return 0;
}
