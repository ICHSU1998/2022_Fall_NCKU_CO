int data1 = 10;
int data2 = 15;

int main() {
    int *answer = (int*) 0x9000;

    int c = 20;
    int d = data1 + data2 - c;
    int e = d * 2;

    *answer = d;
    *(answer+1) = e;

    return 0;
}

