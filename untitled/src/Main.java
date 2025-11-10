import java.io.*;
import java.nio.file.*;
import scanner.absScanner;   // lexer JFlex
import parser.Parser;        // parser CUP

public class Main {

    public static void main(String[] args) {
        // Si no pasan ruta, usa un archivo de prueba:
        Path path = (args.length > 0)
                ? Paths.get(args[0])
                : Paths.get("untitled/src/pruebas/test11.txt");

        path = path.toAbsolutePath().normalize();
        System.out.println("Ejecutando: " + path);
        System.out.println("-----------------------------------------------------");

        try (Reader reader = new BufferedReader(new FileReader(path.toFile()))) {
            absScanner lexer = new absScanner(reader);
            @SuppressWarnings("deprecation")
            Parser parser = new Parser(lexer);

            // Intentar parsear
            try {
                Object result = parser.parse().value;

                // Verificar si hubo errores sintácticos
                if (parser.synErrors.isEmpty()) {
                    System.out.println("✓ Análisis sintáctico completado sin errores");
                    System.out.println("✓ AST/resultado: " + result);
                } else {
                    System.out.println("✗ Se encontraron " + parser.synErrors.size() + " error(es) sintáctico(s):\n");
                    for (String error : parser.synErrors) {
                        System.out.println("  - " + error);
                    }
                    System.out.println("\nNota: El parser intentó recuperarse de los errores.");
                }

            } catch (Exception e) {
                // Si hay excepción, aún así mostrar los errores acumulados
                System.out.println("✗ Error durante el parseo\n");

                if (!parser.synErrors.isEmpty()) {
                    System.out.println("Errores sintácticos detectados:");
                    for (String error : parser.synErrors) {
                        System.out.println("  - " + error);
                    }
                } else {
                    // Si no hay errores en synErrors, mostrar la excepción
                    System.out.println("  - " + e.getMessage());
                    if (args.length > 0 && args[0].equals("--debug")) {
                        e.printStackTrace();
                    }
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