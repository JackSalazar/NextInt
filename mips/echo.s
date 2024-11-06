            .globl echo

            .data
buf:        .space 256              # static char [] buf = new char[256];

            .text
            .include "include/stack.s"
            .include "include/syscalls.s"
            .include "include/subroutine.s"


echo:       nop                     # public static int echo() {
            # t0: max_length        #     int max_length;
            # t1: i                 #     int i;
            # t2: glyph             #     int glyph;
            # ---------------------------------------
            # t3: p      

            li $t0, 256             #     max_length = 256;

            la $t3, buf             #     mips.read_s(buf, max_length);
            read_s($t3, $t0)        

init:       nop                     #     ;
            li $t1, 0               #     i=0;
loop:       bge $t1, $t0, done      #     for(; i < max_length ;) {
              la $t3, buf           #       glyph = buf[i];
              add $t3, $t3, $t1     #       
              lbu $t2, 0($t3)                                    

              beq $t2, '\n', done   #       if (glyph == '\n') break loop;

              print_c($t2)          #       mips.print_c(glyph);
              addi $t1, $t1, 1      #       i++;
            b loop                  #       continue loop;
                                    #     }
done:       nop                     #     ;
            print_ci('\n')          #     mips.print_ci('\n');

            move $v0, $t1           #     return i;
            jr $ra
                                    # }
