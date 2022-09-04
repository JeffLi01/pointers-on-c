all: crt-test.s crt-test.o

.c.o:
	gcc -c -o $@ -O0 $<

.c.s:
	gcc -S -O0 $<

clean:
	rm -f *.s
