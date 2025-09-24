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
                reader = new FileReader("untitled/src/pruebas/test1.txt"); // untitled/src/test.txt
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
                // break; //Se quito para que el ciclo funcione correctamente, y no tenga que volver a ejecutar
            }

        }
    }

    //----------------------------------------------------------------------------------//
    // Metodo que normaliza el value segun su tipo de token para que sea case-insensitive
    //----------------------------------------------------------------------------------//
    private static String normalize(String type, String value) {
        if ("IDENTIFIER".equals(type) || "LITERAL".equals(type)) 
            return value.toLowerCase(Locale.ROOT); 
        return value.toUpperCase(Locale.ROOT); //Palabras reservadas en mayuscula
    }
    //----------------------------------------------------------------------------//
    // Metodo que realiza el analisis lexico
    // Imprime los resultados del analisis en el formato token, value, lines, count
    //----------------------------------------------------------------------------//
    static void lexAn(absScanner scanner) throws IOException {
        List<token> tokenList = new ArrayList<>();
        token t;
        while ((t = scanner.yylex()) != null) tokenList.add(t); 

        Map<String, Map<Integer, Integer>> agg = new LinkedHashMap<>();
        
        Map<String, String> displayByKey = new HashMap<>();
        Map<String, String> typeByKey = new HashMap<>();

        for (token tk : tokenList) {
            String type = tk.getTokenName();
            String norm = normalize(type, tk.getValue());
            String key  = type + "|" + norm;

            typeByKey.putIfAbsent(key, type);
            String display = ("IDENTIFIER".equals(type)  || "LITERAL".equals(type))? norm : norm.toUpperCase(Locale.ROOT);
            displayByKey.putIfAbsent(key, display);

            agg.computeIfAbsent(key, k -> new LinkedHashMap<>())
            .merge(tk.getLine() + 1, 1, Integer::sum);
        }

        // imprime en orden de aparición
        for (Map.Entry<String, Map<Integer, Integer>> entry : agg.entrySet()) {
            String key     = entry.getKey();
            String type    = typeByKey.get(key);
            String display = displayByKey.get(key);
            Map<Integer, Integer> lineCounts = entry.getValue();

            // Coloca la cantidad de veces que aparece un token en cierta linea en la lista de lineas
            int total = 0; 
            List<String> formattedLines = new ArrayList<>();
            for (Map.Entry<Integer, Integer> e : lineCounts.entrySet()) {
                int line = e.getKey();     
                int count = e.getValue();
                total += count;
                formattedLines.add(count > 1 ? (line + "(" + count + ")") : String.valueOf(line));
            }

            System.out.printf("Token: %s, Value: %s, Lines: %s, Count: %d%n",
                    type, display, formattedLines, total);
        }
    }

}