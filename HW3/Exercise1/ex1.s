.data
num_test: .word 15
test1: .word 8, 0
test2: .word 0, 8
test3: .word 0, -3
test4: .word 4, 4
test5: .word 8, 4
test6: .word 29, 5
test7: .word 3, 4
test8: .word -8, 4
test9: .word -11, 4
test10: .word -3, 4
test11: .word 7, -4
test12: .word 3, -4
test13: .word -9, -6
test14: .word -5, -5
test15: .word -3, -5

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
    # s6 : dividend
    # s7 : divisor
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
    
    bne s7, x0, main_else    # if(divisor != 0), go to main_end_loop
main_if:
    li s4, 0    # valid = 0
    jal x0, main_endif    # jump to main_endif
main_else:
    # Pass Arguments
    mv a0, s6    # a0 = dividend
    mv a1, s7    # a1 = divisor
    
    #Jump to Callee
    jal ra, FUNC_DIV    # ra = Addr(addi sp, sp, -4) 
    
    #########################################################################
    
main_endif: 
    sw s4, 0(s2)    # s4(valid) = MEM[@sp - 36]
    sw a0, 4(s2)    # a0(result) = MEM[s@sp - 32]
    
    addi s2, s2, 8     #  MEM[s2 + 8]
    
    jal x0, main_loop    # jump to main_loop
main_end_loop:
    ## Retrieve ra & Retrieve Callee Saved
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
FUNC_DIV:
    ##########################################################################
    # < Function >
    #  It can handle division of 2 integer variables
    #
    # < Parameters >
    # a0 : dividend
    # a1 : divisor
    #
    # < Return Value >
    # a0 : result
    ##########################################################################
    # < Local Variable >
    # t0 : mask_a 
    # t1 : mask_b
    # t2 : result
    # t3 : abs(dividend)
    # t4 : abs(divisor)
    # t5 : mask_result
    ##########################################################################
    ## Save ra & Caller Saved
    # No use saved registers -> No need to do Callee Saved
    addi sp, sp, -4    # Allocate stack space
                       # sp = @sp - 40
    sw ra, 0(sp)       # @ra -> MEM[@sp - 40]
    
    ## abs(dividend)
    srai t0, a0, 31    # t0 -> MEM[@sp - 8]
    xor t3, a0, t0    # Inverse(-) / Keep(+)
    sub t3, t3, t0    # t3 = abs(dividend)
    
    ## abs(divisor)
    srai t1, a1, 31    # t1 = 0xffffffff(-) / 0(+)
    xor t4, a1, t1    # Inverse(-) / Keep(+)
    sub t4, t4, t1    # t4 = abs(divisor)
    
    ## result
    li t2, 0    # result = 0
    
    ## mask_result
    xor t5, t0, t1   # t5 = 0xffffffff(-) / 0(+)
div_loop:
    blt t3, t4, div_end_loop    # if(abs(dividend) < abs(divisor))
    sub t3, t3, t4    # abs(dividend) = abs(dividend) - abs(divisor)
    addi t2, t2, 1    # result = result + 1
    jal x0, div_loop    # jump to div_loop
div_end_loop: 

    xor t2, t2, t5    # Inverse(-) / Keep(+)
    sub t2, t2, t5    # t2 = result       
    ## Pass return value 
    mv a0, t2    # a0(return value) = t2
    
    ## Retrieve ra & Caller Saved
    lw ra, 0(sp)    # ra = @ra
    addi sp, sp, 4    # sp = @sp
    ## return
    ret    # jalr x0, ra, 0