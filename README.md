# nextInt: 

Java provides the method `nextInt(radix)` as part of its Scanner class. This method reads a string of ASCII characters, and then interprets these characters as a number within the given radix.


## Overview:

During our class, we developed a method called `binary2int`.  This method interpreted a string of zeros (0) and ones (0) as a binary number.  That is to say, we implemented a variant of `nextInt` method where the radix was set to 2. 

Be modifying our binary2int implementation to include a radix, we obtain the following method.

   ```java
   public static int nextInt(int radix) {
   
       int number;
       int digit;
   
       digit = glyph2int(radix);
       for(number=0; digit != -1 ;) {
         number = (number * radix) + digit ; 
         digit = glyph2int(radix);
       }
   
       return number;
   }
   ```

Moreover, we implemented the `glyph2int` method to read a single ASCII character (via `mips.read_c()`), and then returned the associated value for that glyph within the given radix.

In this assignment, your are to refactor the provided `nextInt` method, as well as the `glyph2int` method. 

The primary change is to read a string of characters via a single call to `mips.read_s()`. This call to the OS is made as the first step within the `nextInt` method. The method than walks the given string to compute the final integer value. The following steps summarize the operation of of the `nextInt` method. 

  1. Call the OS to read a string: e.g., `mips.read_s(buffer, 255)`
     - the resulting string is stored in the array `buffer`
     - the resulting string is followed by both '\n', and then a '\0' character.

  1. For each character, c, in the array `buffer`
     1. convert the character to a digit
        - digit = glyph2int(c, radix)
     1. generate the new approximation of the number
        - number = number * radix + digit

  1. Return `number` 
      
Notice as a consequence to the refactoring of `nextInt`, we also have to refactor `glyph2int`.  The type signature of glyph2int becomes:

  * `int glyph2int(char glyph, int radix)`


## Objectives
   1. To obtain a better understanding of the process to convert a number from one base (radix) to another base.

   1. To gain a better understanding of access memory, in which are arrays are stored.

   1. To further develop our software development skills.

## Specifications and Limitations
   1. You must use branches as demonstrated by the [Programming Workflow](./programming_workflow.md) document.
      * A branch must exist for the tasks:  'java', 'java_tac', and 'mips'.
      * Each branch must have at least 4 commits.
      * Each branch must be merged into the main branch.
      * A submission tag must exist for each branch: 'java_submitted', 'java_tac_submitted', 'mips_submitted'.
      * Such tags must be associated with a commit that created prior to the due date.

   1. Your java_tac code may use operations with immediate values.
      - but such immediate values can only be the second operand
      - for example,  `var = var {op} imm;` is permissible.
      - for example,  `var = imm {op} var;` is *not* permissible.

   1. Refer to comp122/reference/TAC_transformation to aid you in transforming java to java_tac

   1. Refer to comp122/referenceTAC2mips.md to aid you in transliterating java_tac to MIPS.


## Tasks
Note that these instructions presume that the current working directory is: `~/classes/comp122/deliverables/44-nextInt-{account}`.


### Getting Situated 
1. Review the methods provided within the java directory.
   - nextInt.j:  glyph2int, nextInt
   - echo.j:     echo

1. Test the methods provided within the java subdirectory.
   - `java_subroutine -R null java/echo`
     * the echo method demonstrates the use of `mips.read_s()`
   - `make test_java` 

1. Test the subroutine provided within the mips subdirectory.
   - `java_subroutine -R null java/echo`
     * the echo subroutine demonstrates the use of the load instructions

1. Review the provided test cases.
   - 00_glyph2int.sth_case
   - smf-steve.sth_case


### Test_cases:
  1. Create at least two test cases within the file `test_cases/{account}.sth_case`. 
     * See the file `test_cases/{smf-steve}.sth_case` as an example.

  1. Trade your test cases with at least two other students. Place these files into your `test_cases` directory.  E.g., 
     - `test_cases/{student_1}.sth_case`
     - `test_cases/{student_2}.sth_case`

  1. Add and commit these test cases to your local repository:
     ```bash
     git add test_cases/{account}.sth_case
     git add test_cases/{student_1}.sth_case
     git add test_cases/{student_2}.sth_case
     git commit -m 'adding shared test_cases'
     ```
  1. Note that all of the above work is performed on the `main` branch.

