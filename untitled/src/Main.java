import java.io.*;
import java.nio.file.*;
import java.util.ArrayList;
import scanner.absScanner;
import parser.Parser;

public class Main {

    public static void main(String[] args) {
        // Determine input file: use command line arg if provided, otherwise default
        Path path = (args.length > 0)
                ? Paths.get(args[0])
                : Paths.get("untitled/src/pruebas/test.txt");

        path = path.toAbsolutePath().normalize();
        System.out.println("Ejecutando: " + path);
        System.out.println("-----------------------------------------------------");

        try (Reader reader = new BufferedReader(new FileReader(path.toFile()))) {
            absScanner lexer = new absScanner(reader);
            @SuppressWarnings("deprecation")
            Parser parser = new Parser(lexer);

            try {
                Object result = parser.parse().value;

                // Collect any errors that occurred during lexical and syntactic analysis
                ArrayList<String> lexErrors = lexer.lexErrors;
                ArrayList<String> synErrors = parser.synErrors;

                if (lexErrors.isEmpty() && synErrors.isEmpty()) {
                    printSuccess(result);
                } else {
                    printErrors(lexErrors, synErrors);
                }

            } catch (Exception e) {
                handleParseException(parser, e);
            }

        } catch (FileNotFoundException e) {
            System.err.println("✗ No se encontró el archivo: " + path);
            System.exit(1);
        } catch (IOException e) {
            System.err.println("✗ Error de lectura del archivo: " + e.getMessage());
            System.exit(2);
        }
    }

    private static void printSuccess(Object result) {
        System.out.println("✓ Análisis completado sin errores");
        System.out.println("✓ AST/resultado: " + result);
    }

    private static void printErrors(ArrayList<String> lexErrors, ArrayList<String> synErrors) {
        if (!lexErrors.isEmpty()) {
            System.out.println("\n========== ERRORES LÉXICOS (" + lexErrors.size() + ") ==========");
            lexErrors.forEach(error -> System.out.println("  ✗ " + error));
        }

        if (!synErrors.isEmpty()) {
            System.out.println("\n========== ERRORES SINTÁCTICOS (" + synErrors.size() + ") ==========");
            synErrors.forEach(error -> System.out.println("  ✗ " + error));
        }

        System.out.println("\n-----------------------------------------------------");
        System.out.println("Total: " + lexErrors.size() + " léxico(s), " +
                synErrors.size() + " sintáctico(s)");
    }

    private static void handleParseException(Parser parser, Exception e) {
        System.out.println("✗ Error durante el parseo\n");

        if (!parser.synErrors.isEmpty()) {
            System.out.println("Errores detectados:");
            parser.synErrors.forEach(error -> System.out.println("  - " + error));
        } else {
            System.out.println("  - " + e.getMessage());
        }
    }
}