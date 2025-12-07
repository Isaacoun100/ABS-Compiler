package codigo;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import parser.Parser;
import static parser.Parser.DO.Clase.*;

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
            // ANALISIS SEMANTICO
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

    public void emitirLiteralEnTemporal(Parser.DO d) {
        // d.tipo == "STRING" y d.clase == CONST
        String tmp = newTemp();
        declararTemporal(tmp, "STRING");         // resb 256 en .UDATA
        emitCopyStringLiteral(tmp, d.valorConst);
        // ahora tmp contiene el literal como string NULL-terminated
        // y podemos hacer PutStr tmp
    }

    public void emitWrite(Parser.DO d) {
        switch (d.tipo) {
            case "INT":
            case "REAL":
                // Enteros / reales como 32 bits con PutLint
                if (d.clase == Parser.DO.Clase.CONST) {
                    // literal numérico
                    emit("    mov eax, " + d.valorConst + "\n");
                    emit("    PutLInt eax\n");
                } else { // ADDR (variable o temporal)
                    emit("    PutLInt [" + d.nombre + "]\n");
                }
                break;

            case "CHAR":
                if (d.clase == Parser.DO.Clase.CONST) {
                    // d.valorConst debería ser el código numérico o el literal,
                    // según cómo lo estés guardando. Si lo guardas como 'A',
                    // tendrás que adaptarlo. De momento asumimos número.
                    emit("    mov al, " + d.valorConst + "\n");
                    emit("    PutCh al\n");
                } else {
                    emit("    PutCh [" + d.nombre + "]\n");
                }
                break;

            case "STRING":
                if (d.clase == Parser.DO.Clase.CONST) {
                    // WRITE("hola")
                    String tmp = newTemp();
                    declararTemporal(tmp, "STRING");
                    emitCopyStringLiteral(tmp, d.valorConst);
                    emit("    PutStr " + tmp + "\n");
                } else {
                    // WRITE(s1) donde s1 es STRING en memoria
                    emit("    PutStr " + d.nombre + "\n");
                }
                break;

            default:
                // Por si sale algo raro
                System.err.println("emitWrite: tipo no soportado: " + d.tipo);
                break;
        }
    }

    // Reemplazar la instrucción en una posición específica
    public void replaceAt(int index, String newInstr) {
        if (index >= 0 && index < mainCode.size()) {
            mainCode.set(index, newInstr);
        }
    }
    //--------------GENERAR LABELS------------//
    // Genera labels unicos con un numero que se va incrementando
    public String newLabel(String prefix) {
        labelCounter++;
        return prefix + "_" + labelCounter;
    }

    //-----------GENERAR VARIABLES TEMPORALES---------
    public String newTemp() {
        return "t" + (tempCounter++);
    }

    public void declararTemporal(String nombre, String tipo) {
        if (globalVars.containsKey(nombre)) return;
        globalVars.put(nombre, tipo);
    }

    public void emitLoad(Parser.DO d) {
        switch (d.clase) {
            case CONST:
                // constante inmediata
                if ("STRING".equals(d.tipo)) {
                    // para strings normalmente NO nos conviene push inmediato;
                    // aquí puedes decidir: error, o alguna convención.
                    System.err.println("emitLoad STRING CONST: manejar aparte");
                } else {
                    emit("    push " + d.valorConst + "\n");
                }
                break;

            case ADDR:
                // cargar desde memoria (var o temp)
                if ("STRING".equals(d.tipo)) {
                    System.err.println("emitLoad STRING ADDR: probablemente no quieres usar la pila");
                } else {
                    emit("    push dword [" + d.nombre + "]\n");
                }
                break;
        }
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

    public void emitCopyStringVar(String dest, String src) {
        String lblLoop = newLabel("copyStr_loop");
        String lblEnd  = newLabel("copyStr_end");

        mainCode.add("    mov esi, " + src);   // origen
        mainCode.add("    mov edi, " + dest);  // destino

        mainCode.add(lblLoop + ":");
        mainCode.add("    mov al, [esi]");     // cargar byte
        mainCode.add("    mov [edi], al");     // guardarlo
        mainCode.add("    cmp al, 0");         // fin de string?
        mainCode.add("    je " + lblEnd);
        mainCode.add("    inc esi");
        mainCode.add("    inc edi");
        mainCode.add("    jmp " + lblLoop);

        mainCode.add(lblEnd + ":");
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