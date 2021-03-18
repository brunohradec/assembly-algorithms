.386
.model flat
option casemap :none

.data

array db 4h, 5h, 3h, 2h, 1h, 6h, 8h, 7h, 9h
num_of_elements db 9h

.code

_start:

mov ch, byte ptr 0h				;outer loop counter
mov dh, byte ptr [num_of_elements]		;number of elements in array
sub dh, 1h					;max number of iterations for outer loop
mov dl, dh					;max number of iterations for inner loop

outer_loop:

cmp ch, dh					;has outer loop finished?
je  kraj					;if it is done, go to the "kraj" label

lea esi, dword ptr [array] 			;address of the sorted array

mov cl, byte ptr 0h				;inner loop counter
dec dl						;number of iterations for inner loop

inner_loop:

cmp cl, dl					;has inner loop finished?
je  continue_outer

mov ah, byte ptr [esi]				;getting the first element
mov al, byte ptr [esi + 1h]			;getting the next element

cmp al, ah					;should they change places?
jl  no_change

mov bl, ah
mov ah, al
mov al, bl

mov byte ptr [esi], ah				;first element back to array
mov byte ptr [esi + 1h], al			;second element back to array

no_change:

inc esi						;address of the next two elements			
inc cl						;inner_loop_counter++
jmp inner_loop

continue_outer:
inc ch						;outer_loop_counter++
jmp outer_loop

kraj: ret

end _start
