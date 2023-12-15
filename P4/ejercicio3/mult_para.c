#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <omp.h>

#include "arqo4.h"

void compute1(float **m1, float **m2, float **res,int n,int hilos);
void compute2(float **m1, float **m2, float **res,int n,int hilos);
void compute3(float **m1, float **m2, float **res,int n,int hilos);

int main( int argc, char *argv[])
{
	int n, hilos, x;
	float **m1=NULL, **m2=NULL;
	struct timeval fin,ini;
	float **res=NULL;


	printf("Word size: %ld bits\n",8*sizeof(float));

	if( argc!=4 )
	{
		printf("Error: ./%s <matrix size> <matrix size> <hilos> <bucle>\n", argv[0]);
		return -1;
	}
	n=atoi(argv[1]);
	hilos=atoi(argv[2]);
	x=atoi(argv[3]);

	m1=generateMatrix(n);
	if( !m1 )
		return -1;
	m2=generateMatrix(n);
	if( !m2 )
	{
		freeMatrix(m1);
		return -1;
	}
	res=generateEmptyMatrix(n);
	if( !res )
	{
		freeMatrix(m1);
		freeMatrix(m2);
		return -1;
	}

	omp_set_num_threads(hilos);
	
	gettimeofday(&ini,NULL);

	/* Main computation */
	if(x == 1)
		compute1(m1, m2, res, n,hilos);
	else if(x == 2)
		compute2(m1, m2, res, n,hilos);
	else if(x == 3)
		compute3(m1, m2, res, n,hilos);
	/* End of computation */

	gettimeofday(&fin,NULL);
	printf("Execution time: %f\n", ((fin.tv_sec*1000000+fin.tv_usec)-(ini.tv_sec*1000000+ini.tv_usec))*1.0/1000000.0);
	/*printf("Matriz resultante:\n");
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            printf("%lf\t", res[i][j]);
        }
        printf("\n");
    }*/
	
	freeMatrix(m1);
	freeMatrix(m2);
	freeMatrix(res);
	return 0;
}

// Función para paralelizar el bucle externo (i)
void compute3(float **m1, float **m2, float **res, int n, int hilos) {
	int p = 0;
	#pragma omp parallel for reduction(+:p)num_threads(hilos)
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            p = 0;
            for (int k = 0; k < n; k++) {
                p += m1[i][k] * m2[k][j];
            }
			res[i][j] = p;
        }
    }
}

// Función para paralelizar el bucle medio (j)
void compute2(float **m1, float **m2, float **res, int n, int hilos) {
	int p;
    for (int i = 0; i < n; i++) {
		#pragma omp parallel for reduction(+:p)num_threads(hilos)
        for (int j = 0; j < n; j++) {
            p = 0;
            for (int k = 0; k < n; k++) {
                p += m1[i][k] * m2[k][j];
            }
			res[i][j] = p;
        }
    }
}

// Función para paralelizar el bucle interno (k)
void compute1(float **m1, float **m2, float **res, int n, int hilos) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            int p = 0;
            #pragma omp parallel for reduction(+:p)num_threads(hilos)
            for (int k = 0; k < n; k++) {
                p += m1[i][k] * m2[k][j];
            }
			res[i][j] = p;
        }
    }
}


