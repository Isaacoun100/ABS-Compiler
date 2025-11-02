import java.io.*;
import java.nio.file.*;
import scanner.absScanner;   // lexer JFlex
import parser.Parser;        // parser CUP

public class Main {

    public static void main(String[] args) {
        // Si no pasan ruta, usa un archivo de prueba:
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
            Object result = parser.parse().value;
            System.out.println("✓ AST/resultado: " + result);

            // Si definiste synErrors en parser.cup, puedes imprimirlos:
            if (!parser.synErrors.isEmpty()) {
                System.out.println("Mensajes del parser:");
                for (String m : parser.synErrors) System.out.println(" - " + m);
            }
        } catch (FileNotFoundException e) {
            System.err.println("No se encontró el archivo: " + path);
            System.exit(1);
        } catch (Exception e) {
            System.err.println("Error durante el parseo: " + e.getMessage());
            e.printStackTrace();
            System.exit(2);
        }
    }
}
