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
                reader = new FileReader("src/test.txt");
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

        Set<String> printed = new HashSet<>();

        for (token currentToken : tokenList) {
            String key = "%s|%s".formatted(currentToken.getTokenName(), currentToken.getValue());

            if (!printed.contains(key)) {
                printed.add(key);

                // Count occurrences per line
                Map<Integer, Integer> lineCounts = new LinkedHashMap<>();
                int count = 0;

                for (token other : tokenList) {
                    if (other.getTokenName().equals(currentToken.getTokenName()) &&
                            other.getValue().equals(currentToken.getValue())) {

                        lineCounts.put(other.getLine(),
                                lineCounts.getOrDefault(other.getLine(), 0) + 1);
                        count++;
                    }
                }

                // Build formatted line list
                List<String> formattedLines = new ArrayList<>();
                for (Map.Entry<Integer, Integer> e : lineCounts.entrySet()) {
                    if (e.getValue() > 1) {
                        formattedLines.add("%d(%d)".formatted(e.getKey(), e.getValue()));
                    } else {
                        formattedLines.add(String.valueOf(e.getKey()));
                    }
                }

                System.out.printf("Token: %s, Value: %s, Lines: %s, Count: %d%n", currentToken.getTokenName(), currentToken.getValue(), formattedLines, count);
            }
        }

    }

}