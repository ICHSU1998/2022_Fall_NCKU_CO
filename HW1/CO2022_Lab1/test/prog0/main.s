.data
prepared_data_1: .word 10  # 10 = 0xa
prepared_data_2: .word 0xf # 15 = 0xf

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
# data1 : t0
# data2 : t1
# c : t2
# d : t3
# e : t4

  li    t2, 20                # load immediate,             t2 = 0x14 (20)
  lw    t0, prepared_data_1   # load word,                  t0 = 0xa  (10)
  lw    t1, prepared_data_2   # load word,                  t1 = 0xf  (15)
  add   t3, t0, t1            # addition,                   t3 = 0x19 (25)           
  sub   t3, t3, t2            # subtract,                   t3 = 0x5  (5)
  slli  t4, t3, 1             # shift left logic immediate, t4 = 0xa  (10)

  sw    t3, 0(s0)             # store word,                 mem[0x9000] = t3
  sw    t4, 4(s0)             # store word,                 mem[0x9004] = t4

# ######################################


main_exit:

# ######################################
# ### Return to end the simulation
# ######################################

  lw s0, 0(sp)
  addi sp, sp, 4
  ret

# ######################################
