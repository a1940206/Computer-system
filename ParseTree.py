class ParseException(Exception):
    """
    Raised when tokens provided don't match the expected grammar
    Use this with `raise ParseException("My error message")`
    """
    pass


class ParseTree:
    """
    A node in a Parse Tree data structure
    """

    def __init__(self, node_type, value):
        """
        A node in a Parse Tree data structure
        @param node_type The type of node (see element types).
        @param value The node's value. Should only be used on terminal nodes/leaves, and empty otherwise.
        """
        self.node_type = node_type
        self.value = value
        self.children = []

    def addChild(self, child):
        """
        Adds a ParseTree as a child of this ParseTree
        @param child The ParseTree to add
        """
        self.children.append(child)

    def getChildren(self):
        """
        Get a list of child nodes in the order they were added.
        @return A list of ParseTrees
        """
        return self.children

    def getType(self):
        """
        Get the type of this ParseTree Node
        @return The type of node (see element types).
        """
        return self.node_type

    def getValue(self):
        """
        Get the value of this ParseTree Node
        @return The node's value. Should only be used on terminal nodes/leaves, and empty otherwise.
        """
        return self.value

    def __str__(self, depth=0):
        """
        Generate a string from this ParseTree
        @return A printable representation of this ParseTree with indentation
        """
        indent = ""
        for _ in range(depth):
            indent += "  │ "

        output = ""
        if len(self.children) > 0:
            # Non-terminal node
            output += f"{self.node_type}\n"
            for i, child in enumerate(self.children):
                branch = "  └ " if i == len(self.children) - 1 else "  │ "
                output += indent + branch + child.__str__(depth + 1)
        else:
            # Leaf node (terminal)
            output += f"{self.node_type} {self.value}\n"

        return output


class Token(ParseTree):
    """
    Token for parsing. Can be used as a terminal node in a ParseTree
    """
    pass


# ✅ Simple test
if __name__ == "__main__":
    root = ParseTree("class", "")
    root.addChild(Token("keyword", "class"))
    root.addChild(Token("identifier", "Main"))
    body = ParseTree("subroutine", "")
    body.addChild(Token("keyword", "function"))
    body.addChild(Token("identifier", "doSomething"))
    root.addChild(body)
    print(root)
