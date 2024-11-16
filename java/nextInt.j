static char [] buffer = new char[256];

public static int nextInt (int radix) { // you are going from base radix to base 10

    int number;
    int digit;
    int i = 1;
    mips.read_s(buffer, 255);
    //System.out.println("Buffer 0 is "+ buffer[0]);

    digit = glyph2int(buffer[0], radix);
    for(number=0; digit != -1 ;) {
      //System.out.println("Buffer "+ i +" is "+ buffer[i]);
      number = (number * radix) + digit ; 
      digit = glyph2int(buffer[i], radix);
      i = i + 1;
      //System.out.println("number is" + number);
    }
    //System.out.println("number is" + number);
    return number;
}

public static int glyph2int(char c, int radix) {

    char input = c;
    int digit; 

    //mips.read_c();
    //input = mips.retval();


    if (in_range(input, '0', '9')) {//0' <= input && input <= '9') {
      digit = input - '0';
    }
    else if ( in_range(input, 'A', 'Z')) { //A' <= input && input <= 'Z') {
       digit = input - 'A';
       digit = digit + 10;
    }
    else if (in_range(input, 'a', 'z')) { //a' <= input && input <= 'z') {
       digit = input - 'a';
       digit = digit + 10;
    }
    else {
       digit = -1;
    }

    if (digit > (radix - 1)) {
        digit = -1;
    }

    return digit;
}

public static boolean in_range(char value, char min, char max){
    if (value >= min){
        if (value <= max){
            return true;
        }
    }
    return false;
}