import java.io.*;
import java.nio.file.*;
import java.util.ArrayList;
import scanner.absScanner;
import parser.Parser;

public class Main {

    public static void main(String[] args) {
        Path path = (args.length > 0)
                ? Paths.get(args[0])
                : Paths.get("untitled/src/pruebas/test1.txt");

        path = path.toAbsolutePath().normalize();
        System.out.println("Ejecutando: " + path);
        System.out.println("-----------------------------------------------------");

        try (Reader reader = new BufferedReader(new FileReader(path.toFile()))) {
            absScanner lexer = new absScanner(reader);
            @SuppressWarnings("deprecation")
            Parser parser = new Parser(lexer);

            try {
                Object result = parser.parse().value;

                // Separar errores por tipo usando el mensaje
                ArrayList<String> lexErrors = new ArrayList<>();
                ArrayList<String> synErrors = new ArrayList<>();

                for (String error : parser.synErrors) {
                    // Si el mensaje contiene palabras clave de errores léxicos
                    if (error.contains("Carácter no reconocido") ||
                            error.contains("no reconocido") ||
                            error.contains("String sin cerrar") ||
                            error.contains("Comentario sin cerrar")) {
                        lexErrors.add(error);
                    } else {
                        synErrors.add(error);
                    }
                }

                // Mostrar resultados separados
                if (lexErrors.isEmpty() && synErrors.isEmpty()) {
                    System.out.println("✓ Análisis completado sin errores");
                    System.out.println("✓ AST/resultado: " + result);
                } else {
                    if (!lexErrors.isEmpty()) {
                        System.out.println("\n========== ERRORES LÉXICOS (" + lexErrors.size() + ") ==========");
                        for (String error : lexErrors) {
                            System.out.println("  ✗ " + error);
                        }
                    }

                    if (!synErrors.isEmpty()) {
                        System.out.println("\n========== ERRORES SINTÁCTICOS (" + synErrors.size() + ") ==========");
                        for (String error : synErrors) {
                            System.out.println("  ✗ " + error);
                        }
                    }

                    System.out.println("\n-----------------------------------------------------");
                    System.out.println("Total: " + lexErrors.size() + " léxico(s), " +
                            synErrors.size() + " sintáctico(s)");
                }

            } catch (Exception e) {
                System.out.println("✗ Error durante el parseo\n");

                if (!parser.synErrors.isEmpty()) {
                    System.out.println("Errores detectados:");
                    for (String error : parser.synErrors) {
                        System.out.println("  - " + error);
                    }
                } else {
                    System.out.println("  - " + e.getMessage());
                }
            }

        } catch (FileNotFoundException e) {
            System.err.println("✗ No se encontró el archivo: " + path);
            System.exit(1);
        } catch (IOException e) {
            System.err.println("✗ Error de lectura del archivo: " + e.getMessage());
            System.exit(2);
        }

        System.out.println("-----------------------------------------------------");
    }
}