Remember, do NOT rely solely on automated testing. You need to test your code during the development process.


### Java: `nextInt.j`

  1. Remember to following the [Programming Workflow](./programming_flow.md))
     - the file java/NextInt.j has already been added for you
  1. Refactor your `nextInt` and `glyph2Int` methods   
  1. Perform manual testing as you develop your solution
  1. Continue working on your solution until you have a working solution.
  1. Run `make test_java` to invoke the automated testing.
  1. Finish your Java Task   

#### Optional Enhancement

Recall that our `binary2int` method used a left-shift to perform the multiplication step. We prefer to use shift operations, over multiplication, whenever possible.   A shift operation can be performed in one clock cycle, whereas, a multiplication can take thirty-two clock cycles. (This is highly depending on the algorithm used to perform a multiplication)

 If you are so inclined, consider replacing the multiplication step in your algorithm with the appropriate shift operations:
   ```
   -  if      (radix ==  2) { value == value << 1 + digit; } // x*2 == x << 1
   -  else if (radix ==  4) { value == value << 2 + digit; } // x*4 == x << 2
   -  else if (radix ==  8) ...
   -  else if (radix == 10) { value = (value << 3) + (value << 1) ; }
        // i = (x << 3) + (x << 1);
        // i = (x * 8) + (x * 2);
        // i = 8x + 2x
        // i = 10x

   -  else                  { value = value * radix + digit; }
   ```
For all other radix-es, you can use simply use the multiplication instruction.


### Java_tac: `nextInt.j`  
  1. Start the `java_tac` Task
  1. Incrementally Work on your `java_task` task
  1. Finish the `java_tac` task.


### MIPS: `nextInt.s`
  1. Start the `mips` Task with the file `mips/nextInt.s`
  1. Copy your java_tac code into `mips/nextInt.s`
  1. Edit your code by commenting out, etc., your java code
  1. Include the following code into `mips/nextInt.s`
     ```mips
                    .globl nextInt

                    .globl glyph2int
                    .data
     buffer:        .space 256

                    .text
                    .include "include/stack.s"
                    .include "include/syscalls.s"
                    .include "include/subroutine.s"
     ```

  1. Incrementally Work on your `mips` task to transliterate each of your java_tac statements.

  1. Finish the `mips` task.


#### MIPS: Additional Information

 1. To facilitate the call to the glyph2int subroutine, you can use `call` macro that is defined within the `subroutine.s` include file. The purpose of this macro will be more fully explained in an upcoming lecture.
 
    For now, simply use the following TAC -> MIPS mapping.

    | Java TAC                | MIPS Macro                |
    |-------------------------|---------------------------|
    | v = glyph2int(c, r)     | call glyph2int c, r       |
    |                         | move a, $v0               |

1. To facilitate the call to the `read_s` syscall, you need to ensure that the two input values are first placed into registers.  Hence, you will need to allocated two additional variables that contain the address of the buffer and the maximum amount of characters to read.

   | Java TAC                | MIPS Macro                |
   |-------------------------|---------------------------|
   | mips.read_s(buf, 256)   | la p, buf                 |
   |                         | li v, 256                 |
   |                         | read_s(p, v)              |


 
### Finish the assignment: 
At this point, you have completed the assignment and you have submitted it. But now you have a chance to "confirm" that when the Professor grades the assignment, it is based upon what you believe you submitted.

In short, perform one more test to make sure everything is as it should be.

  ```bash
  git switch main
  make confirm
  ```

Make any alterations to your previous work to ensure you maximize your score.  Note you must remember to reset and to republish your "submission" tags correctly.  The tags are what the Professor uses to determine *what* to grade.



