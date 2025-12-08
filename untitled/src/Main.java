import java.io.*;
import java.nio.file.*;
import java.util.ArrayList;
import scanner.absScanner;
import parser.Parser;
import codigo.CodeGenerator;


public class Main {

    public static void main(String[] args) {
        // Determine input file: use command line arg if provided, otherwise default
        String nombreArchivo = "test.txt";
        Path path = (args.length > 0)
                ? Paths.get(args[0])
                : Paths.get("untitled/src/pruebas/" + nombreArchivo);

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
                ArrayList<String> semErrors = parser.semErrors;
                
                if (lexErrors.isEmpty() && synErrors.isEmpty() && semErrors.isEmpty() ) {
                    generateCode(result, nombreArchivo);
                } else {
                    printErrors(lexErrors, synErrors, semErrors);
                }
                parser.imprimirTablaSimbolos();
                parser.imprimirPilaSemantica();
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

    private static void generateCode(Object result, String nombre) {
        printSuccess(result);

        try {
            // Pedirle al CodeGenerator el código NASM
            String asm = CodeGenerator.getInstance().buildProgram();

            // Guardarlo en programa.asm en la carpeta del proyecto
            Path outPath = Paths.get("programa.asm").toAbsolutePath().normalize();
            Files.writeString(outPath, asm);

            System.out.println("✓ Código NASM generado en: " + outPath);
        } catch (IOException e) {
            System.err.println("✗ Error escribiendo programa.asm: " + e.getMessage());
        }
    }

    private static void printSuccess(Object result) {
        System.out.println("✓ Análisis completado sin errores");
        System.out.println("✓ AST/resultado: " + result);
    }

    private static void printErrors(ArrayList<String> lexErrors, ArrayList<String> synErrors, ArrayList<String> semErrors) {
        
        if (!lexErrors.isEmpty()) {
            System.out.println("\n========== ERRORES LÉXICOS (" + lexErrors.size() + ") ==========");
            lexErrors.forEach(error -> System.out.println("  ✗ " + error));
        }

        if (!synErrors.isEmpty()) {
            System.out.println("\n========== ERRORES SINTÁCTICOS (" + synErrors.size() + ") ==========");
            synErrors.forEach(error -> System.out.println("  ✗ " + error));
        }
        if (!semErrors.isEmpty()) {
        System.out.println("\n========== ERRORES SEMÁNTICOS (" + semErrors.size() + ") ==========");
        semErrors.forEach(error -> System.out.println("  ✗ " + error));
        }

        System.out.println("\n-----------------------------------------------------");
        System.out.println("Total: "
            + lexErrors.size() + " léxico(s), "
            + synErrors.size() + " sintáctico(s), "
            + semErrors.size() + " semántico(s)");
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