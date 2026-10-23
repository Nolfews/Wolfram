# Wolfram Cellular Automaton

A Haskell implementation of a one-dimensional cellular automaton based on Stephen Wolfram's elementary cellular automata. The project generates and displays successive generations of cells in the terminal according to a rule numbered from 0 to 255.

The repository contains two versions:

- `wolframFolder/`: the main cellular automaton implementation.
- `bonus/wolframFolder/`: the bonus implementation, which converts a BMP image into ASCII art and adapts it to the terminal size.

## Requirements

- GHC and Stack
- A terminal capable of displaying text output
- A BMP image file for the bonus program

## Main project

The main program accepts the following options:

| Option | Description | Default |
| --- | --- | --- |
| `--rule n` | Cellular automaton rule, from 0 to 255 | `30` |
| `--start n` | Generation at which display starts | `0` |
| `--lines n` | Number of generations to display | Unlimited |
| `--window n` | Number of cells displayed on each line | `80` |
| `--move n` | Horizontal translation applied to the display window | `0` |

### Build and run

From the repository root:

```bash
make
./wolfram --rule 30 --lines 20
```

The `make` target builds the project with Stack and copies the executable to the repository root. You can also run the program directly through Stack:

```bash
stack build
stack exec wolfram -- --rule 90 --start 10 --lines 30 --window 100
```

The program requires at least one argument. For example, to display rule 110 with a shifted window:

```bash
./wolfram --rule 110 --lines 25 --window 80 --move 5
```

### Tests and cleanup

```bash
make test
make clean
make fclean
```

`make clean` removes Stack build artifacts. `make fclean` also removes the copied `wolfram` executable.

## Bonus: BMP to ASCII art

The bonus program reads a 24-bit BMP image, converts its pixels to grayscale, maps the grayscale values to ASCII characters, and resizes the result according to the current terminal dimensions.

The bonus executable asks for the path to a BMP file through standard input.

### Build and run the bonus

From the `bonus/` directory:

```bash
make
make install
./wolfram
```

When prompted, enter the path to a BMP image, for example:

```text
assets/image.bmp
```

You can also run it directly with Stack from the repository root:

```bash
stack exec --stack-yaml bonus/wolframFolder/stack.yaml wolfram
```

The bonus uses `ansi-terminal` to clear and update the terminal and `terminal-size` to adapt the output to the available screen size.

### Bonus tests and cleanup

From the `bonus/` directory:

```bash
make test
make clean
```
