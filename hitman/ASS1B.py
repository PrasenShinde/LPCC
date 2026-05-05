# -------- Sample Tables (from Pass 1) --------

# Symbol Table (Symbol → Address)
symtab = {
    "LOOP": 200,
    "RESULT": 205
}

# Literal Table (Literal → Address)
littab = {
    "='5'": 300,
    "='1'": 301
}

# Pool Table (just for reference, not heavily used in IC generation)
pooltab = [0]

# -------- Opcode Table --------
# (Instruction → (Type, Code))

optab = {
    "START": ("AD", 1),
    "END": ("AD", 2),
    "LTORG": ("AD", 3),

    "MOVER": ("IS", 4),
    "MOVEM": ("IS", 5),
    "ADD": ("IS", 1),
    "SUB": ("IS", 2),
    "MULT": ("IS", 3)
}

# Register Table
regtab = {
    "AREG": 1,
    "BREG": 2,
    "CREG": 3
}

# -------- Input Assembly Code --------
code = [
    "START 100",
    "MOVER AREG, ='5'",
    "ADD BREG, ='1'",
    "LOOP SUB AREG, ='1'",
    "MOVEM AREG, RESULT",
    "END"
]

# -------- Generate Intermediate Code --------

print("\nIntermediate Code:\n")

for line in code:
    parts = line.replace(",", "").split()

    # Handle label (like LOOP)
    if parts[0] not in optab:
        parts.pop(0)  # remove label

    inst = parts[0]

    # -------- Assembler Directives --------
    if inst in ["START", "END", "LTORG"]:
        typ, code_no = optab[inst]

        if len(parts) > 1:
            print(f"({typ},{code_no}) (C,{parts[1]})")
        else:
            print(f"({typ},{code_no})")

    # -------- Imperative Statements --------
    else:
        typ, code_no = optab[inst]

        reg = ""
        operand = ""

        # Register
        if len(parts) > 1 and parts[1] in regtab:
            reg = f"({regtab[parts[1]]})"

        # Operand (Symbol / Literal)
        if len(parts) > 2:
            op = parts[2]

            if op in symtab:
                # Get index of symbol
                index = list(symtab.keys()).index(op) + 1
                operand = f"(S,{index})"

            elif op in littab:
                # Get index of literal
                index = list(littab.keys()).index(op) + 1
                operand = f"(L,{index})"

            else:
                operand = f"(C,{op})"

        print(f"({typ},{code_no}) {reg} {operand}")