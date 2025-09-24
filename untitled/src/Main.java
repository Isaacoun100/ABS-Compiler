import java.io.*;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import obj.token;

public class Main {
    
    public static void main(String[] args) {

        // 1) obtener path del archivo a procesar
        Path path = (args.length > 0) 
            ? Paths.get(args[0])
            : Paths.get("untitled/src/pruebas/test1.txt");   // <-- cambia si tu default es otro

        path = path.toAbsolutePath().normalize();

        // 2) mensaje claro en consola
        System.out.println(
            "Se está ejecutando el archivo \"" + path.getFileName() + "\" en: " + path.getParent());
        System.out.println("-----------------------------------------------------");
        // 3) abrir, escanear y reportar
        try (Reader reader = new BufferedReader(new FileReader(path.toFile()))) {
        absScanner scanner = new absScanner(reader);
        lexAn(scanner);   // <-- tu lógica de agregado/impresión
        } catch (FileNotFoundException e) {
        System.err.println("No se encontró el archivo: " + path);
        System.exit(1);
        } catch (IOException e) {
        System.err.println("Error leyendo el archivo: " + e.getMessage());
        System.exit(2);
        }
            System.out.println();
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