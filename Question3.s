.data
str: .asciiz "Enter a number: "
str2: .asciiz "Enter an array element: "
str3: .asciiz "Your sorted array is:  "
str4: .asciiz "  "
arr:    .space 4
.text
.globl main

main:
li $v0, 4    # system call code for print_str
la $a0, str  # address of string to print
syscall     # print the string

li $v0, 5   #system call code for scan integer
syscall

move $t0, $v0

# allocate memory dynamically for array
sll $a0, $v0, 2
li $v0, 9  # system code for allocating memory dynamically     
syscall

move $t1, $zero
move $t2, $v0
move $t6, $v0
move $t7, $v0

initializeArray:
    bge $t1, $t0, endOfinitializeArray

    li $v0, 4    # system call code for print_str
    la $a0, str2  # address of string to print
    syscall     # print the string

    li $v0, 5   #system call code for scan integer
    syscall
    sw $v0, 0($t2)

    addi $t1, $t1, 1 #counter
    addi $t2, $t2, 4 
    j initializeArray

endOfinitializeArray:

###Sorting Array
move $t1, $zero
add $t1, $t1, 1

outerloop:
bge $t1, $t0, end2
move $t3, $zero
add $t3, $t3, 1
move $t6, $t7
##innerloop
sort:
    bge $t3, $t0, end
    lb $v0, 0($t6)
    lb $v1, 4($t6)
    slt $t4, $v0, $v1 
    beq $t4, $zero, swap
    addi $t6, $t6, 4
    addi $t3, $t3, 1 #counter
    j sort
swap:
   move $t5, $v0
   move $v0, $v1
   move $v1, $t5
   sw $v0, 0($t6)
   sw $v1, 4($t6)
   addi $t6, $t6, 4
   addi $t3, $t3, 1 #counter
   j sort
end:
addi $t1, $t1, 1 #counter
j outerloop 
end2:

move $t1, $zero

li $v0, 4    # system call code for print_str
la $a0, str3  # address of string to print
syscall     # print the string

printArray:
    bge $t1, $t0, ending
    lb $v0, 0($t7)
    move $t3, $v0
    li $v0, 1    #system call code for print_int
    move $a0, $t3    # integer to print
    syscall      #print int
    li $v0, 4    # system call code for print_str
    la $a0, str4  # address of string to print
    syscall     # print the string
    addi $t7, $t7, 4
    addi $t1, $t1, 1 #counter
    j printArray

ending:

li $v0, 10 # terminate program
syscall