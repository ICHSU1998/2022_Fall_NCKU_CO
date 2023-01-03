.data
loop_max: .word 10  # 10 = 0xa

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
# i : t0
# loop_max : t1
# total : t2

  li    t2, 0               # load immediate,       t2 = 0x0  (0)
  li    t0, 1               # load immediate,       t0 = 0x1  (0)
  lw    t1, loop_max        # load word,            t1 = 0xa  (10)
  bgt   t0, t1, for_end_1   # branch greater than,  pc = (t0 > t1) ? for_end_1 : pc + 4
for_1:
  add   t2, t2, t0          # addition,             t2 = t2 + t0          
  addi  t0, t0, 1           # addition immediate,   t0 = t0 + 1
  ble   t0, t1, for_1       # branch less equal,    pc = (t0 <= t1) ? for_1 : pc + 4
for_end_1:
  sw    t2, 0(s0)           # store word,           mem[0x9000] = t2

# ######################################


main_exit:

# ######################################
# ### Return to end the simulation
# ######################################

  lw s0, 0(sp)
  addi sp, sp, 4
  ret

# ######################################
