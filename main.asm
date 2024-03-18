SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4

STDIN equ 0
STDOUT equ 1

section .data
  main_menu:
    db 'Kalkulator, wybierz działanie:', 10,
    db '1. Dodawanie', 10,
    db '2. Odejmowanie', 10,
    db '3. Mnożenie', 10,
    db '4. Dzielenie', 10, 0
  main_menu_len equ $-main_menu
  fn_prompt db 'Pierwsza liczba: '
  fn_prompt_len equ $-fn_prompt
  sn_prompt db 'Druga liczba: '
  sn_prompt_len equ $-sn_prompt
  answer db 'Wynik: '
  answer_len equ $-answer
  newline db 10, 13
  newline_len equ $-newline

section .bss
  choice resb 3 
  num1 resb 3
  num2 resb 3
  ans resb 3

section .text
  global _start

_start:
  mov eax, SYS_WRITE
  mov ebx, STDOUT
  lea ecx, [main_menu]
  mov edx, main_menu_len
  int 0x80
  mov eax, SYS_READ
  mov ebx, STDIN
  lea ecx, [choice]
  mov edx, 3
  int 0x80
  mov al, [choice]
  cmp al, '1'
  je addition
  mov eax, SYS_EXIT
  xor ebx, ebx
  int 0x80

addition:
  mov eax, SYS_WRITE
  mov ebx, STDOUT
  lea ecx, [fn_prompt]
  mov edx, fn_prompt_len
  int 0x80
  mov eax, SYS_READ
  mov ebx, STDIN
  lea ecx, [num1]
  mov edx, 3
  int 0x80
  mov eax, SYS_WRITE
  mov ebx, STDOUT
  lea ecx, [sn_prompt]
  mov edx, sn_prompt_len
  int 0x80
  mov eax, SYS_READ
  mov ebx, STDIN
  lea ecx, [num2]
  mov edx, 3
  int 0x80
  mov eax, [num1]
  sub eax, '0'
  mov ebx, [num2]
  sub ebx, '0'
  add eax, ebx
  add eax, '0'
  mov [ans], eax
  mov eax, SYS_WRITE
  mov ebx, STDOUT
  lea ecx, [answer]
  mov edx, answer_len
  int 0x80
  mov eax, SYS_WRITE
  mov ebx, STDOUT
  lea ecx, [ans]
  mov edx, 3
  int 0x80
  mov eax, SYS_WRITE
  mov ebx, STDOUT
  mov ecx, newline
  mov edx, newline_len
  int 0x80
  jmp _start

subtraction:
  mov eax, SYS_WRITE
  mov ebx, STDOUT
  mov ecx, 321
  mov edx, 10
  int 0x80
  jmp _start
