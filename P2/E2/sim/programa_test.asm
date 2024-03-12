##########################################################################

#   Programa de prueba para Practica 1 ARQO 2023                         #

#                                                                        #

##########################################################################

# Programa en ensamblador RISC-V para probar el funcionamiento de la P1. 

# Incluye todas las instrucciones a verificar. Los saltos de los beq se 

# realizan de forma efectiva si las operaciones anteriores han devuelto

# resultados correctos en los registros. 

# El programa termina con un buble infinito (En RARS mejor ver paso a paso)

# En las formas de ondas debes analizar el funcionamiento

#

############################################################################



.data

num0:   .word  1 # posic base + 0

num1:   .word  2 # posic base + 4

num2:   .word  4 # posic base + 8

num3:   .word  8 # posic base + 12

num4:   .word 16 # posic base + 16

num5:   .word 32 # posic base + 20

num32:  .word 0xAAAA5555 # posic base + 24

buffer: .space 4



.text 

            #Empezamos con pruebas Load, Store y Lui

main:       lui  t0, %hi(num0)  # Carga la parte alta de la dir num0

            nop

            nop

            nop

            lw   t1, 0(t0)      # En x6 un 1
            
            addi a1, t1, 1
            add a3, a1, a1
            add a4, a1, a1
            add a5, a3, a4
            add a3, a3, a5

            lw   t2, 4(t0)      # En x7 un 2
            
            add a2, a1, t2
            add a2, t2, a2
            add a1, a2, a2

            lw   t3, 8(t0)      # En x28 un 4 

            lw   t4,12(t0)      # En x29 un 8

            lw   t5,16(t0)      # En x30 un 16

            lw   t6,20(t0)      # En x31 un 32