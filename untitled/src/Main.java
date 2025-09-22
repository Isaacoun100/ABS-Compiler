import java.io.*;
import java.util.*;
import obj.token;

public class Main {
    public static void main(String[] args) throws Exception {
        Reader reader = new FileReader("src/test.txt");
        absScanner scanner = new absScanner(reader);

        List<token> tokenList = new ArrayList<>();
        token t;

        // Scan until EOF, adding each token to the list
        while ((t = scanner.yylex()) != null) {
            tokenList.add(t);
        }

        // Print all tokens
        for (token tok : tokenList) {
            System.out.println(tok);
        }
    }
}
