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

    //OBTENER EL TIPO DE UNA VARIABLE
     public String getGlobalType(String nombre) {
        return globalVars.get(nombre);
    }
    
    //----------GUARDAR VARIABLES GLOBALES--------------------
    // guardamos las variables globales en la lista cuando las encontremos en el VAR
    public void declararGlobal(String nombre, String tipo) {
        if (globalVars.containsKey(nombre)) {
            // TODO: esto debería ir a la lista de errores semánticos,
            System.err.println("Advertencia: variable global repetida: " + nombre);
            return;
        }
        globalVars.put(nombre, tipo);
    }




    //----------METODO PARA AÑADIR UNA INSTRUCCION AL MAIN-------
    // La lista de instrucciones del main
    public void emit(String instr) {
        mainCode.add(instr);
    }

     public int emitAndGetIndex(String instr) {
        mainCode.add(instr);
        return mainCode.size() - 1;
    }

    // Reemplazar la instrucción en una posición específica
    public void replaceAt(int index, String newInstr) {
        if (index >= 0 && index < mainCode.size()) {
            mainCode.set(index, newInstr);
        }
    }
    //--------------GENERAR LABELS------------//
    // Genera labels unicos con un numero que se va incrementando
    // TODO: podriamos hacerlo mas bonito
    public String newLabel(String prefix) {
        labelCounter++;
        return prefix + "_" + labelCounter;
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
        for (String instr : mainCode) {
            sb.append(instr);
            if (!instr.endsWith("\n")) {
                sb.append("\n");
            }
        }
        
        sb.append("    ret\n");
        return sb.toString();
    }

}