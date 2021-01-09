# COMP 411 FALL 2020 LAB 4 STARTER CODE

.data 0x0
  executionTime:	.word 0
  numberOfProcessors:	.word 0 
  totalPrice:		.word 0
  
  timePrompt:		.asciiz "Please enter the desired execution time (in seconds): "	
  pricePrompt:		.asciiz "Please enter the price of the processor(in dollars): "
  cpiPrompt:		.asciiz "Please enter the average CPI of the processor: "
  executionTimeIs:	.asciiz "Execution time in seconds: "
  isDesired:		.asciiz "This processor meets the desired execution time, adding to cart."
  notDesired:		.asciiz "This processor does not meet the desired execution time."
  totalProcessors:	.asciiz "Total number of processors purchased: "
  isTotalPrice:		.asciiz "Total price of processors purchased: "
  doneShopping:		.asciiz "You are done shopping for processors."
  newline:		.asciiz "\n"

 .text
main:
 # Print the prompt for time
  addi 	$v0, $0, 4  		# system call 4 is for printing a string
  la 	$a0, timePrompt 	# address of timePrompt is in $a0
  syscall           		# print the string
 
  # Read the Execution TIme
  addi	$v0, $0, 5		# system call 5 is for reading an integer
  syscall 			# integer value read is in $v0
  add	$8, $0, $v0		# copy the execution time into $8
  sw 	$s0, numberOfProcessors	# number of Processors stored in $s0
  sw 	$s1, totalPrice		# total Price stored in $s1
  j	loop	
  
 		
loop:
  # TO-DO: Complete the body of the loop.
  # Use the system calls provided above for input/output as a template for handling strings.
  #================================================================================================#
  
  addi 	$v0, $0, 4  		# system call 4 is for printing a string
  la 	$a0, pricePrompt 	# address of pricePrompt is in $a0
  syscall           		# print the string
  
  addi	$v0, $0, 5		# system call 5 is for reading an integer
  syscall 			# integer value read is in $v0
  add	$9, $0, $v0		# copy the price into $9
  beq	$9, $0, exit		# if price is 0, exit the loop
  
  addi 	$v0, $0, 4  		# system call 4 is for printing a string
  la 	$a0, cpiPrompt	 	# address of cpiPrompt is in $a0
  syscall           		# print the string
  
  addi	$v0, $0, 5		# system call 5 is for reading an integer
  syscall 			# integer value read is in $v0
  add	$10, $0, $v0		# copy the cpi into $10
  
  sll	$11, $10, 1		# shifting left by 1 bit is the same as multiplying by 2
  				# that is the ratio from 8e9/4e9
  
  addi 	$v0, $0, 4  		# system call 4 is for printing a string
  la 	$a0, executionTimeIs 	# address of executionTimeIs is in $a0
  syscall           		# print the string
  
  addi 	$v0, $0, 1  		# system call 4 is for printing a string
  la 	$a0, ($11)	 	# address of execution time is in $a0
  syscall           		# print the string
  
  addi 	$v0, $0, 4  		# system call 4 is for printing a string
  la 	$a0, newline 		# address of newline is in $a0
  syscall           		# print the string
  
  slt	$12, $8, $11
  beq	$12, $0, addToCart
  
  addi 	$v0, $0, 4  		# system call 4 is for printing a string
  la 	$a0, notDesired 	# address of newline is in $a0
  syscall           		# print the string
  
  addi 	$v0, $0, 4  		# system call 4 is for printing a string
  la 	$a0, newline 		# address of newline is in $a0
  syscall           		# print the string
  
  j	loop
  
addToCart:

  addi	$s0, $s0, 1		# adding a processor to total number of processors
  add	$s1, $s1, $9		# adding price to total price
  
  addi 	$v0, $0, 4  		# system call 4 is for printing a string
  la 	$a0, isDesired 		# address of newline is in $a0
  syscall           		# print the string
  
  addi 	$v0, $0, 4  		# system call 4 is for printing a string
  la 	$a0, newline 		# address of newline is in $a0
  syscall           		# print the string
  
  j	loop
  
  
  #================================================================================================#
exit:
  # TO-DO: Complete the behavior of the program after exiting the loop.
  # Indicate that we have left the loop and output the number of processors and total price.
  #================================================================================================#
 
  addi 	$v0, $0, 4  		# system call 4 is for printing a string
  la 	$a0, doneShopping 	# address of doneShopping is in $a0
  syscall           		# print the string
  
  addi 	$v0, $0, 4  		# system call 4 is for printing a string
  la 	$a0, newline 		# address of newline is in $a0
  syscall           		# print the string
  
  addi 	$v0, $0, 4  		# system call 4 is for printing a string
  la 	$a0, totalProcessors 	# address of totalProcessors is in $a0
  syscall           		# print the string
  
  addi 	$v0, $0, 1  		# system call 1 is for printing an integer
  la 	$a0, ($s0)	 	# address of number of processors is in $a0
  syscall           		# print the string
 
  addi 	$v0, $0, 4  		# system call 4 is for printing a string
  la 	$a0, newline 		# address of newline is in $a0
  syscall           		# print the string
  
  addi 	$v0, $0, 4  		# system call 4 is for printing a string
  la 	$a0, isTotalPrice 	# address of totalProcessors is in $a0
  syscall           		# print the string
  
  addi 	$v0, $0, 1  		# system call 1 is for printing an integer
  la 	$a0, ($s1)	 	# address of total price is in $a0
  syscall           		# print the string
  
  addi 	$v0, $0, 4  		# system call 4 is for printing a string
  la 	$a0, newline 		# address of newline is in $a0
  syscall           		# print the string
  #================================================================================================#
  
  # Boilerplate system call to terminate program.
  ori $v0, $0, 10       	# system call code 10 for exit
  syscall   			
 
