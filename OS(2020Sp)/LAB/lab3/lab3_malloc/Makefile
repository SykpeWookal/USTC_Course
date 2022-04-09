#Students' Makefile for the Malloc Lab
#

CC = gcc -g
CFLAGS = -Wall

.c.o:
	@$(CC) $(CFLAGS) -c -o $*.o $<

# 待补充
OBJS1 = memlib.o mm.o mmdriver.o
OBJS2 = memlib.o ep_mm.o mmdriver.o

all:mmdriver epmmdriver

mmdriver: $(OBJS1)
	$(CC) $(CFLAGS) -o $@ $(OBJS1)

epmmdriver:$(OBJS2)
	$(CC) $(CFLAGS) -o $@ $(OBJS2)


#待补充
mmdriver.o: mmdriver.c mm.h memlib.h
memlib.o: memlib.c memlib.h config.h
mm.o: mm.c mm.h memlib.h
ep_mm.o: ep_mm.c mm.h memlib.h

clean:
	rm -f *~ *.o mmdrive epmmdriver


