.data
num_test: .word 3 
TEST1_SIZE: .word 34
TEST2_SIZE: .word 19
TEST3_SIZE: .word 29
test1: .word 3,41,18,8,40,6,45,1,18,10,24,46,37,23,43,12,3,37,0,15,11,49,47,27,23,30,16,10,45,39,1,23,40,38
test2: .word -3,-23,-22,-6,-21,-19,-1,0,-2,-47,-17,-46,-6,-30,-50,-13,-47,-9,-50 
test3: .word -46,0,-29,-2,23,-46,46,9,-18,-23,35,-37,3,-24,-18,22,0,15,-43,-16,-17,-42,-49,-29,19,-44,0,-18,23

.text
.globl main

main:

# ######################################
# ### Load address of _answer to s0 
# ######################################

  addi sp, sp, -4
  sw s0, 0(sp)
  la s0, _answer

# ######################################


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
    # s1 : *size
    # s2 : *test
    # s3 : *answer
    # s4 : i
    # s5 : j
    # s6 : test_size
    # t0 : test_size - 1
    # t1 : temp[*test]
    ##########################################################################
    ## Save ra & Callee Saved
    addi sp, sp, -32    # Allocate stack space
                        # sp = @sp - 32
    sw ra, 28(sp)       # @ra -> MEM[@sp - 4]
    sw s0, 24(sp)       # @s0 -> MEM[@sp - 8]
    sw s1, 20(sp)       # @s1 -> MEM[@sp - 12]
    sw s2, 16(sp)       # @s2 -> MEM[@sp - 16]
    sw s3, 12(sp)       # @s3 -> MEM[@sp - 20]
    sw s4, 8(sp)        # @s4 -> MEM[@sp - 24]
    sw s5, 4(sp)        # @s5 -> MEM[@sp - 28]
    sw s6, 0(sp)        # @s6 -> MEM[@sp - 32]

    ## Get mum_test & *size & *test & *answer
    lw s0, num_test    # s0 = num_tset
    la s1, TEST1_SIZE    # s1 = *size
    la s2, test1    # s2 = *test
    li s3, 0x09000    # s3 = *answer
    
    li s4, 0    # i = 0
main_loop:
    bge s4, s0, main_endloop    # if(i >= num_test), go to main_endloop
    lw s6, 0(s1)    # s6 = test_size
    addi s1, s1, 4    # s1 = @s1 + 4
    #######################  Call Function Procedure ##########################
    addi t0, s6, -1    # t0 = test_size - 1
    ## Pass Arguments
    mv a0, s2    # a0(*arr) = s2(*test)
    mv a1, x0    # a1(start) = x0(0)
    mv a2, t0    # a2(end) = t0(test_size - 1)
    
    jal ra, MergeSort    # Jump to MergeSort
    ############################################################################
    
    li s5, 0    # j = 0
main_loop2:
    bge s5, s6, main_endloop2    # if(j >= test_size), go to main_endloop2
    lw t1, 0(s2)    # t1 = temp[*test]
    sw t1, 0(s3)    # save temp[*test] to answer
    
    addi s2, s2, 4    # *test++
    addi s3, s3, 4    # *answer++
    
    addi s5, s5, 1    # j = j + 1
    jal x0, main_loop2    # Jump to main_loop2
main_endloop2:
    addi s4, s4, 1    # i = i + 1
    jal x0, main_loop    # Jump to main_loop
main_endloop:
    ## Retrieve ra & Retrieve Callee Saved
    lw ra, 28(sp)    # @ra -> MEM[@sp - 4]
    lw s0, 24(sp)    # @s0 -> MEM[@sp - 8]
    lw s1, 20(sp)    # @s1 -> MEM[@sp - 12]
    lw s2, 16(sp)    # @s2 -> MEM[@sp - 16]
    lw s3, 12(sp)    # @s3 -> MEM[@sp - 20] 
    lw s4, 8(sp)    # @s4 -> MEM[@sp - 24]
    lw s5, 4(sp)    # @s5 -> MEM[@sp - 28]
    lw s6, 0(sp)    # @s6 -> MEM[@sp - 32] 
    
    addi sp, sp, 32    # Release stack space
                       # sp = @sp + 32
    ## return
main_exit:

# ######################################
# ### Return to end the simulation
# ######################################

  lw s0, 0(sp)
  addi sp, sp, 4
  ret

# ######################################
    
