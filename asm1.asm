# asm1.s 

.data
    # String constants
    ERROR_MSG:    .asciiz "ERROR"
    ADDUP_MSG:    .asciiz "ADD UP COMPLETE"
    BIG_START:    .asciiz "BIG START"
    BIG_END:      .asciiz "BIG END"
    ALPHA_LBL:    .asciiz "alpha  : "
    BETA_LBL:     .asciiz "beta   : "
    GAMMA_LBL:    .asciiz "gamma  : "
    DELTA_LBL:    .asciiz "delta  : "
    EPSILON_LBL:  .asciiz "epsilon: "
    NEWLINE:      .asciiz "\n"

.text

.globl studentMain

    # PROLOGUE
    studentMain:
        addiu $sp,  $sp, -24         # allocate stack space -- default of 24 here
        sw    $fp,  0($sp)           # save frame pointer of caller
        sw    $ra,  4($sp)           # save return address
        addiu $fp,  $sp, 20          # setup frame pointer of main
        
        # Load all 9 variables
        # REGISTERS
        # t0 - math boolean 
        # t1 - addUp boolean 
        # t2 - big boolean 
        # t3 - print boolean 
        # t4 - alpha
        # t5 - beta
        # t6 - gamma
        # t7 - delta
        # t8 - epsilon
        # t9 - temporary for comparisons
        
        la    $t0,  math             # t0 = &math	 
        lw    $t0,  0($t0)           # t0 = math
        
        la    $t1,  addUp            # t1 = &addUp
        lw    $t1,  0($t1)           # t1 = addUp
        
        la    $t2,  big              # t2 = &big
        lw    $t2,  0($t2)           # t2 = big
        
        la    $t3,  print            # t3 = &print
        lw    $t3,  0($t3)           # t3 = print
        
        la    $t4,  alpha            # t4 = &alpha
        lw    $t4,  0($t4)           # t4 = alpha
        
        la    $t5,  beta             # t5 = &beta
        lw    $t5,  0($t5)           # t5 = beta
        
        la    $t6,  gamma            # t6 = &gamma
        lw    $t6,  0($t6)           # t6 = gamma
        
        la    $t7,  delta            # t7 = &delta
        lw    $t7,  0($t7)           # t7 = delta
        
        la    $t8,  epsilon          # t8 = &epsilon
        lw    $t8,  0($t8)           # t8 = epsilon


    # TASK 1: math
    # Calculate: alpha OP1 (gamma OP2 epsilon)

    addi  $t9,  $zero, 1            # t9 = 1
    bne   $t0,  $t9, task2          # if (math != 1) skip to task2

    # Check if beta is a valid operator
    addi  $t9,  $zero, 43           # t9 = '+'
    beq   $t5,  $t9, beta_is_valid
    addi  $t9,  $zero, 45           # t9 = '-'
    beq   $t5,  $t9, beta_is_valid
    addi  $t9,  $zero, 38           # t9 = '&'
    beq   $t5,  $t9, beta_is_valid
    addi  $t9,  $zero, 124          # t9 = '|'
    beq   $t5,  $t9, beta_is_valid

    j     print_error               # beta invalid

    beta_is_valid:
        # Check if delta is a valid operator
        addi  $t9,  $zero, 43        # t9 = '+'
        beq   $t7,  $t9, delta_is_valid
        addi  $t9,  $zero, 45        # t9 = '-'
        beq   $t7,  $t9, delta_is_valid
        addi  $t9,  $zero, 38        # t9 = '&'
        beq   $t7,  $t9, delta_is_valid
        addi  $t9,  $zero, 124       # t9 = '|'
        beq   $t7,  $t9, delta_is_valid

        j     print_error            # delta invalid

    delta_is_valid:
        # Perform bracket calculation: gamma OP2 epsilon
        addi  $t9,  $zero, 43        # t9 = '+'
        beq   $t7,  $t9, bracket_add
        addi  $t9,  $zero, 45        # t9 = '-'
        beq   $t7,  $t9, bracket_sub
        addi  $t9,  $zero, 38        # t9 = '&'
        beq   $t7,  $t9, bracket_and
        addi  $t9,  $zero, 124       # t9 = '|'
        beq   $t7,  $t9, bracket_or

    bracket_add:
        add   $s0,  $t6, $t8         # s0 = gamma + epsilon
        j     final_calc

    bracket_sub:
        sub   $s0,  $t6, $t8         # s0 = gamma - epsilon
        j     final_calc

    bracket_and:
        and   $s0,  $t6, $t8         # s0 = gamma & epsilon
        j     final_calc

    bracket_or:
        or    $s0,  $t6, $t8         # s0 = gamma | epsilon
        j     final_calc

    final_calc:
        # Perform final calculation: alpha OP1 bracket_result
        addi  $t9,  $zero, 43        # t9 = '+'
        beq   $t5,  $t9, final_add
        addi  $t9,  $zero, 45        # t9 = '-'
        beq   $t5,  $t9, final_sub
        addi  $t9,  $zero, 38        # t9 = '&'
        beq   $t5,  $t9, final_and
        addi  $t9,  $zero, 124       # t9 = '|'
        beq   $t5,  $t9, final_or

    final_add:
        add   $s1,  $t4, $s0         # s1 = alpha + (gamma OP2 epsilon)
        j     print_result

    final_sub:
        sub   $s1,  $t4, $s0         # s1 = alpha - (gamma OP2 epsilon)
        j     print_result

    final_and:
        and   $s1,  $t4, $s0         # s1 = alpha & (gamma OP2 epsilon)
        j     print_result

    final_or:
        or    $s1,  $t4, $s0         # s1 = alpha | (gamma OP2 epsilon)
        j     print_result

    print_error:
        addi  $v0,  $zero, 4         # print_string
        la    $a0,  ERROR_MSG
        syscall

        addi  $v0,  $zero, 4         # print newline
        la    $a0,  NEWLINE
        syscall
        j     task2

    print_result:
        addi  $v0,  $zero, 1         # print_int
        addi  $a0,  $s1, 0           # result
        syscall

        addi  $v0,  $zero, 4         # print newline
        la    $a0,  NEWLINE
        syscall

    # TASK 2: addUp
    # Running sum through all 5 variables

    task2:
        addi  $t9,  $zero, 1         # t9 = 1
        bne   $t1,  $t9, task3       # if (addUp != 1) skip to task3

        add   $t5,  $t4, $t5         # beta = alpha + beta
        la    $s2,  beta             # s2 = &beta
        sw    $t5,  0($s2)           # beta = new value

        add   $t6,  $t5, $t6         # gamma = beta + gamma
        la    $s2,  gamma            # s2 = &gamma
        sw    $t6,  0($s2)           # gamma = new value

        add   $t7,  $t6, $t7         # delta = gamma + delta
        la    $s2,  delta            # s2 = &delta
        sw    $t7,  0($s2)           # delta = new value

        add   $t8,  $t7, $t8         # epsilon = delta + epsilon
        la    $s2,  epsilon          # s2 = &epsilon
        sw    $t8,  0($s2)           # epsilon = new value

        addi  $v0,  $zero, 4         # print_string
        la    $a0,  ADDUP_MSG
        syscall

        addi  $v0,  $zero, 4         # print newline
        la    $a0,  NEWLINE
        syscall


    # TASK 3: big
    # Print all values greater than 10

    task3:
        addi  $t9,  $zero, 1         # t9 = 1
        bne   $t2,  $t9, task4       # if (big != 1) skip to task4

        addi  $v0,  $zero, 4         # print_string
        la    $a0,  BIG_START
        syscall

        addi  $v0,  $zero, 4         # print newline
        la    $a0,  NEWLINE
        syscall

        addi  $t9,  $zero, 10        # t9 = 10
        slt   $s3,  $t9, $t4         # s3 = (10 < alpha)
        beq   $s3,  $zero, check_beta  # if (alpha <= 10) skip
        addi  $v0,  $zero, 1         # print_int
        addi  $a0,  $t4, 0           # alpha
        syscall
        addi  $v0,  $zero, 4         # print newline
        la    $a0,  NEWLINE
        syscall

    check_beta:
        addi  $t9,  $zero, 10        # t9 = 10
        slt   $s3,  $t9, $t5         # s3 = (10 < beta)
        beq   $s3,  $zero, check_gamma  # if (beta <= 10) skip
        addi  $v0,  $zero, 1         # print_int
        addi  $a0,  $t5, 0           # beta
        syscall
        addi  $v0,  $zero, 4         # print newline
        la    $a0,  NEWLINE
        syscall

    check_gamma:
        addi  $t9,  $zero, 10        # t9 = 10
        slt   $s3,  $t9, $t6         # s3 = (10 < gamma)
        beq   $s3,  $zero, check_delta  # if (gamma <= 10) skip
        addi  $v0,  $zero, 1         # print_int
        addi  $a0,  $t6, 0           # gamma
        syscall
        addi  $v0,  $zero, 4         # print newline
        la    $a0,  NEWLINE
        syscall

    check_delta:
        addi  $t9,  $zero, 10        # t9 = 10
        slt   $s3,  $t9, $t7         # s3 = (10 < delta)
        beq   $s3,  $zero, check_epsilon  # if (delta <= 10) skip
        addi  $v0,  $zero, 1         # print_int
        addi  $a0,  $t7, 0           # delta
        syscall
        addi  $v0,  $zero, 4         # print newline
        la    $a0,  NEWLINE
        syscall

    check_epsilon:
        addi  $t9,  $zero, 10        # t9 = 10
        slt   $s3,  $t9, $t8         # s3 = (10 < epsilon)
        beq   $s3,  $zero, big_end   # if (epsilon <= 10) skip
        addi  $v0,  $zero, 1         # print_int
        addi  $a0,  $t8, 0           # epsilon
        syscall
        addi  $v0,  $zero, 4         # print newline
        la    $a0,  NEWLINE
        syscall

    big_end:
        addi  $v0,  $zero, 4         # print_string
        la    $a0,  BIG_END
        syscall

        addi  $v0,  $zero, 4         # print newline
        la    $a0,  NEWLINE
        syscall


    # TASK 4: print
    # Print all 5 values with labels
    task4:
        addi  $t9,  $zero, 1         # t9 = 1
        bne   $t3,  $t9, done        # if (print != 1) skip to done

        addi  $v0,  $zero, 4         # print_string
        la    $a0,  ALPHA_LBL
        syscall
        addi  $v0,  $zero, 1         # print_int
        addi  $a0,  $t4, 0           # alpha
        syscall
        addi  $v0,  $zero, 4         # print newline
        la    $a0,  NEWLINE
        syscall

        addi  $v0,  $zero, 4         # print_string
        la    $a0,  BETA_LBL
        syscall
        addi  $v0,  $zero, 1         # print_int
        addi  $a0,  $t5, 0           # beta
        syscall
        addi  $v0,  $zero, 4         # print newline
        la    $a0,  NEWLINE
        syscall

        addi  $v0,  $zero, 4         # print_string
        la    $a0,  GAMMA_LBL
        syscall
        addi  $v0,  $zero, 1         # print_int
        addi  $a0,  $t6, 0           # gamma
        syscall
        addi  $v0,  $zero, 4         # print newline
        la    $a0,  NEWLINE
        syscall

        addi  $v0,  $zero, 4         # print_string
        la    $a0,  DELTA_LBL
        syscall
        addi  $v0,  $zero, 1         # print_int
        addi  $a0,  $t7, 0           # delta
        syscall
        addi  $v0,  $zero, 4         # print newline
        la    $a0,  NEWLINE
        syscall

        addi  $v0,  $zero, 4         # print_string
        la    $a0,  EPSILON_LBL
        syscall
        addi  $v0,  $zero, 1         # print_int
        addi  $a0,  $t8, 0           # epsilon
        syscall
        addi  $v0,  $zero, 4         # print newline
        la    $a0,  NEWLINE
        syscall

    done:

    # EPILOGUE
        lw    $ra,  4($sp)           # get return address from stack
        lw    $fp,  0($sp)           # restore the frame pointer of caller
        addiu $sp,  $sp, 24          # restore the stack pointer of caller
        jr    $ra                    # return to code of caller
        