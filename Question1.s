.data
str: .asciiz "Enter a number: "
str2: .asciiz "
"
str3: .asciiz "* "
.text
.globl main

main:
li $v0, 4    # system call code for print_str
la $a0, str  # address of string to print
syscall     # print the string

li $v0, 5   #system call code for scan integer
syscall
move $t0, $v0

##begining of outer loop

li $t1, 0 #start index of first loop

start_first_loop:
	beq $t1, $t0, end_first_loop #check index of loop

##beginning of inner loop

	li $t2, 0 #start index of second loop

start_second_loop:
	beq $t2, $t0, end_second_loop #check index of loop
	
	li $v0, 4    # system call code for print_str
	la $a0, str3  # address of string to print
	syscall     # print the string

	addi $t2, $t2, 1 #increase counter
	b start_second_loop
end_second_loop:

##end of inner loop

	li $v0, 4    # system call code for print_str
	la $a0, str2  # address of string to print
	syscall     # print the string

	addi $t1, $t1, 1 #increase counter
	b start_first_loop
end_first_loop:

##end of outer loop

li $v0, 10 # terminate program
syscall
