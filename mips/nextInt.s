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
        call glyph2int $a0, $t7     #PRAY THIS WORKSSSSSSSSSSSSSSSSS          #    digit = glyph2int(buffer[0], radix);
        move $t1, $v0       #this moves the result to digit, which has to be split from the above equation^

        add $t0, $zero, $zero                #   number=0
loop:        beq $t1, '-1', done                #    for(; digit != -1 ;) {
body: nop                        #      //System.out.println("Buffer "+ i +" is "+ buffer[i]);
                        #      //number = (number * radix) + digit ; 
        mult $t0, $t7                 #      number = number * radix;
        mflo $t0
        add $t0, $t0, $t1                #      number = number + digit;
        call glyph2int $a0, $t7                #      digit = glyph2int(buffer[i], radix);
        move $t1, $v0   #this moves the result to digit, which has to be split from the above equation^
next:   nop
        addi $t2, $t2, 1                #      i = i + 1;
        lb $a0, $t2($t6)
                        #      //System.out.println("number is" + number);
                        #    }
done:                        
                        #    //System.out.println("number is" + number);
                        #    return number;
                        #}
                        #
glyph2int: nop                        #public static int glyph2int(char c, int radix) {
        #bookkeeping
        #t3: c, input
        #a0: radix                #
        add $v0, $zero, $t7 
                        #    char input = c;
                        #    int digit; 
                        #
                        #    //mips.read_c();
                        #    //input = mips.retval();
                        #
                        #
                        #    if (in_range(input, '0', '9')) {//0' <= input && input <= '9') {
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
in_range: nop                        #public static boolean in_range(char value, char min, char max){
        #bookkeeping
        #t3: value
        #t4: min
        #t5: max                
                        #    if (value >= min){
                        #        if (value <= max){
                        #            return true;
                        #        }
                        #    }
                        #    return false;
                        #}