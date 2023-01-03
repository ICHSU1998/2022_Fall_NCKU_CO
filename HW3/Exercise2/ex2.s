.data
num_test: .word 18
test1: .word 0, 0
test2: .word 0, -2
test3: .word 0, 7
test4: .word 7, 0
test5: .word -3, 0
test6: .word 1, 4
test7: .word 1, 0
test8: .word 1, -5
test9: .word -1, 5
test10: .word -1, 4
test11: .word -1, 0
test12: .word -1, -5
test13: .word -1, -4
test14: .word 2, 3
test15: .word 2, -3
test16: .word -3, 5
test17: .word -3, 6
test18: .word -3, -3

.text
setup:
    li    ra, -1
    li    sp, 0x7ffffff0
main:
    ##########################################################################
    # < Function >
    #  main procedure
    #
    # < Parameters >
    # NULL
    #
    # < Return Value >
    # NULL
    ##########################################################################
    # < Local Variable >
    # s0 : num_test
    # s1 : test
    # s2 : answer
    # s3 : i
    # s4 : valid
    # s5 : result
    # s6 : base
    # s7 : exponent
    ##########################################################################
    ## Save ra & Callee Saved
    addi sp, sp, -36 # Allocate stack space
                     # sp = @sp - 36
    sw ra, 32(sp)    # @ra -> MEM[@sp - 4]
    sw s0, 28(sp)    # s0 -> MEM[@sp - 8]
    sw s1, 24(sp)    # s1 -> MEM[@sp - 12]
    sw s2, 20(sp)    # s2 -> MEM[@sp - 16]
    sw s3, 16(sp)    # s3 -> MEM[@sp - 20]
    sw s4, 12(sp)    # s4 -> MEM[@sp - 24]
    sw s5, 8(sp)     # s5 -> MEM[@sp - 28]
    sw s6, 4(sp)     # s6 -> MEM[@sp - 32]
    sw s7, 0(sp)     # s7 -> MEM[@sp - 36]

    # Get num_test
    la s0, num_test    # s0 = Addr(num_test)
    lw s0, 0(s0)       # s0(num_test) = MEM[s0]
    
    # Load address of test and answer
    li s1, 0x10000004    # s1 = Addr(0x10000004)
    li s2, 0x01000000    # s2 = Addr(0x01000000)
    
    li s3, 0    # i = 0
main_loop:
    bge s3, s0, main_end_loop    # if(i >= num_test), go to main_end_loop
    addi s3, s3, 1    # i = i + 1
    li s4, 1    # valid = 1
    lw s6, 0(s1)    # s6(0x10000004) = MEM[s1]
    lw s7, 4(s1)    # s7(0x10000008) = MEM[s1 + 4]
    addi s1, s1, 8    #  MEM[s1 + 8]
    
    bne s6, x0, main_else    # if(base != 0), go to main_else
main_if:
    blt x0, s7, main_else    #if(exponent > 0), go to main_else
main_else_if:
    li s4, 0    # valid = 0
    jal x0, main_endif    # Jump to main_endif
main_else:
    # Pass Arguments
    mv a0, s6    # a0 = base
    mv a1, s7    # a1 = exponent
    
    #Jump to Callee
    jal ra, POWER    # ra = Addr(addi sp, sp, -4)  
    
    #########################################################################
    
main_endif: 
    sw s4, 0(s2)    # s4(valid) = MEM[@sp - 36]
    sw a5, 4(s2)    # a5(result) = MEM[s@sp - 32]
    
    addi s2, s2, 8    #  MEM[s2 + 8]
    
    jal x0, main_loop    # jump to main_loop     
main_end_loop:
    ## Retrieve ra & Retrieve Calllee Saved
    lw ra, 32(sp)    # ra = @ra
    lw s0, 28(sp)    # s0 = @s0
    lw s1, 24(sp)    # s1 = @s1
    lw s2, 20(sp)    # s2 = @s2
    lw s3, 16(sp)    # s3 = @s3
    lw s4, 12(sp)    # s4 = @s4
    lw s5, 8(sp)    # s5 = @s5
    lw s6, 4(sp)    # s6 = @s6
    lw s7, 0(sp)    # s7 = @s7
    
    addi sp, sp, 36    # Release stack space
                       # sp = @ sp
    ## return
    ret    # jalr x0, ra, 0
