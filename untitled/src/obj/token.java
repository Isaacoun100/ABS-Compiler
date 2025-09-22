package obj;

public class token {
    private String tokenName;
    private String value;
    private int line;

    public token(String tokenName, String value, int line) {
        this.tokenName = tokenName;
        this.value = value;
        this.line = line;
    }

    public String getTokenName() { return tokenName; }
    public String getValue() { return value; }
    public int getLine() { return line; }
}
