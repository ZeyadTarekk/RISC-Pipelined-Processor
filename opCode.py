import os


def DecimalToBinary(num):
    return "{0:b}".format(int(num))


def addressRegsiter(word):
    if word == "R0":
        return "0000"
    elif word == "R1":
        return "0001"
    elif word == "R2":
        return "0010"
    elif word == "R3":
        return "0011"
    elif word == "R4":
        return "0100"
    elif word == "R5":
        return "0101"
    elif word == "R6":
        return "0110"
    elif word == "R7":
        return "0111"
    elif word == "PORT":
        return "1000"


f = open("input.txt", "r")
# content = f.read()
if os.path.exists("Final Phase 2/instr.txt"):
    os.remove("Final Phase 2/instr.txt")
f2 = open("Final Phase 2/instr.txt", "a")

for x in f:
    opCode = ""
    instructionParts = x.split(" ")

    if instructionParts[0] == "NOP":
        print("NOP")
        opCode = "0000000000000000"
        f2.write(opCode)
        f2.write("\n")
    elif instructionParts[0] == "SETC":
        opCode = "0000100000000000"
        f2.write(opCode)
        f2.write("\n")
    elif instructionParts[0] == "CLRC":
        print("CLRC")
        opCode = "0001100000000000"
        f2.write(opCode)
        f2.write("\n")
    elif instructionParts[0] == "NOT":
        print("NOT")
        opCode = "00011"
        opCode = opCode + \
            addressRegsiter(instructionParts[1]) + \
            addressRegsiter(instructionParts[1])
        opCode = opCode + "000"
        f2.write(opCode)
        f2.write("\n")
    elif instructionParts[0] == "INC":
        print("INC")
        opCode = "00100"
        opCode = opCode + \
            addressRegsiter(instructionParts[1]) + \
            addressRegsiter(instructionParts[1])
        opCode = opCode + "000"
        f2.write(opCode)
        f2.write("\n")
    elif instructionParts[0] == "DEC":
        print("DEC")
        opCode = "00101"
        opCode = opCode + \
            addressRegsiter(instructionParts[1]) + \
            addressRegsiter(instructionParts[1])
        opCode = opCode + "000"
        f2.write(opCode)
        f2.write("\n")
    elif instructionParts[0] == "OUT":
        print("OUT")
        opCode = "00110"
        opCode = opCode + \
            addressRegsiter(instructionParts[1]) + addressRegsiter("PORT")
        opCode = opCode + "000"
        f2.write(opCode)
        f2.write("\n")
    elif instructionParts[0] == "IN":
        print("IN")
        opCode = "00111"
        opCode = opCode + \
            addressRegsiter("PORT") + addressRegsiter(instructionParts[1])
        opCode = opCode + "000"
        f2.write(opCode)
        f2.write("\n")
    elif instructionParts[0] == "MOV":
        print("MOV")
        opCode = "01000"
        registers = instructionParts[1].split(",")
        opCode = opCode + \
            addressRegsiter(registers[0]) + addressRegsiter(registers[1])
        opCode = opCode + "000"
        f2.write(opCode)
        f2.write("\n")
    elif instructionParts[0] == "ADD":
        print("ADD")
        opCode = "01001"
        registers = instructionParts[1].split(",")
        opCode = opCode + \
            addressRegsiter(registers[0]) + addressRegsiter(registers[1])
        opCode = opCode + "000"
        f2.write(opCode)
        f2.write("\n")
    elif instructionParts[0] == "SUB":
        print("SUB")
        opCode = "01010"
        registers = instructionParts[1].split(",")
        opCode = opCode + \
            addressRegsiter(registers[0]) + addressRegsiter(registers[1])
        opCode = opCode + "000"
        f2.write(opCode)
        f2.write("\n")
    elif instructionParts[0] == "AND":
        print("AND")
        opCode = "01011"
        registers = instructionParts[1].split(",")
        opCode = opCode + \
            addressRegsiter(registers[0]) + addressRegsiter(registers[1])
        opCode = opCode + "000"
        f2.write(opCode)
        f2.write("\n")
    elif instructionParts[0] == "OR":
        print("OR")
        opCode = "01100"
        registers = instructionParts[1].split(",")
        opCode = opCode + \
            addressRegsiter(registers[0]) + addressRegsiter(registers[1])
        opCode = opCode + "000"
        f2.write(opCode)
        f2.write("\n")
    elif instructionParts[0] == "SHL":
        print("SHL")
        opCode = "01100"
        registers = instructionParts[1].split(",")
        opCode = opCode + \
            addressRegsiter(registers[0]) + addressRegsiter(registers[0])
        opCode = opCode + "100"
        binaryNumber = str(DecimalToBinary(int(registers[1]))).zfill(16)
        f2.write(opCode)
        f2.write("\n")
        f2.write(binaryNumber)
        f2.write("\n")
    elif instructionParts[0] == "SHR":
        print("SHR")
        opCode = "01110"
        registers = instructionParts[1].split(",")
        opCode = opCode + \
            addressRegsiter(registers[0]) + addressRegsiter(registers[0])
        opCode = opCode + "100"
        binaryNumber = str(DecimalToBinary(int(registers[1]))).zfill(16)
        f2.write(opCode)
        f2.write("\n")
        f2.write(binaryNumber)
        f2.write("\n")
    elif instructionParts[0] == "PUSH":
        print("PUSH")
        opCode = "01111"
        opCode = opCode + addressRegsiter(instructionParts[1])
        opCode = opCode + "0000000"
        f2.write(opCode)
        f2.write("\n")
    elif instructionParts[0] == "POP":
        print("POP")
        opCode = "10000"
        opCode = opCode + "0000"
        opCode = opCode + addressRegsiter(instructionParts[1])
        opCode = opCode + "000"
        f2.write(opCode)
        f2.write("\n")
    elif instructionParts[0] == "LDM":
        print("LDM")
        opCode = "10001"
        opCode = opCode + "0000"
        registers = instructionParts[1].split(",")
        opCode = opCode + addressRegsiter(registers[0])
        opCode = opCode + "100"
        binaryNumber = str(DecimalToBinary(int(registers[1]))).zfill(16)
        f2.write(opCode)
        f2.write("\n")
        f2.write(binaryNumber)
        f2.write("\n")
    elif instructionParts[0] == "LDD":
        print("LDD")
        opCode = "10010"
        registers = instructionParts[1].split(",")
        opCode = opCode + \
            addressRegsiter(registers[0]) + addressRegsiter(registers[1])
        opCode = opCode + "000"
        f2.write(opCode)
        f2.write("\n")
    elif instructionParts[0] == "STD":
        print("STD")
        opCode = "10011"
        registers = instructionParts[1].split(",")
        opCode = opCode + \
            addressRegsiter(registers[0]) + addressRegsiter(registers[1])
        opCode = opCode + "000"
        f2.write(opCode)
        f2.write("\n")
    elif instructionParts[0] == "JZ":
        print("JZ")
        opCode = "10100"
        opCode = opCode + "0000" + addressRegsiter(instructionParts[1])
        opCode = opCode + "000"
        f2.write(opCode)
        f2.write("\n")
    elif instructionParts[0] == "JN":
        print("JN")
        opCode = "10101"
        opCode = opCode + "0000" + addressRegsiter(instructionParts[1])
        opCode = opCode + "001"
        f2.write(opCode)
        f2.write("\n")
    elif instructionParts[0] == "JC":
        print("JC")
        opCode = "10110"
        opCode = opCode + "0000" + addressRegsiter(instructionParts[1])
        opCode = opCode + "010"
        f2.write(opCode)
        f2.write("\n")
    elif instructionParts[0] == "JMP":
        print("JMP")
        opCode = "10111"
        opCode = opCode + "0000" + addressRegsiter(instructionParts[1])
        opCode = opCode + "011"
        f2.write(opCode)
        f2.write("\n")
    elif instructionParts[0] == "CALL":
        print("CALL")
        opCode = "11000"
        opCode = opCode + "1001" + addressRegsiter(instructionParts[1])
        opCode = opCode + "000"
        opCode2 = "11001" + "1010" + \
            addressRegsiter(instructionParts[1]) + "011"
        f2.write(opCode)
        f2.write("\n")
        f2.write(opCode2)
        f2.write("\n")
    elif instructionParts[0] == "RET":
        print("RET")
        opCode = "11010"
        opCode = opCode + "0000" + "1010" + "000"
        opCode2 = "11011" + "0000" + "1001" + "011"
        f2.write(opCode)
        f2.write("\n")
        f2.write(opCode2)
        f2.write("\n")
    elif instructionParts[0] == "RTI":
        print("RTI")
        opCode = "11100"
        opCode = opCode + "0000" + "1010" + "000"
        opCode2 = "11101" + "0000" + "1001" + "011"
        f2.write(opCode)
        f2.write("\n")
        f2.write(opCode2)
        f2.write("\n")

f.close()
f2.close()
