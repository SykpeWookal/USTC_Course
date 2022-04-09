#2020.3.22
.text
.globl main
#$gp�������ַ
#$s0�������С
#��������ʱ�ֱ𴫸�$a0��$a1

main:
	la $a0, str_1		#�����ʾ�û����������С
	li $v0, 4
	syscall         #��������ַ���
	
	li $v0,5	       #ϵͳ���ðѿ���̨�е����ݶ���$v0
	syscall
	
	move $s0, $v0		#�Ѵӿ���̨����������С���浽s0
	la $a0, str_2		#����ַ���2����ʾ�û���ʼ��������
	li $v0, 4
	syscall      #��������ַ���
	
	
	#����read����
	move $a0, $gp		#��$gp��Ϊ�������ݸ�read�����õ������ַ
	move $a1, $s0
	jal read		#��ת��read����ͬʱ������������ַ��$ra
	
	
	#��ӡ�ղŵ�������
	li $v0, 4
	la $a0, str_4
	syscall
	
	move $a0, $gp
	move $a1, $s0
	jal print     #���ô�ӡ����
	
	
	#����������
	move $a0, $gp
	move $a1, $s0
	jal sort
	
	
	#�����������
	li $v0, 4
	la $a0, str_3  #��������ַ���
	syscall
	
	move $a0, $gp
	move $a1, $s0
	jal print
	
	j EXIT
	
	
#�ӿ���̨�����ݣ�read����
read:
	addi $sp, $sp, -4	#ջ�п���һ���µ�ַ��������Ԫ�ظ���
	sw $s0, 0($sp)
	li $s0, 0	#��s0�Ĵ������㣬��Ϊ���������ļ�����
	
	#������������ת�����������ƵĶ���ѭ��
	#t0���жϱ�־λ��t1���洢��ַ
	read_1:
		sltu $t0, $s0, $a1	#s0<a1��t0=1(����t0=0),���Ѷ�������ĸ���С���û������Ϊ��
		beq $t0, $zero, exit_1	#t0=zero����ת��exit_1����ʱ�Ѿ���ɶ���
		sll $t0, $s0, 2		#s0*4����Ϊƫ����
		add $t1, $a0, $t0	#a0����t0�����µ�ַ����Ϊʵ�ʵ�ַ
		move $t2, $a0		#��a0��ֵ����t2����
		li $v0, 5			#������̨�����ݶ���$v0
		syscall
		
		sw $v0, 0($t1)		#�����������ݵ����棬�����t1��Ԫ�ص�ʵ�ʵ�ַ
		move $a0, $t2		#�ٰ�t2��ֵ���ظ�a0
		addi $s0, $s0, 1	#s0++
		j read_1  #ֱ����ת��read_1�ĵ�ַ
		
	exit_1:
		lw $s0, 0($sp)		#��ջ����Ķ���(�����С)д�ؼĴ���
		addi $sp, $sp, 4	#��ջ
		jr $ra				#����read����
		
		
#������
sort:
	addi $sp, $sp, -20		#��ջ�п���5���µ�ַ
	#���ΰ�Ҫ�õı�����λ�ö���������ջ
	sw $ra, 16($sp)			#���ص�ַ
	sw $s3, 12($sp)			#�����С
	sw $s2, 8($sp)			#�����ַ
	sw $s1, 4($sp)			#j
	sw $s0, 0($sp)			#i
	move $s2, $a0			
	move $s3, $a1
	move $s0, $zero
	li $v0, 30				#��ʼ��ʱ
    syscall
    move $s4, $a0
	
	forOut:
		slt $t0, $s0, $s3		#���i<n��t0=1
		beq $t0, $zero, exit1	#���t0=0,��ת��exit1�˳����ѭ��
		addi $s1, $s0, -1		#j = i - 1
		
	forIn:
		slti $t0, $s1, 0		#���j<0,��t0=1
		bne $t0, $zero, exit2	#���t0!=0,��ת��exit2
		sll $t1, $s1, 2			#$t1 = j*4
		add $t2, $s2, $t1		#t2����arr[j]�ĵ�ַ
		lw $t3, 0($t2)			#ȡ��arr[j]�����ݵ�$t3
		lw $t4, 4($t2)			#ȡ��arr[j+1]�����ݵ�$t4
		slt $t0, $t3, $t4		#���arr[j]<arr[j+1],��t0=1
		beq $t0, $zero, exit2	#����������ת��exit2�˳��ڲ�ѭ��
		move $a0, $s2			#�������ַ�Ĳ�������swap����
		move $a1, $s1			#�Ѳ���jҲ����
		jal swap
		addi $s1, $s1, -1		#j--
		j forIn
		
	exit2:
		addi $s0, $s0, 1	#i++
		j forOut		#�������ѭ��
		
	exit1:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $ra, 16($sp)
		addi $sp, $sp, 20
		li $v0, 30				#��ʱ����
    	syscall
    	sub $s5, $a0, $s4
    	li $v0, 4				#����ַ�5
		la $a0, str_5
		syscall
    	move $a0, $s5
    	li $v0, 1				#���ʱ��
    	syscall
    	li $v0, 4				#�����λ
		la $a0, str_6
		syscall
		jr $ra					#����sort����
		
	swap:    #����
		sll $t0, $a1, 2			#j������λ�ŵ�t0��
		add $t0, $a0, $t0		#����ַ����ƫ����arr[j]�ĵ�ַ
		lw $t1, 0($t0)			#��arr[j]��ֵ����t1��
		lw $t2, 4($t0)			#��arr[j+1]��ֵ����t2��
		sw $t1, 4($t0)			#arr[j]=arr[j+1]
		sw $t2, 0($t0)			#arr[j+1]=arr[j]
		jr $ra					#���ص���ǰ�ĵ�ַ��������swap����
	

#�������print,��ӡһ�����������Ԫ��
print:
	addi $sp, $sp, -4
	sw $s0,0($sp)				#����Ĵ���s0��ַ
	li $s0, 0					#��s0����
	
	print_1:
		sltu $t0, $s0, $a1		#so<a1ʱt0=1
		beq $t0, $zero, exit_2	#t0=0ʱ�˳�ѭ��
		sll $t0, $s0, 2			#s0*4
		add $t1, $a0, $t0		#��ַ��ƫ����
		move $t2, $a0			#��a0��ֵ����t2
		lw $a0, 0($t1)			#��Ҫ��ӡ��ֵ����a0
		li $v0, 1				#��ӡֵ
		syscall
		
		li $a0, ','				#��ӡ�ָ���
		li $v0, 11
		syscall
		
		move $a0, $t2			#�����¶���a0��ֵ
		addi $s0, $s0, 1		#s0++
		j print_1
		
	exit_2:
		lw $s0, 0($sp)
		addi $sp, $sp, 4
		jr $ra					#����print����



EXIT:

   .data
   str_1:
	.asciiz "Input the length of the array to sort:\n"
   str_2:
	.asciiz "Input the number:\n"
   str_3:
	.asciiz "\nThe result is:\n"
   str_4:
	.asciiz "The input number are:\n"
   str_5:
	.asciiz "\nThe time of this sort:\n"
   str_6:
	.asciiz "(ms)"
