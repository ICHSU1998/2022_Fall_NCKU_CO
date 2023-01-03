void two_sort(int *array) {
	int a = *(array);
	int b = *(array + 1);
	
	if(a > b) {
		*(array) = b;
		*(array + 1) = a;
	}
}

int mul(int multiplicand, int multiplier) {
    int a = abs(multiplicand)
    int b = abs(mul tiplier)
    
    int array[2] = {a, b};
    two_sort(&array);

    int i = 0;
    int result = 0;
    while (i < array[0]) {
        result += array[1];
        i++;
    }
	
    int mask_a = multiplicand >>> 31;
    int mask_b = multiplier >>> 31;
    int mask_result = mask_a ^ mask_b;
	
    result = result ^ mask_result;
    result = result - mask_result;
    
    return result;
}

int div(int dividend, int divisor) {
	int a = abs(dividend);
	int b = abs(divisor);
	int result = 0;
	
	while(a >= b){
		a = a - b;
		result = result + 1;
	}
	
	int mask_a = dividend >>> 31;
	int mask_b = divisor >>> 31;
	int mask_result = mask_a ^ mask_b;
	
	result = result ^ mask_result;
	result = result - mask_result;
	
	return result;
}

int power(int base, int exponent) {
	int b = abs(exponent);
	int result = 1;
	int mask_b = exponent >>> 31;
	if(base == 0)
		result = 0;
	else if(exponent == 0)
		result = 1;
	else{
	    while (b != 0) {
			result = mul(base, result);
			--b;
		}
	}
	if(mask_b)
		result = div(1 ,result);
	
	return result;
}

int main() {
    int num_test = * (int *) 0x10000000;
    int *test =      (int *) 0x10000004;
    int *answer =    (int *) 0x01000000;

    for (int i = 0 ; i < num_test ; i++) {
        // test i
        int result;
        int valid = 1;
        // test{i} from memory;
        int base = *(test++);
        int exponent = *(test++);
        if (base == 0 && exponent <= 0)
            valid = 0;
        else
            result = power(base, exponent);
        *(answer++) = valid;
        *(answer++) = result;
    }
    return 0;
}