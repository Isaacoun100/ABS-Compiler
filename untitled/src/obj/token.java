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

    @Override
    public String toString() {
        return "token{name='" + tokenName + "', value='" + value + "', line=" + line + "}";
    }
}
