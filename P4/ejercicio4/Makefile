CC = gcc
LIBS = -lgomp -lm
LIB_DIR =  
FLAGS = -g -Wall -D_GNU_SOURCE -fopenmp

.PHONY: clean all

all: pi_serie pi_par1 pi_par2 pi_par3 pi_par4 pi_par5 pi_par6 pi_par7 clear

pi_serie: pi_serie.c
	$(CC) $(FLAGS) $(LIB_DIR) -o $@ $^ $(LIBS)

pi_par1: pi_par1.c
	$(CC) $(FLAGS) $(LIB_DIR) -o $@ $^ $(LIBS)

pi_par2: pi_par2.c
	$(CC) $(FLAGS) $(LIB_DIR) -o $@ $^ $(LIBS)

pi_par3: pi_par3.c
	$(CC) $(FLAGS) $(LIB_DIR) -o $@ $^ $(LIBS)

pi_par4: pi_par4.c
	$(CC) $(FLAGS) $(LIB_DIR) -o $@ $^ $(LIBS)

pi_par5: pi_par5.c
	$(CC) $(FLAGS) $(LIB_DIR) -o $@ $^ $(LIBS)

pi_par6: pi_par6.c
	$(CC) $(FLAGS) $(LIB_DIR) -o $@ $^ $(LIBS)

pi_par7: pi_par7.c
	$(CC) $(FLAGS) $(LIB_DIR) -o $@ $^ $(LIBS)

clean:
	rm -f *.o *~ pi_par1 pi_par2 pi_par3 pi_par4 pi_par5 pi_par6 pi_par7 pi_serie
	
clear:
	rm -f *.o *~
