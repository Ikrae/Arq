.text

	lui a1,0x10010	#Torre A
	lui a2, 0x10010	#Torre B
	addi a2, a2, 32
    	lui a3, 0x10010#Torre final C
   	addi a3, a3, 64
    
	
    	
	li t5, 1

    addi s0, zero, 15  
    #NUMERO DE DISCOS
	add t0, s0, zero  	#GUARDA el valor del numero de discos en una variable para poder trabajarlo sin cambiar el valor inicial
	add t1, zero, zero	#VAR TEMP 1
	add t2, zero, zero 	#VARIABLE TEMP 2


discos: 

	sw t0, 0(a1)			#agrega el disco a la torra A
	addi t0, t0, -1		
	#Decrementa ahora el numero de discos a T0-1 en forma temporal con t0
	
	addi a1, a1, 4		#se pasa a la siguiente direccion de memoria de la torre A
	bne t0, zero, discos	
	#se repite hasta que t0=0

	jal Han			#e copia el valor en ra y se sigue con el algoritmo
	j fin					
	#finalizacion de la funcion

Han:	
	addi sp, sp, -4		#Toma 32 bits de sp y reserva lo demas para ra
	sw ra, 0(sp)			#se guarda ra 

	beq s0, t5, ini	#si n=1 se va a la funcion, de otra manera sigue con el codigo.


#cambio de A a B
	addi s0, s0, -1		#se hace n-1 para tomarlo como variable de ciclo
	add t1, a2, zero 	#se guarda como variable temporal
	add a2, a3, zero  	#se intercambian el disco del origen a B
	add a3, t1, zero  
    #se hacen intercambios para n-1 discos desde su origen a B
   

	jal Han		#ciclo
    
#cambio de B a C

	add t0, a3, zero		#Se guarda en variable temporal
	add a3, a2, zero		#intecambio entre B y C
	add a2, t0, zero
	
  
	addi a1, a1, -4	#se toma el disco de destino
	lw t3, 0(a1)		
	#se carga el origen en una variable temporal
	    sw zero, 0(a1)	#se escribe 0 en el espacio antes de moverlo
	    sw t3, 0(a3)  	
	    #guarda la direccion de origen a destino
	    addi a3, a3, 4 	#se agrega disco a la torre C
	
	
	add t1, a1, zero		#guarda origen a una variable temporal
	add a1, a2, zero		#cambio de A a C
	add a2, t1, zero		
	
	addi s0, s0, -1		#decremento de "contador" n-1
	jal Han		
	
    
	add t1, a1, zero
	add a1, a2, zero
	add a2, t1, zero

	lw ra, 0(sp)			
	#carga ra
	addi sp, sp, 4		#se recuperan los 32 bits de sp
	
	addi s0, s0, 1		
	#se agrega el disco de n que fue ignorado antes de manera n+1
	jr ra				#regresa a la ultima llamada de la funcion Han	

ini:
	addi a1, a1, -4		
	#toma un disco de C
	lw t3, 0(a1)			#carga la variable de origen a una variable temporal
	    sw zero, 0(a1)		#escribe "0" en el lugar del disco antes de moverlo a su destino
	    sw t3, 0(a3)  		#uarda la direccion de su origen a el destino
	    addi a3, a3, 4		#Agrega disco a la siguiente direccion de la torre destino
	
	addi s0, s0, 1		#Agrega el disco a N
	
    lw ra, 0(sp)			
    #carga ra
	addi sp, sp, 4		#recupera los 32 bits de sp
	jr ra					#regresa a la ultima llamada de han
	
fin:
