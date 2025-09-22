import java.io.*;

public class Main {
    public static void main(String[] args) throws Exception {
        // If you pass a file name as argument, use it; otherwise use stdin
        // Reader reader = new FileReader("untitled/src/test.txt");

        java.util.Scanner optIn = new java.util.Scanner(System.in);
        System.out.println("¿Cómo quieres ingresar el código?");
        System.out.println("  [1] Usar archivo de prueba (test.txt)");
        System.out.println("  [2] Escribir por consola (termina con EOF)");
        System.out.print("Opción: ");
        String opt = optIn.nextLine().trim();

        Reader reader;
        if ("1".equals(opt)) {
            // Usa el archivo de prueba (ajusta la ruta si lo moviste)
            reader = new FileReader("test.txt");
        } else {
            System.out.println("Escribe tu código y finaliza con EOF (Ctrl+Z y Enter en Windows, Ctrl+D en macOS/Linux):");
            reader = new InputStreamReader(System.in);
        }

        absScanner scanner = new absScanner(reader);
        scanner.yylex(); // this triggers scanning until EOF
    }
}