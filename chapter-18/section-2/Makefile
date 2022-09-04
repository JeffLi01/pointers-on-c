# $* 不包含扩展名的目标文件名称。
# $+ 所有的依赖文件，以空格分开，并以出现的先后为序，可能包含重复的依赖文件。
# $< 第一个依赖文件的名称。
# $? 所有的依赖文件，以空格分开，这些依赖文件的修改日期比目标的创建日期晚。
# $@ 目标的完整名称。
# $^ 所有的依赖文件，以空格分开，不包含重复的依赖文件。
# $% 如果目标是归档成员，则该变量表示目标的归档成员名称。

all: demo assemble

demo: main.o sum1.o sum2.o
	gcc -O0 -o $@ $?

assemble: main.s sum1.s sum2.s main.S sum1.S sum2.S

.s.o:
	gcc -o $@ -c $<

.c.s:
	gcc -S $<

.c.S:
	gcc -c -g -Wa,-adlhn $< > $@

clean:
	rm -f *.s *.o demo main *.S
