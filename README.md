# ANAA
## G21 C++ Compiler
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ <br/>
This repository contains the course work for CS335A of group 21 (Compiler Name :- ANAA).

Source :- C++ 14. <br/>
Implementation :- C++ 14. <br/>
Target :- x86. <br/>

### How to run parser :
```bash
cd src
make
cd ..
./bin/final ./tests/Test_number.cpp (Enter number to excecute)
```
### How to view DOT
```bash
dot -Tpdf graph.dot -o graph.pdf
make clean
```

### How to clean (To remove binary file from bin)
```bash
cd src
make clean
```

### Features Implemented:
1. Native Data types( integer, floating point, character, void)
2. Variables( Gloabal and Local scope supported ) and Expressions 
3. All types of arithmetic operations supported
4. Control structure(Conditional statements, Loops)
5. User defined types(struct, class)
6. Recursive functions supported
7. Pointers


### Group Members:<br /> 
1. Akash Kumar Bhoi (190082)<br />
2. Ankit Shinde (190802)<br />
3. Naveen Kumar Mathur (190535)<br />
4. Aryan Kumar (190185)