MergeSort:
    ##########################################################################
    # < Function >
    #  MergeSort procedure
    # < Parameters >
    # a0 : *arr
    # a1 : start
    # a2 : end
    # < Return Value >
    # NULL
    ##########################################################################
    # < Local Variable >
    # t0 : *arr
    # t1 : start
    # t2 : end
    # t3 : mid
    # t4 : mid + 1
    ##########################################################################
    ## Save ra & Callee Saved
    ## No use saved registers -> No need to do Callee Saved
    addi sp, sp, -4    # Allocate stack space
                       # sp = @sp - 36
    sw ra, 0(sp)    # @ra = MEM[@sp - 36]
    
    mv t0, a0    # t0 = *arr
    mv t1, a1    # t1 = start
    mv t2, a2    # t2 = end
    
MergeSort_if:
    bge t1, t2, MergeSort_end    # if(start >= end), go to MergeSort_end   
    add t3, t1, t2    # t3(mid) = t2(end) + t1(start)
    srai t3, t3, 1    # t3(mid) = t3(mid) / 2
    addi t4, t3, 1    # t4(mid + 1) = t3(mid) + 1
    ## Save ra & Caller Saved
    addi sp, sp, -24    # Allocate stack space
                        # sp = @sp - 60
    sw ra, 20(sp)    # @ra = MEM[@sp - 40]
    sw t0, 16(sp)    # @t0 = MEM[@sp - 44]
    sw t1, 12(sp)    # @t1 = MEM[@sp - 48]
    sw t2, 8(sp)    # @t2 = MEM[@sp - 52]
    sw t3, 4(sp)    # @t3 = MEM[@sp - 56]
    sw t4, 0(sp)    # @t4 = MEM[@sp - 60]
    ## Pass Arguments
    mv a0, t0    # a0 = t0(*arr)
    mv a1, t1    # a1 = t1(start)
    mv a2, t3    # a2 = t3(mid)
    ## Jump to Callee
    jal ra, MergeSort    # Jump to MergeSort
    ## Retrieve ra & Caller Saved
    lw ra, 20(sp)    # @ra = MEM[@sp - 40]
    lw t0, 16(sp)    # @t0 = MEM[@sp - 44]
    lw t1, 12(sp)    # @t1 = MEM[@sp - 48]
    lw t2, 8(sp)    # @t2 = MEM[@sp - 52]
    lw t3, 4(sp)    # @t3 = MEM[@sp - 56]
    lw t4, 0(sp)    # @t4 = MEM[@sp - 60]
    
    addi sp, sp, 24    # Release stack space
                       # sp = @sp + 24
    ## Save ra & Caller Saved
    addi sp, sp, -24    # Allocate stack space
                        # sp = @sp - 24
    sw ra, 20(sp)    # @ra = MEM[@sp - 40]
    sw t0, 16(sp)    # @t0 = MEM[@sp - 44]
    sw t1, 12(sp)    # @t1 = MEM[@sp - 48]
    sw t2, 8(sp)    # @t2 = MEM[@sp - 52]
    sw t3, 4(sp)    # @t3 = MEM[@sp - 56]
    sw t4, 0(sp)    # @t4 = MEM[@sp - 60]
    ## Pass Arguments
    mv a0, t0    # a0 = t0(*arr)
    mv a1, t4    # a1 = t4(mid + 1)
    mv a2, t2    # a2 = t2(end)
    ## Jump to Callee
    jal ra, MergeSort    # Jump to MergeSort
    ## Retrieve ra & Caller Saved
    lw ra, 20(sp)    # @ra = MEM[@sp - 40]
    lw t0, 16(sp)    # @t0 = MEM[@sp - 44]
    lw t1, 12(sp)    # @t1 = MEM[@sp - 48]
    lw t2, 8(sp)    # @t2 = MEM[@sp - 52]
    lw t3, 4(sp)    # @t3 = MEM[@sp - 56]
    lw t4, 0(sp)    # @t4 = MEM[@sp - 60]
    addi sp, sp, 24    # Release stack space
                       # sp = @sp + 24
    ## Save ra & Caller Saved
    addi sp, sp, -24    # Allocate stack space
                        # sp = @sp - 24    
    sw ra, 20(sp)    # @ra = MEM[@sp - 40]
    sw t0, 16(sp)    # @t0 = MEM[@sp - 44]
    sw t1, 12(sp)    # @t1 = MEM[@sp - 48]
    sw t2, 8(sp)    # @t2 = MEM[@sp - 52]
    sw t3, 4(sp)    # @t3 = MEM[@sp - 56]
    sw t4, 0(sp)    # @t4 = MEM[@sp - 60]
    ## Pass Arguments
    mv a0, t0    # a0 = t0(*arr)
    mv a1, t1    # a1 = t1(start)
    mv a2, t3    # a2 = t3(mid)
    mv a3, t2    # a3 = t2(end)
    ## Jump to Callee
    jal ra, Merge    # Jump to MergeSort
    ## Retrieve ra & Caller Saved
    lw ra, 20(sp)    # @ra = MEM[@sp - 40]
    lw t0, 16(sp)    # @t0 = MEM[@sp - 44]
    lw t1, 12(sp)    # @t1 = MEM[@sp - 48]
    lw t2, 8(sp)    # @t2 = MEM[@sp - 52]
    lw t3, 4(sp)    # @t3 = MEM[@sp - 56]
    lw t4, 0(sp)    # @t4 = MEM[@sp - 60]
    addi sp, sp, 24    # Release stack space
                       # sp = @sp + 24
