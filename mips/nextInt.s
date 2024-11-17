        .globl nextInt
        .data
buff:   .space 256                        #static char [] buffer = new char[256];
        .text                #
        .include "include/stack.s"        
        .include "include/syscalls.s"
        .include "include/subroutine.s"


        #BEGIN TESTING
        #li $v0, 1
        #move $t8, $a0 #preserves $a0 previous value
        #move $a0, $t0
        #syscall
        #move $a0, $t8 #restores $a0 previous value
        #END TESTING


nextInt: nop                         #public static int nextInt (int radix) { // you are going from base radix to base 10
        #bookkeeping
        #a0: radix                   #
        #a1: bufnum
        #a2:
        #a3:
        #t0: number                  #    int number;
        #t1: digit;                  #    int digit;
        #t2: i;                      #    int i;
        #t6: buff address
        #t7: radixvar                #    int radixvar
        
        add $t2, $zero, $zero        #    i = 1;
                                     #
        move $t7, $a0                #preserves radix value
                                     #
        la $t6 buff
        read_si $t6, 255             #    mips.read_s(buffer, 255);

        lb $a1, 0($t6)               # $a0 = buffer[0]
        call glyph2int $a1, $t7      #    digit = glyph2int(buffer[0], radix);
        move $t1, $v0                #this moves the result to digit, which has to be split from the above equation^

        add $t0, $zero, $zero        #   number=0

        add $t3, $t6, $t2            #ensures that buffer[1] is read
        lb $a1, 0($t3)

loop:   beq $t1, -1, done            #    for(; digit != -1 ;) {
body: nop                            # 
        mult $t0, $t7                #      number = number * radix;
        mflo $t0

        add $t0, $t0, $t1            #      number = number + digit;



        call glyph2int $a1, $t7      #      digit = glyph2int(buffer[i], radix);
        beq $t1, -1, done            #redundant, but checking for additional loop issues
        move $t1, $v0                #this moves the result to digit, which has to be split from the above equation^
next:   nop
        addi $t2, $t2, 1             #      i = i + 1;
        add $t3, $t6, $t2            #method of incrementing, forgot the name but you have a base pointer that is static, then add from there
        lb $a1, 0($t3)

        j loop

                                     #    }
done:                  
    
        move $v0, $t0                #    return number;
        
        jr $ra                       #}
                                     #
glyph2int: nop                       #public static int glyph2int(char c, int radix) {
        #bookkeeping
        #a0: c, input
        #should be $a1, t1: digit
        #t7: radix                #
        #t8: no idea. I just wanna use sub
        #a2: radix -1
        
        #redundant                #    char input = c;
        #also redundant                #    int digit; 
                        #
                        #
                        #
initifnum: nop
        move $t3, $a0
        li $t4, '0'
        li $t5, '9'
        call in_range $t3, $t4, $t5 
ifnum:  bne $v0, 1, initifupper                #    if (in_range(input, '0', '9')) {//0' <= input && input <= '9') {
        
        #nor $t8, $t4, $zero    #MOST LIKELY TO BE BROKEN     #      digit = input - '0';
        #addi $t8, $t8, 1
        #add $t1, $t3, $t8      
                                sub $t1, $3, $t4 #IN CASE OF EMERGENCY, JUST USE THIS
        j ifoob
                        #    }
initifupper: nop
        li $t4, 'A'
        li $t5, 'Z'
        call in_range $t3, $t4, $t5
ifupper:bne $v0, 1, initiflower                        #    else if ( in_range(input, 'A', 'Z')) { //A' <= input && input <= 'Z') {
        #nor $t8, $t4, $zero                #       digit = input - 'A';
        #addi $t8, $t8, 1
        #add $t1, $t3, $t8       
                                sub $t1, $t3, $t4 #IN CASE OF EMERGENCY, JUST USE THIS
        addi $t1, $t1, 10                #       digit = digit + 10;
        
        j ifoob
                        #    }
initiflower:
        li $t4, 'a'
        li $t5, 'z'
        call in_range $t3, $t4, $t5
iflower:bne $v0, 1, ifnone                        #    else if (in_range(input, 'a', 'z')) { //a' <= input && input <= 'z') {
        #nor $t8, $t4, $zero                #       digit = input - 'a';
        #addi $t8, $t8, 1
        #add $t1, $t3, $t8               
                                sub $t1, $t3, $t4 #IN CASE OF EMERGENCY, JUST USE THIS


        addi $t1, $t1, 10                #       digit = digit + 10;
        j ifoob
                        #    }
ifnone: nop                       #    else {
        li $t1, -1                #       digit = -1;
                        #    }
                        #
ifoob: addi $a2, $t7, -1
        ble $t1, $a2, glyph2intdone                #    if (digit > (radix - 1)) {
        li $t1, -1                #        digit = -1;
                        #    }
glyph2intdone:  

        move $v0, $t1
        jr $ra #if this doesn't work, try  not moving t1 to v0, as it is redundant regardless
                        #    return digit;
                        #}
                        #
in_range: nop      #CONFIRMED WORKING. DON'T TOUCH                  #public static boolean in_range(char value, char min, char max){
        #bookkeeping
        #a0 : value previously t3
        #a1 : min   previously t4
        #a2 : max   previously t5 
        

fcomp:  blt $a0, $a1, ir_done                       #    if (value >= min){
scomp:  bgt $a0, $a2, ir_done                      #        if (value <= max){
        addi $v0, $zero, 1              #            return true;
        jr $ra                #        }
                        #    }
ir_done:add $v0, $zero, $zero                      #    return false;
        jr $ra                #}
