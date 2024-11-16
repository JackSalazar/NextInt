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
        jal glyph2int               #    digit = glyph2int(buffer[0], radix);
                        #    for(number=0; digit != -1 ;) {
                        #      //System.out.println("Buffer "+ i +" is "+ buffer[i]);
                        #      //number = (number * radix) + digit ; 
                        #      number = number * radix;
                        #      number = number + digit;
                        #      digit = glyph2int(buffer[i], radix);
                        #      i = i + 1;
                        #      //System.out.println("number is" + number);
                        #    }
                        #    //System.out.println("number is" + number);
                        #    return number;
                        #}
                        #
glyph2int: nop                        #public static int glyph2int(char c, int radix) {
        #bookkeeping
        #t3: c, input
        #a0: radix                #
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