.data

pattern: 	.space 17	# array of 16 (1 byte) characters (i.e. string) plus one additional character to store the null terminator when N=16

N_prompt:	.asciiz "Enter the number of bits (N): "
newline: 	.asciiz "\n"

.text

main:
  
  addi $v0, $0, 4
  la   $a0, N_prompt	
  syscall

  addi $v0, $0, 5
  syscall
  addi $a0, $v0, 0

  li   $t0, '\0'		# $t0 = '/0'
  sll  $t1, $a0, 2
  sw   $t0, pattern($t1)
  li   $a1, 0       # n
  jal  bingen

exit: 
                    
  addi $v0, $0, 10      	# system call code 10 for exit
  syscall               	# exit the program
  


#----------------------------------------------

# TODO: Main Program

# TODO: Recursive Function

bingen:
  
    addi    $sp, $sp, -8        # Make room on stack for saving $ra and $fp
    sw      $ra, 4($sp)         # Save $ra
    sw      $fp, 0($sp)         # Save $fp
    addi    $fp, $sp, 4         # Set $fp to the start of proc1's stack frame

                                # From now on:
                                #     0($fp) --> $ra's saved value
                                #    -4($fp) --> caller's $fp's saved value                    
  
    addi    $sp, $sp, -16       # e.g., $s0, $s1, $s2, $s3
    sw      $s0, 12($sp)        # Save $s0
    sw      $s1, 8($sp)         # Save $s1
    sw      $s2, 4($sp)         # Save $s2
    sw      $s3, 0($sp)         # Save $s3

                                # From now on:
                                #    -8($fp) --> $s0's saved value
                                #   -12($fp) --> $s1's saved value
                                #   -16($fp) --> $s2's saved value
                                #   -20($fp) --> $s3's saved value
move $s0, $a0
move $s1, $a1                                

beq $a1, $a0, printpattern     # if current == N then branch


li $t0, '0'          #current level = 0
sll $t1, $a1, 2
sw $t0, pattern($t1) 
addi $a1, $a1, 1     
jal bingen     #recursive call

move $a0, $s0
move $a1, $s1

li $t0, '1'          #currentlevel =1
move $a1, $s1
sll $t1, $a1, 2
sw $t0, pattern($t1)
addi $a1, $a1, 1    #currentlevel+1
jal bingen

end_of_bingen:   
    # Restore $sx registers
    lw  $s0,  -8($fp)           # Restore $s0
    lw  $s1, -12($fp)           # Restore $s1
    lw  $s2, -16($fp)           # Restore $s2
    lw  $s3, -20($fp)           # Restore $s3


    # Restore $fp, $ra, and shrink stack back to how we found it,
    
 addi    $sp, $fp, 4     # Restore $sp
    lw      $ra, 0($fp)     # Restore $ra
    lw      $fp, -4($fp)    # Restore $fp
    jr      $ra             # Return from procedure    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
printpattern:

li $t0, 0

loop:

move $a0, $s0
beq $a0, $t0, endofloop
sll $t1, $t0, 2
lw $a0, pattern($t1)
li $v0, 11        #print char
syscall
addi $t0, $t0, 1
j loop

endofloop:

addi 	$v0, $0, 4  			# system call 4 is for printing a string
la 	$a0, newline 
syscall 

j end_of_bingen



