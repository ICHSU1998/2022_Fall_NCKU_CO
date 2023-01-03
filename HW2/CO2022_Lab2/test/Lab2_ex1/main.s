.data
# ...

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


# ######################################
# ### Main Program
# ######################################
#####initial#####
 li t1, 9 
 li t2, -13
#####ans0#####
 add t3, t2, t2
 add t3, t3, t2
 slli t4, t1, 2
 add t4, t4, t1
 addi t4, t4, 30
 slli t5, t4, 3
 sub t5, t5, t4
 add t5, t5, t3	
 sw t5, 0(s0)

#####ans1#####
 slli t3, t1, 1
 add t3, t3, t1
 sub t3, x0, t3
 slli t4, t2, 2
 add t4, t4, t2
 sub t4, x0, t4
 add t3, t3, t4
 sw t3, 4(s0)

#####ans2#####
 slt t3, t1, x0
 xori t5, t3, -1
 addi t5, t5, 1
 xor t5, t1, t5
 add t3, t5, t3

 slt t4, t2, x0
 xori t6, t4, -1
 addi t6, t6, 1
 xor t6, t2, t6
 add t4, t6, t4

 add t5, t3, t4
 sw t5, 8(s0)
# add t6m t6m t1
# sub t3, x0, t1
# sltu t4, t3, t1
# sll t5, t1, t4
# slli t4, t4, 1
# sll t3, t1, t4
# add t5, t5, t3
# slli t4, t1, 2	
# sub t5, t4, t5
# srli t5, t5, 1

# sub t3, x0, t2
# sltu t4, t3, t2
# sll t6, t2, t4
# slli t4, t4, 1
# sll t3, t2, t4
# add t6, t6, t3
# slli t4, t2, 2
# sub t6, t4, t6
# srli t6, t6, 1
# add t5, t5, t6
# sw t5, 8(s0)

#####ans3#####
 slli t3, t1, 30
 srai t4, t3 ,30
 slli t3, t2, 30
 srai t5, t3, 30
 add t5, t5, t4  
 sw t5, 12(s0)

#####ans4#####
 srai t3, t1, 3
 slti t5, t1, 0
 add t5, t3, t5
 srai t4, t2, 3
 slti t6, t2, 0
 add t6, t4, t6
 add t5, t5, t6
 sw t5, 16(s0)
 
#####ans5#####
 li t3, 45
 slli t4, t3, 6
 slli t5, t3, 5
 slli t6, t3, 2
 add t5, t4, t5
 add t6, t5, t6
 srli t6, t6, 3
 sw t6, 20(s0)
 
#####ans6#####
 li t3, -5
 slli t4, t3, 3
 sub t4, t4, t3
 srai t4, t4, 1
 addi t4, t4, 1
 sw t4, 24(s0)

#####ans7#####
 li t3, 3
 slli t4, t3, 1
 add t4, t4, t3
 srli t4, t4, 2
 sw t4, 28(s0)

#####ans8#####
 li t3, 7
 li t4, -15
 slli t5, t3, 1
 add t5, t5, t3
 srai t5, t5, 2
 slti t3, t3, 0
 add t5, t5, t3
 slli t6, t4, 1
 add t6, t6, t4
 srai t6, t6, 2
 slti t4, t4, 0
 add t6, t6, t4
 add t6, t5, t6
 sw t6, 32(s0)
# ######################################


main_exit:

# ######################################
# ### Return to end the simulation
# ######################################

  lw s0, 0(sp)
  addi sp, sp, 4
  ret

# ######################################
