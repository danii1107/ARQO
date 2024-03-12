.data
numbers: .word 9, 5, 7, 2, 4, 1, 8, 3, 6, 10 # Lista de números desordenados
sorted: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 # Espacio para la lista ordenada

.text
.globl _start

_start:
# Cargar la dirección de la lista de números en a0
la a0, numbers

# Cargar la dirección de la lista ordenada en a1
la a1, sorted

# Inicializar el contador de iteraciones en t0
li t0, 10

outer_loop:
# Inicializar el índice en t1 y el indicador de cambio en t2
li t1, 0
li t2, 0

inner_loop:
# Cargar numbers[i] en t3
lw t3, 0(a0)

# Cargar numbers[i+1] en t4
lw t4, 4(a0)

# Comparar numbers[i] y numbers[i+1]
bge t3, t4, no_swap

# Intercambiar los números si están en el orden incorrecto
sw t4, 0(a0)
sw t3, 4(a0)
li t2, 1

no_swap:
# Avanzar al siguiente par de elementos
addi a0, a0, 4
addi t1, t1, 1

# Verificar si hemos llegado al final de la lista
beq t1, t0, end_inner_loop

# Si no, continuar con la siguiente comparación
j inner_loop

end_inner_loop:
# Si no se realizó ningún intercambio en esta iteración, la lista está ordenada
beqz t2, end_outer_loop

# Restablecer el indicador de cambio
li t2, 0

# Volver al principio de la lista
la a0, numbers

# Decrementar el contador de iteraciones
addi t0, t0, -1

# Continuar con la siguiente iteración
j outer_loop

end_outer_loop:
# El resultado ordenado está en la lista "sorted"
# Puedes copiarlo a otra ubicación si es necesario

# Terminar el programa
li a7, 10 # Cargar el código de salida de la syscall (exit)
ecall