# Interpreter 設計模式的介紹

Interpreter 設計模式（解釋器模式）是一種行為型設計模式，它定義了一種簡單語言的文法表示，並提供了一個解釋器來解釋語言中的句子。這種模式特別適合用於處理簡單的語言或表達式，例如 SQL 查詢語言、規則引擎或數學表達式求值，讓您可以將語言的文法轉換為抽象語法樹（AST），然後透過遞迴方式解釋執行。

它最早在 1994 年的經典著作《Design Patterns: Elements of Reusable Object-Oriented Software》（通稱「四人組」或 GoF 書籍）中被描述。

## 目的與動機

使用 Interpreter 模式的的核心動機是將語言的文法規則封裝成物件階層，讓解釋器可以處理複雜的表達式，而無需在程式碼中硬編碼所有規則。這有助於擴展語言支援或修改文法。例如，在一個計算器應用中，您可以定義加減乘除的文法，並動態解釋使用者輸入的表達式如 "1 + 2 * 3"，而無需為每個可能組合寫專用程式碼。

主要優點包括：
- **易於擴展**：新增文法規則只需新增 Expression 類別。
- **解釋簡單**：透過遞迴解釋抽象語法樹，處理複雜表達式。
- **分離關注**：文法定義與解釋邏輯分離。

## 結構

Interpreter 模式涉及五個主要組件：

| 組件                        | 描述                                                 |
|---------------------------|----------------------------------------------------|
| **AbstractExpression**    | 抽象表達式介面，定義 `interpret(Context)` 方法來解釋表達式。          |
| **TerminalExpression**    | 終端表達式，處理語言的基本元素（例如變數或常數），實作 `interpret()`。         |
| **NonterminalExpression** | 非終端表達式，處理語言的複合規則（如二元運算），包含子表達式並遞迴呼叫 `interpret()`。 |
| **Context**               | 環境類別，儲存全局資訊（如變數值），供表達式在解釋時使用。                      |
| **Client**                | 客戶端，解析輸入句子並建構抽象語法樹，然後呼叫 `interpret()`。             |

互動流程：
1. 客戶端解析輸入（例如 "1 + 2"）並建構 Expression 樹。
2. 呼叫根節點的 `interpret(context)`。
3. 非終端節點遞迴呼叫子節點的 `interpret()`，終端節點直接計算。
4. Context 提供必要資料，回傳結果。

### Java 範例

以下是簡單的數學表達式解釋器範例，支援加法（+）和乘法（*），輸入如 "1 + 2 * 3" 會被解析為抽象語法樹並求值：

```java
import java.util.*;

// Context 類別
class Context {
    private Map<String, Double> variables = new HashMap<>();

    public void setVariable(String name, double value) {
        variables.put(name, value);
    }

    public double getVariable(String name) {
        return variables.getOrDefault(name, 0.0);
    }
}

// AbstractExpression 介面
interface Expression {
    double interpret(Context context);
}

// TerminalExpression（數字）
class NumberExpression implements Expression {
    private double value;

    public NumberExpression(double value) {
        this.value = value;
    }

    @Override
    public double interpret(Context context) {
        return value;
    }
}

// NonterminalExpression（加法）
class AddExpression implements Expression {
    private Expression left;
    private Expression right;

    public AddExpression(Expression left, Expression right) {
        this.left = left;
        this.right = right;
    }

    @Override
    public double interpret(Context context) {
        return left.interpret(context) + right.interpret(context);
    }
}

// NonterminalExpression（乘法）
class MultiplyExpression implements Expression {
    private Expression left;
    private Expression right;

    public MultiplyExpression(Expression left, Expression right) {
        this.left = left;
        this.right = right;
    }

    @Override
    public double interpret(Context context) {
        return left.interpret(context) * right.interpret(context);
    }
}

// 簡單的解析器（用於建構 Expression 樹）
class ExpressionParser {
    private String[] tokens;
    private int pos = 0;

    public ExpressionParser(String expression) {
        this.tokens = expression.replace(" ", "").split("(?<=[-+*/])|(?=[-+*/])");  // 簡單分詞
    }

    public Expression parse() {
        Expression left = parseTerm();
        while (pos < tokens.length && tokens[pos].equals("+")) {
            pos++;  // 跳過 +
            Expression right = parseTerm();
            left = new AddExpression(left, right);
        }
        return left;
    }

    private Expression parseTerm() {
        Expression left = parseFactor();
        while (pos < tokens.length && tokens[pos].equals("*")) {
            pos++;  // 跳過 *
            Expression right = parseFactor();
            left = new MultiplyExpression(left, right);
        }
        return left;
    }

    private Expression parseFactor() {
        String token = tokens[pos++];
        if (token.matches("\\d+")) {
            return new NumberExpression(Double.parseDouble(token));
        }
        // 可以擴展支援變數，如 return new VariableExpression(token);
        throw new RuntimeException("Invalid token: " + token);
    }
}

// 使用範例
public class InterpreterDemo {
    public static void main(String[] args) {
        Context context = new Context();
        context.setVariable("x", 5);  // 可選，範例中未使用變數

        String expressionStr = "1 + 2 * 3";
        ExpressionParser parser = new ExpressionParser(expressionStr);
        Expression expression = parser.parse();

        double result = expression.interpret(context);
        System.out.println("Result of '" + expressionStr + "': " + result);  // 輸出: Result of '1 + 2 * 3': 7.0
    }
}
```

此範例使用簡單的遞迴下降解析器建構 Expression 樹，然後解釋求值。注意：實際應用中，解析器可能更複雜（如使用 ANTLR）。

## 優點與缺點

| 優點                   | 缺點                         |
|----------------------|----------------------------|
| 易於新增文法規則和擴展語言。       | 對於複雜語言，抽象語法樹可能導致類別爆炸和效能問題。 |
| 透過遞迴解釋簡單表達式。         | 解析輸入的邏輯可能複雜，需要額外的解析器。      |
| 適合規則引擎或 DSL（領域特定語言）。 | 不適合非常複雜的語言（建議使用解析器生成器）。    |

## 何時使用
- 當需要解釋簡單語言的句子或表達式，且文法規則不會太複雜時。
- 適用於 SQL 解析、規則引擎、計算器或 XML 處理等情境。
- 避免在大型語言中使用；改用工具如 JavaCC 或 ANTLR 生成解釋器。
