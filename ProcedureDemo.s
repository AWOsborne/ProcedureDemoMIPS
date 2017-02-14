.data
	###########
	# Purpose: Demo of procedures/functions in MIPS
	###########

	greeting:	.asciiz		"This program counts the 1's\nin the binary representation of a number.\n"
	prompt:		.asciiz		"Please enter a number: "
	count_msg:	.asciiz		"The number of 1's is: "
	number:		.word		0
	bits:		.word		0

.text
	############
	#Procedure: _end_program
	#Purpose: ends the program
	#Arguments: none
	#Returned values: none
	##############
	_end_program:
		li $v0, 10
		syscall

		jr $ra

	############
	#Procedure: print_string
	#Purpose: prints string to the console
	#Arguments: $a0 -> the addrress of the string to print
	#Returned values: none
	##############
	_print_string:
		li $v0, 4	#load sys call for printing a string.
		syscall

		jr $ra 		#return to procedure.

	############
	#Procedure: print_int
	#Purpose: prints int to the console
	#Arguments: $a0 -> the addrress of the int to print
	#Returned values: none
	##############
	_print_int:
		li $v0, 1	#load sys call for printing a string.
		syscall

		jr $ra 		#return to procedure.

	############
	#Procedure: get_int
	#Purpose: gets an int from the console
	#Arguments: none
	#Returned values: $v0 -> the int
	##############
	_get_int:
		li $v0, 5
		syscall

		jr $ra

	############
	#Procedure: count_bits
	#Purpose: Counts the number of 1 bits in the binary representation of the word.
	#Arguments: $a0, the word
	#Returned values: $v0 -> the number of bits in the word.
	##############
	_count_bits:
		li $v0, 0

		count_loop:
			beq $a0, $zero, end_count_loop		#exit when $a0 = 0
			addi $v0, $v0, 1					#$v0 = $v0 + 1
			sub $t0, $a0, 1					#$t0 = $a0 - 1
			and $a0, $a0, $t0					#bitwise AND
			j count_loop
		end_count_loop:
			jr $ra

	############
	#Procedure: main
	#Purpose: prints intro prompts, stores values, calls functions.
	#Arguments: none
	#Returned values: none
	##############
	main:
		la $a0, greeting
		jal _print_string

		la $a0, prompt
		jal _print_string

		jal _get_int
		sw $v0, number

		lw $a0, number
		jal _count_bits
		sw $v0, bits

		la $a0, count_msg
		jal _print_string

		lw $a0, bits
		jal _print_int

		jal _end_program