MergeSort_end:
    lw ra, 0(sp)    # @ra = MEM[@sp - 36]
    addi sp, sp, 4    # Release stack space
                      # sp = @sp + 4
    ## return
    ret    # jalr x0, ra, 0
    
Merge:
    ##########################################################################
    # < Function >
    #  Merge procedure
    # < Parameters >
    # a0 : *arr
    # a1 : start
    # a2 : mid
    # a3 : end
    # < Return Value >
    # NULL
    ##########################################################################
    # < Local Variable >
    # s0 : *arr
    # s1 : start
    # s2 : mid
    # s3 : end
    # s4 : temp_size
    # s5 : temp[]
    # s6 : left_index
    # s7 : right_index
    # s8 : left_max
    # s9 : right_max
    # s10 : arr_index
    # t0 : arr[i + start]
    # t1 : temp[i]
    # t2 : arr[arr_index]
    # t3 : temp[left_index]
    # t4 : temp[right_index]
    # t5 : i
    ##########################################################################
    ## Callee Saved
    ## No use saved registers -> No need to do Callee Saved
    addi sp, sp, -44    # Allocate stack space
                        # sp = @sp - 104
    sw s0, 40(sp)    # @s0 = MEM[@sp - 64]
    sw s1, 36(sp)    # @s1 = MEM[@sp - 68]
    sw s2, 32(sp)    # @s2 = MEM[@sp - 72]
    sw s3, 28(sp)    # @s3 = MEM[@sp - 76]
    sw s4, 24(sp)    # @s4 = MEM[@sp - 80]
    sw s5, 20(sp)    # @s5 = MEM[@sp - 84]
    sw s6, 16(sp)    # @s6 = MEM[@sp - 88]
    sw s7, 12(sp)    # @s7 = MEM[@sp - 92]
    sw s8, 8(sp)    # @s8 = MEM[@sp - 96]
    sw s9, 4(sp)    # @s9 = MEM[@sp - 100]
    sw s10, 0(sp)    # @s10 = MEM[@sp - 104]
    ## Pass Arguments
    mv s0, a0    #s0(*arr) = a0(*arr)
    mv s1, a1    #s1(start) = a1(start)
    mv s2, a2    #s2(mid) = a2(mid)
    mv s3, a3    #s3(end) = a3(end)

    sub s4, s3, s1    # s4(temp_size) = s3(end) - s1(start)
    addi s4, s4, 1    # s4(temp_size) = s4(temp_size) + 1
    
    slli s5, s4, 2    # s5(temp[]) = s4(temp_size) * 4
    sub sp, sp, s5    # sp = @sp - 104 - s5
    
    li t5, 0    # i = 0
merge_for:
    bge t5, s4, merge_initial    # if(i >= temp_size), go tomerge_initial
    add t0, t5, s1    # i + start
    slli t0, t0, 2    # (i + start) * 4
    add t0, s0, t0    # arr[i + start] * 4
    lw t0, 0(t0)    # get arr[i + start] value
    slli t1, t5, 2    # i * 4
    add t1, sp, t1    # sp + i * 4
    sw t0, 0(t1)    # temp[i] = arr[i + start]
    
    addi t5, t5, 1    # i = i + 1
    jal x0, merge_for    # Jump to merge_for