POWER:
    ##########################################################################
    # < Function >
    #  It can handle power of 2 integer variables
    #
    # < Parameters >
    # a0 : base
    # a1 : exponent
    #
    # < Return Value >
    # a5 : result
    ##########################################################################
    # < Local Variable >
    # s8 : mask_b
    # s9 : abs(exponent)
    # s10 : result_temporary
    # s11 : 1
    ##########################################################################
    ## Save ra & Callee Saved
    # No use saved registers -> No need to do Callee Saved
    addi sp, sp, -20    # Allocate stack space
                        # sp = @sp - 56
    sw ra, 16(sp)    # ra -> MEM[@sp - 40]
    sw s8, 12(sp)    # s8 -> MEM[@sp - 44]
    sw s9, 8(sp)    # s9 -> MEM[@sp - 48]
    sw s10, 4(sp)    # s10 -> MEM[@sp - 52]
    sw s11, 0(sp)    # s11 -> MEM[@sp - 56]

    ## abs(exponent)
    srai s8, a1, 31    # s8 -> MEM[@sp - 8]
    xor s9, a1, s8    # Inverse(-) / Keep(+)
    sub s9, s9, s8    # s9 = abs(divisor)
    
    li s10, 1    #    result_temporary = 1
    li s11, 1    # sll = 1
power_else_1:
    beq a0, x0, power_if_1    # if(base == 0), go to power_if_1
power_else_2:
    beq a1, x0, power_if_2    # if(exponent == 0), go to power_if_2
power_loop:
    beq s9, x0, power_if_mask_b    # if(abs(divisor) == 0), go to power_if_mask_b
    
    ############### Call Function Procedure ###############
    mv a3, a0    # a3 = base 
    mv a4, s10    # a4 = result_temporary
    
    jal ra, FUNC_MUL    # ra = Addr(addi, sp, sp, -4)
    #######################################################
    mv s10, a3    # s10 = a3(result(mul))
    
    sub s9, s9, s11    # abs(exponent) = abs(exponent) - 1
    mv a5, s10    # rsult = s10 
    jal x0, power_loop    # Jump to power_loop
power_if_2:
    ## Pass return value
    mv a5, s11    # result = 1
    jal x0, power_end    # Jump to power_end 
power_if_1:
    ## Pass return value 
    mv a5, x0    # result = 0   
    jal x0, power_end    # Jump to power_end
power_else_mask_b:
    mv a2, s11    # a2 = 1
    mv a3, a5    # a3 = result
    jal ra, FUNC_DIV    # ra = Addr(addi, sp, sp, -4)    
    mv a5, a2    # result = a2(result(div))
    jal x0, power_end    # Jump to power_end
power_if_mask_b:
    bne s8, x0, power_else_mask_b    # if(mask_b != 0), go to power_else_mask_b
power_end:
    ## Retrieve Caller Saved
    lw ra, 16(sp)    # ra = @ra
    lw s8, 12(sp)    # s8 = @s8
    lw s9, 8(sp)    # s9 = @s9
    lw s10, 4(sp)    # s10 = @s10   
    lw s11, 0(sp)    # s11 = @s11
    
    addi sp, sp, 20    # Release stack space
                       # sp = @ sp        
    ## return
    ret    # jalr x0, ra, 0
    
FUNC_DIV:
    ##########################################################################
    # < Function >
    #  It can handle division of 2 integer variables
    #
    # < Parameters >
    # a2 : dividend
    # a3 : divisor
    #
    # < Return Value >
    # a2 : result
    ##########################################################################
    # < Local Variable >
    # t0 : mask_a 
    # t1 : mask_b
    # t2 : result
    # t3 : abs(dividend)
    # t4 : abs(divisor)
    # t5 : mask_result
    ##########################################################################
    ## Save ra & Callee Saved
    # No use saved registers -> No need to do Callee Saved
    addi sp, sp, -4    # Allocate stack space
                       # sp = @sp - 60
    sw ra, 0(sp)    # @ra -> MEM[@sp - 60]
    
    ## abs(dividend)
    srai t0, a2, 31    # t0 -> MEM[@sp - 8]    
    xor t3, a2, t0    # Inverse(-) / Keep(+)    
    sub t3, t3, t0    # t3 = abs(dividend)
    
    ## abs(divisor)
    srai t1, a3, 31    # t1 = 0xffffffff(-) / 0(+)    
    xor t4, a3, t1    # Inverse(-) / Keep(+)
    sub t4, t4, t1    # t4 = abs(divisor)
    
    ## result
    li t2, 0    # result = 0   
    
    ## mask_result
    xor t5, t0, t1    # t5 = 0xffffffff(-) / 0(+)       
div_loop:
    blt t3, t4, div_end_loop    # if(abs(dividend) < abs(divisor))
    sub t3, t3, t4    # abs(dividend) = abs(dividend) - abs(divisor)    
    addi t2, t2, 1    # abs(dividend) = abs(dividend) - abs(divisor)    
    jal x0, div_loop    # jump to div_loop    
