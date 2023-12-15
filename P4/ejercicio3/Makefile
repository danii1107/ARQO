CC = gcc
LIBS = -lgomp -lm
LIB_DIR =  
FLAGS = -g -Wall -D_GNU_SOURCE -fopenmp

.PHONY: clean all

all: mult mult_para clear

mult: mult.c arqo4.c 
	$(CC) $(FLAGS) $(LIB_DIR) -o $@ $^ $(LIBS)

mult_para: mult_para.c arqo4.c
	$(CC) $(FLAGS) $(LIB_DIR) -o $@ $^ $(LIBS)

clean:
	rm -f *.o *~ mult mult_para
	
clear:
	rm -f *.o *~
