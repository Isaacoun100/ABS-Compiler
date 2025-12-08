package codigo;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class CodeGenerator {

    private static final CodeGenerator INSTANCE = new CodeGenerator();
        public static CodeGenerator getInstance() {
            return INSTANCE;
    }
    
     private CodeGenerator() {
    }

    // Contadores para generar nombres únicos (labels, temporales)
    private int labelCounter = 0;
    private int tempCounter  = 0;
    
    // ---------------------- METODOS ---------------
    // Variables Globales: Nombre -> tipo (INT, REAL, STRING, CHAR)
    private final Map<String, String> globalVars = new LinkedHashMap<>();
    //Esto nos va a ayudar a encontrar las variables por nombre despues y hacer
    //analisis semantico: Variables doblemente definidas

    //Instrucciones del main
     private final List<String> mainCode = new ArrayList<>();
    
     // --------------------- lista de errores semánticos -----------------
    private final List<String> semanticErrors = new ArrayList<>();

    public void addSemanticError(String msg) {
        // si no querés duplicados:
        if (!semanticErrors.contains(msg)) {
            semanticErrors.add(msg);
        }
    }

    public List<String> getSemanticErrors() {
        return semanticErrors;
    }

    // ¿La variable existe? (por ahora solo revisa globales)
    public boolean isVarDefined(String name) {
        return globalVars.containsKey(name);
    }

    // Obtener el tipo de la variable (por ahora solo globales)
    public String getVarType(String name) {
        return globalVars.get(name);
    }

    //----------GUARDAR VARIABLES GLOBALES--------------------
    // guardamos las variables globales en la lista cuando las encontremos en el VAR
    // public void declararGlobal(String nombre, String tipo) {
    //     if (globalVars.containsKey(nombre)) {
    //         addSemanticError("Variable global '" + nombre + "' declarada más de una vez"); //Implementado el que de este error, faltan pruebas 
    //         return;
    //     }
    //     globalVars.put(nombre, tipo);
    // }

    //Nueva version, ahora el error lo ponemos en el parser 
    public void declararGlobal(String nombre, String tipo) {
    if (globalVars.containsKey(nombre)) {
        // Ya reportamos el error desde el parser, aquí solo evitamos duplicar
        return;
    }
    globalVars.put(nombre, tipo);
}
    //----------METODO PARA AÑADIR UNA INSTRUCCION AL MAIN-------
    // La lista de instrucciones del main
    public void emit(String instr) {
        mainCode.add(instr);
    }

    //--------------GENERAR LABELS------------//
    // Genera labels unicos con un numero que se va incrementando
    // TODO: podriamos hacerlo mas bonito
    public String newLabel(String prefix) {
        return prefix + (labelCounter++);
    }

    //-----------GENERAR VARIABLES TEMPORALES---------
    public String newTemp() {
        return "t" + (tempCounter++);
    }


    // ---------------------------GENERAR CODIGO NASM-------------------------//

    public String buildProgram() {
        StringBuilder sb = new StringBuilder();

        //Encabezado del archivo
        sb.append("global main\n");
        sb.append("extern printf\n\n");

        // Seccion .data para variables globales
        sb.append("section .data\n");
        // para imprimir con printf
        sb.append("    fmtInt db \"%d\", 10, 0\n");

        
        sb.append('\n');

        //Para variables sin valor inicial
        sb.append("section .bss\n\n");
        //Escribir todas las variables globales que se encontraron
        
        for (Map.Entry<String, String> e : globalVars.entrySet()) {
        //Formato que ocupamos: [variable-name]  bytes a reservar (resb, resd)
            String nombre = e.getKey();
            String tipo   = e.getValue();

            //agregarlo al docu
            sb.append("    ").append(nombre);
            
            if (tipo.equals("CHAR")) {
                sb.append(" resb 1\n"); //1 byte
            } else {
                sb.append(" resd 1\n"); // 4 bytes
            }
   
        }

        sb.append("\n");

        // -------- .text: código del main ---
        sb.append("section .text\n");
        sb.append("main:\n");

        //Instrucciones del main
        
        sb.append("    ret\n");
        return sb.toString();
    }

}