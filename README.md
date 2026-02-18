# ASCII Square in Assembly

A simple x86-64 assembly program that draws an ASCII square using terminal escape sequences.

## How it Works

Uses ANSI escape codes to position the cursor and draw '#' characters forming a 20x10 square. Includes a small delay between draws for visual effect.

## Build & Run

```bash
nasm -f elf64 cube.asm -o cube.o
ld cube.o -o cube
./cube
```

## Requirements:

- **_Linux (x86-64)_**
- **_NASM assembler_**
- **_Terminal with ANSI support_**
