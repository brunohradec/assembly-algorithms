.386
.model flat
option casemap :none

.data

array dd 01, 02, 03, 04, 05, 06, 07, 08, 09
	dd 10, 11, 12, 13, 14, 15, 16, 17, 18
	dd 19, 20, 21, 22, 23, 24, 25, 26, 27
	dd 28, 29, 30

N dd 30

.data?
result dd ?			;index of the found element

.code

binary_search:

push eax			;EAX - index of the first element of the sub-array
push ebx			;EBX - index of the last element of the sub-array
push ecx			;ECX - middle index of the sub-array
push edx			;EDX - array element to search for

add  esp, 14h			;ESP to given arguments

pop  ebx			;getting the last index of sub-array
pop  eax			;getting the first index of sub-array
pop  edx			;getting the array element to search for

mov  ecx, eax			;counting the middle index of sub-array
add  ecx, ebx
shr  ecx, 1h			;(firs_isndex + last_index) / 2

;does the search element equal to the middle element?
cmp  edx, dword ptr [array + ecx * 4]

je is_equal
jl less_than
jg more_than

is_equal:

;writing the result index
mov dword ptr [result], ecx
jmp the_equal_end

less_than:

sub esp, 20h			;stack pointer above everything put on the stack
push edx			;indexes of the new sub-array
push eax
push ecx

call binary_search

jmp the_unequal_end

more_than:

sub  esp, 20h			;stack pointer na novi dio stack-a iznad svega
push edx			;indexes of the new sub-array
add  ecx, 1h		
push ecx
sub  ecx, 1h		
push ebx			

call binary_search

jmp the_unequal_end

;ending of a function if the element is found
;is different from unequal_end because if searched element is found
;new arguments (indexes of sub-array) are not pushed on the stack

the_equal_end:

sub esp, 20h			;stack pointer na dio stack-a iznad svega
pop edx				;getting the context back
pop ecx
pop ebx
pop eax
jmp the_end

;ending of a function if the element is not found
;is different from equal_end because if searched element is not found
;new arguments (indexes of sub-array) are pushed on the stack

the_unequal_end:

add esp, 0Ch			;removing 3 arguments pushed on the stack
pop edx				;getting the context back
pop ecx
pop ebx
pop eax

the_end:
ret

_start:

push dword ptr 20		;element to be searched for pushed on the stack

push dword ptr 0h		;pushing first index of array on the stack

mov eax, dword ptr [N]		;pushing last index of array on the stack
sub eax, 1h
push eax

call binary_search

add esp, 0Ch			;removing 3 arguments from the stack

ret

end _start
