static char [] buffer = new char[256];

public static int nextInt (int radix) {

    int number;
    int digit;
    int i = 1;
    mips.read_s(buffer, 255);


    digit = glyph2int(buffer[0], radix);
    for(number=0; digit != -1 ;) {
      number = (number * radix) + digit ; 
      digit = glyph2int(buffer[i], radix);
      i = i + 1;
    }

    return number;
}

public static int glyph2int(char c, int radix) {

    int input;
    int digit;

    mips.read_c();
    input = mips.retval();


    if ('0' <= input && input <= '9') {
      digit = input - '0';
    }
    else if ('A' <= input && input <= 'Z') {
       digit = input - 'A';
       digit = digit + 10;
    }
    else if ('a' <= input && input <= 'z') {
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
