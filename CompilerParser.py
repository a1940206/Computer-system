from ParseTree import *

class CompilerParser:

    def __init__(self, tokens):
        self.tokens = tokens
        self.index = 0

    # ---------- Helper Methods ----------
    def next(self):
        if self.index < len(self.tokens) - 1:
            self.index += 1

    def current(self):
        if self.index < len(self.tokens):
            return self.tokens[self.index]
        return None

    def have(self, expectedType, expectedValue=None):
        tok = self.current()
        if tok is None:
            return False
        if expectedValue is None:
            return tok.getType() == expectedType
        return tok.getType() == expectedType and tok.getValue() == expectedValue

    def mustBe(self, expectedType, expectedValue=None):
        tok = self.current()
        if tok is None:
            raise ParseException("Unexpected EOF")
        if expectedValue is None:
            if tok.getType() != expectedType:
                raise ParseException(f"Expected {expectedType}, got {tok.getType()} {tok.getValue()}")
        else:
            if tok.getType() != expectedType or tok.getValue() != expectedValue:
                raise ParseException(f"Expected {expectedType} '{expectedValue}', got {tok.getType()} '{tok.getValue()}'")
        self.next()
        return tok

    # ---------- Program ----------
    def compileProgram(self):
        node = self.compileClass()
        # ✅ Allow end-of-file safely
        if self.current() is not None:
            if self.current().getValue() not in ("", None):
                raise ParseException("Extra tokens after end of program")
        return node

    def compileClass(self):
        node = ParseTree("class", "")
        node.addChild(self.mustBe("keyword", "class"))
        node.addChild(self.mustBe("identifier", None))
        node.addChild(self.mustBe("symbol", "{"))

        while self.have("keyword", "static") or self.have("keyword", "field"):
            node.addChild(self.compileClassVarDec())

        while self.have("keyword", "constructor") or self.have("keyword", "function") or self.have("keyword", "method"):
            node.addChild(self.compileSubroutine())

        node.addChild(self.mustBe("symbol", "}"))
        return node

    def compileClassVarDec(self):
        node = ParseTree("classVarDec", "")
        node.addChild(self.mustBe("keyword", None))
        node.addChild(self.mustBe("keyword", None))
        node.addChild(self.mustBe("identifier", None))
        while self.have("symbol", ","):
            node.addChild(self.mustBe("symbol", ","))
            node.addChild(self.mustBe("identifier", None))
        node.addChild(self.mustBe("symbol", ";"))
        return node

    def compileSubroutine(self):
        node = ParseTree("subroutine", "")
        node.addChild(self.mustBe("keyword", None))
        node.addChild(self.mustBe("keyword", None))
        node.addChild(self.mustBe("identifier", None))
        node.addChild(self.mustBe("symbol", "("))
        node.addChild(self.compileParameterList())
        node.addChild(self.mustBe("symbol", ")"))
        node.addChild(self.compileSubroutineBody())
        return node

    def compileParameterList(self):
        node = ParseTree("parameterList", "")
        if self.have("keyword", None):
            node.addChild(self.mustBe("keyword", None))
            node.addChild(self.mustBe("identifier", None))
            while self.have("symbol", ","):
                node.addChild(self.mustBe("symbol", ","))
                node.addChild(self.mustBe("keyword", None))
                node.addChild(self.mustBe("identifier", None))
        return node

    def compileSubroutineBody(self):
        node = ParseTree("subroutineBody", "")
        node.addChild(self.mustBe("symbol", "{"))
        while self.have("keyword", "var"):
            node.addChild(self.compileVarDec())
        node.addChild(self.compileStatements())
        node.addChild(self.mustBe("symbol", "}"))
        return node

    def compileVarDec(self):
        node = ParseTree("varDec", "")
        node.addChild(self.mustBe("keyword", "var"))
        node.addChild(self.mustBe("keyword", None))
        node.addChild(self.mustBe("identifier", None))
        while self.have("symbol", ","):
            node.addChild(self.mustBe("symbol", ","))
            node.addChild(self.mustBe("identifier", None))
        node.addChild(self.mustBe("symbol", ";"))
        return node

    # ---------- Statements ----------
    def compileStatements(self):
        node = ParseTree("statements", "")
        while self.have("keyword", None):
            kw = self.current().getValue()
            if kw == "let":
                node.addChild(self.compileLet())
            elif kw == "if":
                node.addChild(self.compileIf())
            elif kw == "while":
                node.addChild(self.compileWhile())
            elif kw == "do":
                node.addChild(self.compileDo())
            elif kw == "return":
                node.addChild(self.compileReturn())
            else:
                break
        return node

    def compileLet(self):
        node = ParseTree("letStatement", "")
        node.addChild(self.mustBe("keyword", "let"))
        node.addChild(self.mustBe("identifier", None))
        node.addChild(self.mustBe("symbol", "="))
        node.addChild(self.compileExpression())
        node.addChild(self.mustBe("symbol", ";"))
        return node

    def compileIf(self):
        node = ParseTree("ifStatement", "")
        node.addChild(self.mustBe("keyword", "if"))
        node.addChild(self.mustBe("symbol", "("))
        node.addChild(self.compileExpression())
        node.addChild(self.mustBe("symbol", ")"))
        node.addChild(self.mustBe("symbol", "{"))
        node.addChild(self.compileStatements())
        node.addChild(self.mustBe("symbol", "}"))
        if self.have("keyword", "else"):
            node.addChild(self.mustBe("keyword", "else"))
            node.addChild(self.mustBe("symbol", "{"))
            node.addChild(self.compileStatements())
            node.addChild(self.mustBe("symbol", "}"))
        return node

    def compileWhile(self):
        node = ParseTree("whileStatement", "")
        node.addChild(self.mustBe("keyword", "while"))
        node.addChild(self.mustBe("symbol", "("))
        node.addChild(self.compileExpression())
        node.addChild(self.mustBe("symbol", ")"))
        node.addChild(self.mustBe("symbol", "{"))
        node.addChild(self.compileStatements())
        node.addChild(self.mustBe("symbol", "}"))
        return node

    def compileDo(self):
        node = ParseTree("doStatement", "")
        node.addChild(self.mustBe("keyword", "do"))
        node.addChild(self.compileExpression())
        node.addChild(self.mustBe("symbol", ";"))
        return node

    def compileReturn(self):
        node = ParseTree("returnStatement", "")
        node.addChild(self.mustBe("keyword", "return"))
        if not self.have("symbol", ";"):
            node.addChild(self.compileExpression())
        node.addChild(self.mustBe("symbol", ";"))
        return node

    # ---------- Expressions ----------
    def compileExpression(self):
        node = ParseTree("expression", "")
        node.addChild(self.compileTerm())
        # ✅ 支持所有二元操作符 (+ - * / & | < > =)
        while self.have("symbol", "+") or self.have("symbol", "-") or \
              self.have("symbol", "*") or self.have("symbol", "/") or \
              self.have("symbol", "&") or self.have("symbol", "|") or \
              self.have("symbol", "<") or self.have("symbol", ">") or \
              self.have("symbol", "="):
            node.addChild(self.mustBe("symbol", None))
            node.addChild(self.compileTerm())
        return node

    def compileTerm(self):
        node = ParseTree("term", "")
        # ✅ 支持 skip, integerConstant, identifier, (expression)
        if self.have("keyword", "skip"):
            node.addChild(self.mustBe("keyword", "skip"))
        elif self.have("integerConstant", None):
            node.addChild(self.mustBe("integerConstant", None))
        elif self.have("identifier", None):
            node.addChild(self.mustBe("identifier", None))
        elif self.have("symbol", "("):
            node.addChild(self.mustBe("symbol", "("))
            node.addChild(self.compileExpression())
            node.addChild(self.mustBe("symbol", ")"))
        else:
            raise ParseException("Invalid term in expression")
        return node

    def compileExpressionList(self):
        node = ParseTree("expressionList", "")
        if not self.have("symbol", ")"):
            node.addChild(self.compileExpression())
            while self.have("symbol", ","):
                node.addChild(self.mustBe("symbol", ","))
                node.addChild(self.compileExpression())
        return node


# ---------- Test ----------
if __name__ == "__main__":
    tokens = [
        Token("keyword", "class"),
        Token("identifier", "Main"),
        Token("symbol", "{"),
        Token("symbol", "}"),
    ]
    parser = CompilerParser(tokens)
    try:
        result = parser.compileProgram()
        print(result)
    except ParseException as e:
        print("Error Parsing:", e)


