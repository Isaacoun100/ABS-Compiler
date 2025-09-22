import java.io.*;
import java.util.*;
import obj.token;

public class Main {
    public static void main(String[] args) throws Exception {

        // Main loop
        while(true){

            // An easy GUI was added to provide the code to scan
            java.util.Scanner optIn = new java.util.Scanner(System.in);
            System.out.println("¿Cómo quieres ingresar el código?");
            System.out.println("  [1] Usar archivo de prueba (test.txt)");
            System.out.println("  [2] Escribir por consola (termina con EOF)");
            System.out.print("Opción: ");
            String opt = optIn.nextLine().trim();

            Reader reader;
            // If the user marks a one then the default file would be used
            if ("1".equals(opt)) {
                reader = new FileReader("untitled/src/test.txt");
                absScanner scanner = new absScanner(reader);
                lexAn(scanner);
            }

            // If the user selects the second option then they'll be able to write the code
            else if("2".equals(opt)){
                System.out.println("Escribe tu código y finaliza con EOF (Ctrl+Z y Enter en Windows, Ctrl+D en macOS/Linux):");
                reader = new InputStreamReader(System.in);
                absScanner scanner = new absScanner(reader);
                lexAn(scanner);
            }

            // If the user marks anything other than 1 or 2
            else {
                System.out.println("Por favor escribe una opción válida");
                break;
            }

        }
    }

    // This method receives the absScanner class and then it scans the file
    static void lexAn(absScanner scanner) throws IOException {

        // The identified tokens will be on a list
        List<token> tokenList = new ArrayList<>();
        token t;

        // To add the tokens to the list
        while ((t = scanner.yylex()) != null) {
            tokenList.add(t);
        }

        // To print the tokens
        for (token tok : tokenList) {
            System.out.println(tok);
        }
    }

}