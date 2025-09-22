import java.io.*;

public class Main {
    public static void main(String[] args) throws Exception {
        // If you pass a file name as argument, use it; otherwise use stdin
        Reader reader;
        if (args.length > 0) {
            reader = new FileReader(args[0]);
        } else {
            reader = new InputStreamReader(System.in);
        }

        absScanner scanner = new absScanner(reader);
        scanner.yylex(); // this triggers scanning until EOF
    }
}