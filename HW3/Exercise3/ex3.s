.data
num_test: .word 5
test1: .word -10
test2: .word 0
test3: .word 1
test4: .word 5
test5: .word 10

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
    # s3 : n
    # s4 : result
    # s5 : i
    ##########################################################################
    ## Save ra & Callee Saved
    addi sp, sp, -8    # Allocate stack space
                     # sp = @sp - 8
    sw ra, 4(sp)    # @ra -> MEM[@sp - 4]
    sw s5, 0(sp)    # s5 -> MEM[@sp - 8]

    # Get num_test
    la s0, num_test    # s0 = Addr(num_test)
    lw s0, 0(s0)    # s0(num_test) = MEM[s0]
    
    # Load address of test and answer
    li s1, 0x10000004    # s1 = Addr(0x10000004)
    li s2, 0x01000000    # s2 = Addr(0x01000000)

    li s5, 0    # i = 0
main_loop:
    bge s5, s0, main_end_loop    # if(i >= num_test), go to main_end_loop 
    addi s5, s5, 1    # i = i + 1
    lw s3, 0(s1)    # s1(n) = MEM[s1]
    addi s1, s1, 4    # addr(s1) + 4
    ################# Call Function Procedure #################################
    # Pass Arguments
    mv a0, s3    # a0 = n
    
    #Jump to Callee
    jal ra, FUNC_FACTORIAL    # ra = Addr(addi sp, sp, -4) 
    ###########################################################################

    ## Get return value
    sw a0, 0(s2)    # s4(n * factorial(n-1)) = MEM[@sp - 36]
    addi s2, s2, 4    # addr(s2) + 4    
    
    jal x0, main_loop    # Jump to main_loop
main_end_loop:    
    ## Retrieve ra & Retrieve Callee Saved
    lw s5, 0(sp)    # s5 = @s5    
    lw ra, 4(sp)    # ra = @ra
    addi sp, sp, 8    # Release stack space
                      # sp = @ sp
    ## return
    ret    # jalr x0, ra, 0

FUNC_FACTORIAL:
    #######################################################
    # < Function >
    #    n * (n-1) * (n-2) * ... * 1
    #
    # < Parameters >
    #    a0 : n
    #
    # < Return Value >
    #    a0 : n * factorial(n-1)
    #######################################################
    # < Local Variable >
    #    t0 : n
    #    t1 : factorial(n-1) 
    #######################################################
    
    ## Save ra & Callee Saved
    # No use saved registers -> No need to do Callee Saved
    addi    sp, sp, -4               # Allocate stack space
                                     # sp = @sp - 12
    sw      ra, 0(sp)                # @ra -> MEM[@sp - 12]
    
    mv      t0, a0                   # t0 = n
    addi    t1, a0, -1               # t1 = n - 1
    beq     t0, x0, endZero           # if (t0 == 0), go to endZero
    blt     t0, x0, endNeg            # if (t0 < 0), go to endNeg    
FactorialRecur:
    ############### Call Function Procedure ###############
    # Caller Saved
    addi    sp, sp, -4               # Allocate stack space
                                     # sp = @sp - 8
    sw      t0, 0(sp)                # t0(n) -> MEM[@sp - 8]                                  
                                     
    # Pass Arguments
    mv      a0, t1                   # a0(n - 1) = t1(n - 1)
    
    # Jump to Callee
    jal     ra, FUNC_FACTORIAL         # ra = Addr(mv  t1, a0)
    #######################################################
    
    ## Get return value
    mv      t1, a0                   # t1 = factorial(n-1)
    
    ## Retrieve Caller Saved
    lw      t0, 0(sp)                # t0 = n
    addi    sp, sp, 4                # Release stack space
                                     # sp = @sp - 4
    jal     x0, endMul
endZero:
    li      a0, 1                    # a0 = 1
    jal     x0, end                  # Jump to end
endNeg:
    li      a0, -1                   # a0 = -1
    jal     x0, end                  # Jump to end                                   
endMul:
    ## Save ra & Callee Saved
    # No use saved registers -> No need to do Callee Saved
    addi    sp, sp, -12               # Allocate stack space
                                      # sp = @sp - 12
    sw      t0, 8(sp)                # @ra -> MEM[@sp - 4]
    sw      t1, 4(sp)                # @ra -> MEM[@sp - 8]
    sw      ra, 0(sp)                # @ra -> MEM[@sp - 12]
    
    mv      a3, t0                   # a3 = n
    mv      a4, t1                   # a4 = factorial(n-1) 
    
    jal     ra, FUNC_MUL             # ra = Addr(addi sp, sp, -4)
    
    lw      t0, 8(sp)                # t0 = @t0
    lw      t1, 4(sp)                # t1 = @t1
    lw      ra, 0(sp)                # ra = @ra
    
    addi    sp, sp, 12               # Release stack space
                                     # sp = @sp
      
    mv     a0, a3                    # a0(n * factorial(n-1)) = a3(n)
end:
    ## Retrieve ra & Retrieve Callee Saved
    lw      ra, 0(sp)                # ra = @ra
    addi    sp, sp, 4                # Release stack space
                                     # sp = @sp
    ## return
    ret                              # jalr  x0, ra, 0
    
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
                                     # sp = @sp - 16
    sw      ra, 0(sp)                # @ra -> MEM[@sp - 16]
    
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
    