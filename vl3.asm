model small
.stack 100h
.386
.data
	fio db 'Vlasov Georgii Vladimirovich'
	videoMode db ?
	height dw 16
	x dw 60
	y dw 100
.code
start:	
	mov ax, @data
	mov ds, ax
	
	mov ah, 0Fh	
	int 10h
	mov videoMode, al
	xor ah,ah
	mov al, 13h 
	int 10h
	
	mov ax, 1130h 
    mov bh, 06h      			
    int 10h
	
	push es
	pop fs

	mov bx,offset fio			

		symbolLoop:
		xor ax,ax				
		mov al,[bx]				
		mul height				
		add ax,bp				
		mov si,ax			

		mov cx,16			
			checkLines:	
			push cx					
			mov al, fs:[si]		
			mov cx, 8
			push x				
				checkLine:
				rol al,1		
				jc FillPixel
				jmp noFill		
			
					FillPixel:
					push ax		
					push cx
					push dx 
					xor bh,bh		
					mov ah,0Ch	
					mov dx,y
					mov cx,x
					mov al,010b					
					int 10h
					pop dx
					pop cx
					pop ax
				
				noFill:
				add x,1	
				
				loop checkLine
			
			pop x				
			add y,1				
			inc si				
			pop cx				
			loop checkLines
			
		add x,8					
		inc bx					
		mov y,100						
    	cmp fio[bx - 1], 'h'		
   		jne symbolLoop				

	mov ah,10h
   	int 16h
    xor ah,ah				
	mov al,videoMode
	int 10h
	mov ax,4c00h
	int 21h
end start