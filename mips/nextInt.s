        .globl nextInt
        .data
buff:   .space 256                        #static char [] buffer = new char[256];
        .text                #
        .include "include/stack.s"        
        .include "include/syscalls.s"
        .include "include/subroutine.s"




nextInt: nop                        #public static int nextInt (int radix) { // you are going from base radix to base 10
        #bookkeeping
        #a0: radix                #
        #t0: number                #    int number;
        #t1: digit;                #    int digit;
        #t2: i;                #    int i;
        #t6: buff address
        #t7: radix               #
        
        add $t2, $zero, 1                #    i = 1;
                        #
        move $t7, $a0
                        #
        la $t6 buff
        read_si $t6, 255                #    mips.read_s(buffer, 255);

                        #    //System.out.println("Buffer 0 is "+ buffer[0]);
                        #


        lb $a0, 0($t6)
        #call glyph2int $a0, $t7     #PRAY THIS WORKSSSSSSSSSSSSSSSSS          #    digit = glyph2int(buffer[0], radix);
        #move $t1, $v0       #this moves the result to digit, which has to be split from the above equation^

                #start of testing in_range
                li $t4, '0' #min
                li $t5, '9'#max
                move $t3, $a0
        call in_range $t3, $t4, $t5 #this calls the function
        move $a0, $v0 #this moves the true/false to the staging area
        li $v0, 1 #1 is to call int located at $a0
        syscall #execute the call
        move $v0, $zero
        jr $ra #end the function

                #end testing of in_range

        #add $t0, $zero, $zero                #   number=0
loop:   #beq $t1, '-1', done                #    for(; digit != -1 ;) {
body: nop                        #      //System.out.println("Buffer "+ i +" is "+ buffer[i]);
                        #      //number = (number * radix) + digit ; 
        #mult $t0, $t7                 #      number = number * radix;
        #mflo $t0
        #add $t0, $t0, $t1                #      number = number + digit;
        #call glyph2int $a0, $t7                #      digit = glyph2int(buffer[i], radix);
        #move $t1, $v0   #this moves the result to digit, which has to be split from the above equation^
next:   #nop
        #addi $t2, $t2, 1                #      i = i + 1;
        #lb $a0, $t2($t6)
                        #      //System.out.println("number is" + number);
                        #    }
done:                        
                        #    //System.out.println("number is" + number);
        #move $v0, $t0                    #    return number;
        #jr $ra                    #}
                        #
glyph2int: nop                        #public static int glyph2int(char c, int radix) {
        #bookkeeping
        #a0: c, input
        #t1: digit
        #t7: radix                #
        
        #redundant                #    char input = c;
        #also redundant                #    int digit; 
                        #
                        #    //mips.read_c();
                        #    //input = mips.retval();
                        #
                        #
        #call in_range                 #    if (in_range(input, '0', '9')) {//0' <= input && input <= '9') {
                        #      digit = input - '0';
                        #    }
                        #    else if ( in_range(input, 'A', 'Z')) { //A' <= input && input <= 'Z') {
                        #       digit = input - 'A';
                        #       digit = digit + 10;
                        #    }
                        #    else if (in_range(input, 'a', 'z')) { //a' <= input && input <= 'z') {
                        #       digit = input - 'a';
                        #       digit = digit + 10;
                        #    }
                        #    else {
                        #       digit = -1;
                        #    }
                        #
                        #    if (digit > (radix - 1)) {
                        #        digit = -1;
                        #    }
                        #
                        #    return digit;
                        #}
                        #
in_range: nop      #CONFIRMED WORKING. DON'T TOUCH                  #public static boolean in_range(char value, char min, char max){
        #bookkeeping
        #t3: value
        #t4: min
        #t5: max 
        

fcomp:  blt $t3, $t4, ir_done                       #    if (value >= min){
scomp:  bgt $t3, $t5, ir_done                      #        if (value <= max){
        addi $v0, $zero, 1              #            return true;
        jr $ra                #        }
                        #    }
ir_done:add $v0, $zero, $zero                      #    return false;
        jr $ra                #}