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

    public void emitCopyStringLiteral(String varName, String literal) {
        // literal probablemente viene como "Hola" o Hola.
        String value = literal;

        if (value.length() >= 2 &&
            value.charAt(0) == '"' &&
            value.charAt(value.length() - 1) == '"') {
            value = value.substring(1, value.length() - 1);
        }

        // Copiar carácter por carácter en varName
        for (int i = 0; i < value.length(); i++) {
            char c = value.charAt(i);
            mainCode.add("    mov byte [" + varName + " + " + i + "], " + (int) c);
        }

        // Terminador nulo
        mainCode.add("    mov byte [" + varName + " + " + value.length() + "], 0");
    }
    // ---------------------------GENERAR CODIGO NASM-------------------------//

    public String buildProgram() {
        StringBuilder sb = new StringBuilder();
        
        //LIBRERIA: IO.mac   
        sb.append("%include \"io.mac\"\n\n");

        // Seccion .data para variables globales
        sb.append(".DATA\n");
        
        
        sb.append("\n");

        //Para variables sin valor inicial
        sb.append(".UDATA\n\n");

        //Escribir todas las variables globales que se encontraron
        
        for (Map.Entry<String, String> e : globalVars.entrySet()) {
        //Formato que ocupamos: [variable-name]  bytes a reservar (resb, resd)
            String nombre = e.getKey();
            String tipo   = e.getValue();

            //agregarlo al docu
            sb.append("    ").append(nombre);
            
            // if (tipo.equals("CHAR")) {
            //     sb.append(" resb 1\n"); //1 byte
            // } else {
            //     sb.append(" resd 1\n"); // 4 bytes
            // }

             switch (tipo) {
                case "CHAR":
                    // 1 byte
                    sb.append(" resb 1\n");
                    break;

                case "INT":
                    sb.append(" resd 1\n");
                    break;
                case "REAL":
                    sb.append(" resd 1\n");
                    break;

                case "STRING":
                    //256 bytes para un string
                    sb.append(" resb 256\n");
                    break;

                default:
                    
                    sb.append(" resd 1\n");
                    break;
            }
        
        }

        sb.append("\n");

        // -------- .text: código del main ---
        sb.append(".CODE\n");
        sb.append(".STARTUP\n");

        sb.append("main:\n");

        //Instrucciones del main
        for (String instr : mainCode) {
            sb.append(instr);
            if (!instr.endsWith("\n")) {
                sb.append("\n");
            }
        }
        
        // sb.append("    mov eax, 1\n");
        // sb.append("    xor ebx, ebx\n");
        // sb.append("    int 0x80\n");
        sb.append("done:\n");
        sb.append("    .EXIT\n");

        return sb.toString();
    }

}