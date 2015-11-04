#!/usr/bin/env python
#
# Template for MIPS assembler.py
#
# Usage:
#    python assembler_template.py [asm file]

import sys, re

def bin_to_hex(x):
  y = hex(int(x,2))[2:]
  # get rid of the 'L' that sometimes appears
  if y[-1] == 'L':
    y = y[:-1]
  if len(y) < 8:
    y = (8-len(y))*"0" + y
  return y

def dec_to_bin(value, nbits):
  value = int(value)
  fill = "0"
  if value < 0:
    value = (abs(value) ^ 0xffffffff) + 1
    fill = "1"

  value = bin(value)[2:]
  if len(value) < nbits:
    value = (nbits-len(value))*fill + value
  if len(value) > nbits:
    value = value[-nbits:]
  return value

rtypes = [
  # List of all R-type instructions.
  'add',
  'sub',
  'and',
  'or',
  'xor',
  'nor',
  'sll',
  'sra',
  'srl',
  'slt',
  'jr'
]

op_codes = {
  # Fill in mapping from instruction to its opcode.
  'add':  '000000',
  'sub':  '000000',
  'and':  '000000',
  'or':   '000000',
  'xor':  '000000',
  'nor':  '000000',
  'sll':  '000000',
  'sra':  '000000',
  'srl':  '000000',
  'slt':  '000000',
  'jr':   '000000',
  'j':    '000010',
  'jal':  '000011',
  'beq':  '000100',
  'bne':  '000101',
  'addi': '001000',
  'slti': '001010',
  'andi': '001100',
  'ori':  '001101',
  'xori': '001110',
  'lw':   '100011',
  'sw':   '101011',
  'nop':  '000000'
}

function_codes = {
  # Fill in function codes.
  'add':  '100000',
  'sub':  '100010',
  'and':  '100100',
  'or':   '100101',
  'xor':  '100110',
  'nor':  '100111',
  'sll':  '000000',
  'sra':  '000011',
  'srl':  '000010',
  'slt':  '101010',
  'jr':   '001000',
  'nop':  '000000'
}

registers = {
  '$zero' : dec_to_bin(00, 5),
  # Fill out the rest of the registers.
  '$at'   : dec_to_bin(01, 5),
  '$v0'   : dec_to_bin(02, 5),
  '$v1'   : dec_to_bin(03, 5),
  '$a0'   : dec_to_bin(04, 5),
  '$a1'   : dec_to_bin(05, 5),
  '$a2'   : dec_to_bin(06, 5),
  '$a3'   : dec_to_bin(07, 5),
  '$t0'   : dec_to_bin(8, 5),
  '$t1'   : dec_to_bin(9, 5),
  '$t2'   : dec_to_bin(10, 5),
  '$t3'   : dec_to_bin(11, 5),
  '$t4'   : dec_to_bin(12, 5),
  '$t5'   : dec_to_bin(13, 5),
  '$t6'   : dec_to_bin(14, 5),
  '$t7'   : dec_to_bin(15, 5),
  '$s0'   : dec_to_bin(16, 5),
  '$s1'   : dec_to_bin(17, 5),
  '$s2'   : dec_to_bin(18, 5),
  '$s3'   : dec_to_bin(19, 5),
  '$s4'   : dec_to_bin(20, 5),
  '$s5'   : dec_to_bin(21, 5),
  '$s6'   : dec_to_bin(22, 5),
  '$s7'   : dec_to_bin(23, 5),
  '$t8'   : dec_to_bin(24, 5),
  '$t9'   : dec_to_bin(25, 5),
  '$k0'   : dec_to_bin(26, 5),
  '$k1'   : dec_to_bin(27, 5),
  '$gp'   : dec_to_bin(28, 5),
  '$sp'   : dec_to_bin(29, 5),
  '$fp'   : dec_to_bin(30, 5),
  '$ra'   : dec_to_bin(31, 5),
}

def conv_reg(reg_name):
  if ((reg_name[1]=='r') and (reg_name != '$ra')):
    return dec_to_bin(reg_name[2:], 5)
  else:
    return registers[reg_name]

def get_addr_26(address):
  starting_addr = 0x00400000
  # get rid of the two LSB to obtain pseudo direct addr
  pseuso_direct_addr = (starting_addr + address)/4
  return dec_to_bin(pseuso_direct_addr, 26)