div_end_loop: 

    xor t2, t2, t5    # Inverse(-) / Keep(+)
    sub t2, t2, t5    # t2 = result
   
   
    ## Pass return value 
    mv a2, t2    # a2(return value) = t2    

    ## Retrieve ra & Callee Saved
    lw      ra, 0(sp)    # ra = @ra
    addi    sp, sp, 4    # sp = @sp

    ## return
    ret     # jalr x0, ra, 0
 
 FUNC_MUL:
    #######################################################
    # < Function >
    #    It can handle multiplication of 2 integer variables
    #
    # < Parameters >
    #    a3 : multiplicand
    #    a4 : multiplier
    #
    # < Return Value >
    #    a3 : result
    #######################################################
    # < Local Variable >
    #    t0 : mask_a
    #    t1 : mask_b
    #    t2 : abs(multiplicand) / smaller one 
    #    t3 : abs(multiplier) / bigger one
    #    t4 : mask_result
    #    t5 : i
    #    t6 : result
    #######################################################
    
    ## Save ra & Callee Saved
    # No use saved registers -> No need to do Callee Saved
    addi    sp, sp, -4               # Allocate stack space
                                     # sp = @sp - 64
    sw      ra, 0(sp)                # @ra -> MEM[@sp - 64]
    
    ## abs(multiplicand)
    srai    t0, a3, 31               # t0 = 0xffffffff(-) / 0(+)
    xor     t2, a3, t0               # Inverse(-) / Keep(+)
    sub     t2, t2, t0               # -(-1) / -0
                                     # t2 = abs(multiplicand)
    
    ## abs(multiplier)
    srai    t1, a4, 31               # t1 = 0xffffffff(-) / 0(+)
    xor     t3, a4, t1               # Inverse(-) / Keep(+)
    sub     t3, t3, t1               # t3 = abs(multiplier) 
    
    ## mask_result
    xor     t4, t0, t1               # t4 = 0xffffffff(-) / 0(+)
    
    ## array[2] = {a, b}
    addi    sp, sp, -8               # Allocate stack space
                                     # sp = @sp - 12
    sw      t3, 4(sp)                # t3 -> MEM[@sp - 8]
    sw      t2, 0(sp)                # t2 -> MEM[@sp - 12]
    
    ############### Call Function Procedure ###############
    # Caller Saved
    addi    sp, sp, -4               # Allocate stack space
                                     # sp = @sp - 16
    sw      t4, 0(sp)                # t4 -> MEM[@sp - 16]
    
    # Pass Arguments
    addi    a3, sp, 4                # a0 = &array
    
    # Jump to Callee
    jal     ra, FUNC_TWO_SORT        # ra = Addr(lw  t4, 0(sp))
    #######################################################
    
    # Retrieve Caller Saved
    lw      t4, 0(sp)                # t4(mask_result)
    lw      t2, 4(sp)                # t2 = smaller one 
    lw      t3, 8(sp)                # t3 = bigger one
    
    ## Do multiplication through successive addition
    li      t5, 0                    # t5(i) = 0
    li      t6, 0                    # t6(result) = 0
    bge     t5, t2, FMUL_endWhile_1  # if (i >= smaller), go to endWhile
FMUL_while_1:
    add     t6, t6, t3               # result += bigger
    addi    t5, t5, 1                # i++
    blt     t5, t2, FMUL_while_1     # if (i < smaller), go to while
FMUL_endWhile_1: 
    
    ## Now, t6 = abs(result)
    ## Append sign on the t6
    xor     t6, t6, t4               # Inverse(-) / Keep(+)
    sub     t6, t6, t4               # -(-1) / -0
                                     # t6 = result
                                     
    ## Pass return value
    mv      a3, t6                   # a0(return value) = t6
                                     
    ## Retrieve ra & Callee Saved
    lw      ra, 12(sp)               # ra = @ra
    addi    sp, sp, 16               # sp = @sp
    
    ## return
    ret                              # jalr  x0, ra, 0
    
    
FUNC_TWO_SORT:
    #######################################################
    # < Function >
    #    Do sorting
    #    * Put the smaller one in *array
    #    * Put the bigger one in *(array+1)
    #
    # < Parameters >
    #    a3 : int *array
    #
    # < Return Value >
    #    NULL
    #######################################################
    # < Local Variable >
    #    t0 : a
    #    t1 : b
    #######################################################
    
    ## Save ra & Callee Saved
    # No Function Call -> No need to save ra
    # No use saved registers -> No need to do Callee Saved
    
    lw      t0, 0(a3)                # a = *array
    lw      t1, 4(a3)                # b = *(array+1)
    
    bleu    t0, t1, FUNC_TWO_EXIT    # if a <= b, no need to swap
     
    sw      t1, 0(a3)                # smaller -> *array
    sw      t0, 4(a3)                # bigger -> *(array+1)
FUNC_TWO_EXIT:
    ret                              # return
    
    
    
    