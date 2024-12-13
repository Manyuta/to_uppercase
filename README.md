This program converts lowercase input from stdin to uppercase output in stdout, written in assembly x86 32 bits.

### Building the Project

1. Assemble the source code:
  ```bash
  as --32 program.s -o program.o
  as --32 convert_to_upper.s -o convert_to_upper.s
  ```
2. Link the object file
  ```bash
  ld -m elf_i386 -o program program.o convert_to_upper.o
  ```
3. Run the executable
  ```bash 
  ./program
  ```

### Example usage 
#### Imput:
```bash
hello world 
```

#### Output:
```bash
HELLO WORLD
```