.data
str: .asciiz "Enter a number: "
str2: .asciiz "Sum of all integer values between zero and the number you enter: "
.text
.globl main

main:
li $v0, 4    # system call code for print_str
la $a0, str  # address of string to print
syscall     # print the string

li $v0, 5   #system call code for scan integer
syscall

move $t0, $v0
move $a0, $t0

jal findSummation #call recursive function

# print the result of function
li $v0, 4    # system call code for print_str
la $a0, str2  # address of string to print
syscall     # print the string
li $v0, 1    #system call code for print_int
move $a0, $v1    # result to print
syscall      #print int

li $v0, 10 # terminate program
syscall

# Recursive function for summation

findSummation: 
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $a0, 0($sp)
beq $a0, $zero, baseCondition #check base condition
addi $a0, $a0, -1 #decrease parameter of the function
jal findSummation #call function recursively
lw $a0, 0($sp)
lw $ra, 4($sp)
addi $sp, $sp, 8
add $v1, $v1, $a0 #summation
jr $ra
baseCondition: #if parameter equals 0, terminates the recursive function
add $v1, $zero, $zero
addi $sp, $sp, 8
jr $ra
syscall



