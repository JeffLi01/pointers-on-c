all: array-traverse

array-traverse: array-traverse.o

.c.o:
	gcc -c -o $@ $<

clean:
	rm -f *.s *.o array-traverse array-traverse.log
