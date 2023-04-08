all: build 

build: main.l main.y
	bison -t -d main.y
	flex main.l
	cc lex.yy.c main.tab.c -lfl -g 
	./a.out < stream.txt 


build_with_debug: main.l main.y 
	bison -t -d main.y
	flex --debug main.l
	cc lex.yy.c main.tab.c -lfl -g 
	./a.out < stream.txt 

clean:
	rm lex.yy.c main.tab.c main.tab.h a.out
