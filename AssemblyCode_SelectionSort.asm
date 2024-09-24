.data
	arr: .word 23,31,-9,180,99            
.text

addi $s5,$zero,4                           #store value of 4 to be used later for alignment
addi $t0,$0,5                              #store size of array in $t0
la $t1,arr                                 #store base address of array

#selection sorting code
            add $s0,$zero,$zero            #counter for outer loop (i=0)
            addi $s1,$t0,-1                # store len-1 in $s1
outer_loop: bge $s0,$s1, exit              #check if i>=len-1 then break
	    add $s7,$s0,$zero              #min_pos=i 
	    addi $s2,$s0,1                 #counter for inner loop , j=i+1
	    j inner_loop
	    
	    #swap min-pos to place 
cont_out :  mul $t3,$s5,$s0                #i*4 for alignment
	    add $t3,$t3,$t1                #store value of index i 
	    lw $t4,0($t3)                  #tmp= arr[i]
	    
	    mul $t6,$s5,$s7                #min_pos*4 for alignment
	    add $t6,$t6,$t1                #store min_pos address val 
	    lw $t5,0($t6)                  #tmp2= arr[min_pos]
	    
	    sw $t5,0($t3)                  #arr[i] = tmp2 = arr[min_pos]
	    sw $t4,0($t6)                  #arr[min_pos] = tmp = arr[i]
	    
	    addi $s0,$s0,1                 #i++
	    j outer_loop

inner_loop: bge $s2,$t0,cont_out           #j>=n , break 
 
	    mul $t3,$s5, $s2               #j*4 for alignment
	    add $t3,$t3,$t1                #store index j address
	    lw $t4,0($t3)                  #tmp= arr[j]
	    
	    mul $t6,$s5,$s7                #min_pos*4 for alignment
	    add $t6,$t6,$t1                #store min_pos address val
	    lw $t5,0($t6)                  #tmp2= arr[min_pos]
	    
	    bge $t4,$t5,cont_in            #if(arr[j]>=arr[min_pos], no change
	    add $s7,$s2,$zero                  #min_pos=j;
	    
cont_in:    addi $s2,$s2,1                 #j++
	    j inner_loop
      
exit:       addi $v0,$0,10                 #exit program
            syscall
