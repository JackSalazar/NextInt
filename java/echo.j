
static char [] buf = new char[256];

public static int echo() {

    int max_length;
    int i;
    
    max_length = 256;
    mips.read_s(buf, max_length);

    for(i=0; i < max_length; i++) {
      if (buf[i] == '\n') break;
      mips.print_c(buf[i]);
    }
    mips.print_ci('\n');

    return i;
}