merge_initial:
    mv s6, x0    # s6(left_index) = 0
    sub s7, s2, s1    # s7(right_index) = s2(mid) - s1(start)
    addi s7, s7, 1    # s7(right_index) = s7(right_index) + 1
    sub s8, s2, s1    # s8(left_max) = s2(mid) - s1(start)
    sub s9, s3, s1    # s9(right_max) = s3(end) - s1(start)
    mv s10, s1    # s10(arr_index) = s1(start)
while1:
    blt s8, s6, while2    # if(left_index > left_max), go to while2
    blt s9, s7, while2    # if(right_index > right_max), go to while2
    slli t3, s6, 2    # (left_index) * 4
    add t3, sp, t3    # sp + (left_index) * 4
    lw t3, 0(t3)    # get temp[left_index] value
    slli t4, s7, 2    # (right_index) * 4
    add t4, sp, t4    # sp + (right_index) * 4
    lw t4, 0(t4)    # get temp[right_index] value
while1_if_loop:
    blt t4, t3, while1_else_loop    # if(temp[left_index] > temp[right_index]), go to while1_else_loop
    
    slli t3, s6, 2    # (left_index) * 4
    add t3, sp, t3    # sp + (left_index) * 4
    lw t3, 0(t3)    # get temp[left_index] value
    slli t2, s10, 2    # (arr_index) * 4
    add t2, s0, t2    # *arr + (arr_index) * 4
    sw t3, 0(t2)    # arr[arr_index] = temp[left_index]
    
    addi s10, s10, 1    # arr_index = arr_index + 1
    addi s6, s6, 1    # left_index = left_index + 1
    jal x0, condition    # Jump to condition
while1_else_loop:
    slli t4, s7, 2    # (right_index) * 4
    add t4, sp, t4    # sp + (right_index) * 4
    lw t4, 0(t4)    # get temp[right_index] value
    slli t2, s10, 2    # (arr_index) * 4
    add t2, s0, t2    # *arr + (arr_index) * 4
    sw t4, 0(t2)    # arr[arr_index] = temp[right_index]
    
    addi s10, s10, 1    # arr_index = arr_index + 1
    addi s7, s7, 1    # right_index = right_index + 1
condition:
    bge s9, s7, while1    # if(right_max >= right_index), go to while1
while2:
    blt s8, s6, while3    # if(left_index > left_max), go to while3
    slli t3, s6, 2    # (left_index) * 4
    add t3, sp, t3    # sp + (left_index) * 4
    lw t3, 0(t3)    # get temp[left_index] value
    slli t2, s10, 2    # (arr_index) * 4
    add t2, s0, t2    # *arr + (arr_index) * 4
    sw t3, 0(t2)    # arr[arr_index] = temp[left_index]
    
    addi s10, s10, 1    # arr_index = arr_index + 1
    addi s6, s6, 1    # left_index = left_index + 1
    jal x0, while2    # Jump to while2
while3:
    blt s9, s7, merge_end    # if(right_index > right_max), go to merge_end
    slli t4, s7, 2    # (right_index) * 4
    add t4, sp, t4    # sp + (right_index) * 4
    lw t4, 0(t4)    # get temp[right_index] value    
    slli t2, s10, 2    # (arr_index) * 4 
    add t2, s0, t2    # *arr + (arr_index) * 4
    sw t4, 0(t2)    # arr[arr_index] = temp[right_index]
    
    addi s10, s10, 1    # arr_index = arr_index + 1
    addi s7, s7, 1    # right_index = right_index + 1
    
    jal x0, while3    # Jump to while3
merge_end:
    add sp, sp, s5    # sp = @sp - 104
    
    lw s0, 40(sp)    # @s0 = MEM[@sp - 64]
    lw s1, 36(sp)    # @s1 = MEM[@sp - 68]
    lw s2, 32(sp)    # @s2 = MEM[@sp - 72]
    lw s3, 28(sp)    # @s3 = MEM[@sp - 76]
    lw s4, 24(sp)    # @s4 = MEM[@sp - 80]
    lw s5, 20(sp)    # @s5 = MEM[@sp - 84]
    lw s6, 16(sp)    # @s6 = MEM[@sp - 88]
    lw s7, 12(sp)    # @s7 = MEM[@sp - 92]
    lw s8, 8(sp)    # @s8 = MEM[@sp - 96]
    lw s9, 4(sp)    # @s9 = MEM[@sp - 100]
    lw s10, 0(sp)    #s10 = MEM[@sp - 104]
    addi sp, sp, 44    # Release stack space
                       # sp = @sp + 44
    ## return
    ret    # jalr x0, ra, 0
# ######################################

