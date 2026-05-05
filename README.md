```
lex file.l
gcc lex.yy.c -o file -ll
./file
```
```
yacc -d file-name.y
lex file-name.l
gcc y.tab.c lex.yy.c -o file-name -lm -ll
./file-name
```