def get_relative_addr_16(address, branch_address):
  # get the relative address to the branch
  relative_addr = (branch_address - address)/4
  return dec_to_bin(relative_addr, 16)

def main():
  me, fname = sys.argv

  f = open(fname, "r")
  labels = {}        # Map from label to its address.
  parsed_lines = []  # List of parsed instructions.
  address = 0        # Track the current address of the instruction.
  line_count = 0     # Number of lines.
  for line in f:
    line_count = line_count + 1

    # Stores attributes about the current line of code, like its label, line
    # number, instruction, and arguments.
    line_attr = {}
    line_attr['addr'] = address

    # Handle comments, whitespace.
    line = line.split('#')[0].replace(',',' ').split()

    if line:
      # We'll get you started here with line_count.
      line_attr['line_number'] = line_count

      # Handle labels
      if ':' in line[0]:
        line_attr['label'] = line[0][:-1]
        labels[line[0][:-1]] = address
        line = line[1:]
      # Parse the rest of the instruction and its register arguments.
      if line[0] == 'nop':
        line_attr['opcode'] = line[0]
      elif line[0] in rtypes:
        line_attr['opcode'] = line[0]
        line_attr['shamt'] = dec_to_bin(0, 5)
        if line[0] in ['sll','sra','srl']:
          line_attr['shamt'] = dec_to_bin(line[3], 5)
          line_attr['rs'] = dec_to_bin(0, 5)
          line_attr['rt'] = conv_reg(line[2])
          line_attr['rd'] = conv_reg(line[1])
        elif line[0] == 'jr':
          line_attr['rs'] = conv_reg(line[1])
          line_attr['rd'] = dec_to_bin(0, 5)
          line_attr['rt'] = dec_to_bin(0, 5)
        else:
          line_attr['rs'] = conv_reg(line[2])
          line_attr['rt'] = conv_reg(line[3])
          line_attr['rd'] = conv_reg(line[1])
        line_attr['funct'] = function_codes[line[0]]
      elif line[0] == 'j' or line[0] == 'jal':
        line_attr['opcode'] = line[0]
        line_attr['obj_addr'] = line[1] # get_addr_26(labels[line[1]])
      else:
        line_attr['opcode'] = line[0]
        line_attr['rt'] = conv_reg(line[1])
        if '(' in line[2]:
          line_attr['immi'] = dec_to_bin(line[2].split('(')[0], 16)
          line_attr['rs'] = conv_reg(line[2].split('(')[1][:-1])
        elif ((line[0] != 'beq') and (line[0] != 'bne')) :
          line_attr['rs'] = conv_reg(line[2])
          line_attr['immi'] = dec_to_bin(line[3], 16)
        else:
          line_attr['rt'] = conv_reg(line[2])
          line_attr['rs'] = conv_reg(line[1])
          line_attr['immi'] = line[3] # get_relative_addr_16(address+4, labels[line[3]])

      # increment the address
      address += 4

      # Finally, add this dict to the complete list of instructions.
      parsed_lines.append(line_attr)
  f.close()

  machine = ""  # Current machine code word.

  for line in parsed_lines:
    # process the addresses
    if line['opcode'] in  ['bne', 'beq']:
      line['immi'] = get_relative_addr_16(line['addr'] + 4, labels[line['immi']])
    if line['opcode'] in ['j', 'jal']:
      line['obj_addr'] = get_addr_26(labels[line['obj_addr']])

    if line['opcode'] == 'nop':
      print 8*'0'
    elif line['opcode'] in rtypes:
      # Encode an R-type instruction.
      bin_instruction = op_codes[line['opcode']] + line['rs'] + line['rt'] + \
        line['rd'] + line['shamt'] + line['funct']
      print bin_to_hex(bin_instruction)
    else:
      # Encode a non-R-type instruction.
      # Hint: the function_codes map will be useful here.

      if line['opcode'] == 'j' or line['opcode'] == 'jal':
        bin_instruction = op_codes[line['opcode']] + line['obj_addr']
        print bin_to_hex(bin_instruction)
      else:
        bin_instruction = op_codes[line['opcode']] + line['rs'] + line['rt'] + line['immi']
        print bin_to_hex(bin_instruction)

      # Finish handling the rest of the instructions (load/store, other jumps).

if __name__ == "__main__":
  main()
