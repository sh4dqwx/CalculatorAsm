section .data
  fn_prompt db 'Pierwsza liczba: '
  fn_prompt_len equ $-fn_prompt
  sn_prompt db 'Druga liczba: '
  sn_prompt_len equ $-sn_prompt
  answer db 'Wynik: '
  answer_len equ $-answer

section .bss
  num1 resb 5
  num2 resb 5
  ans resb 5

section .text
  global _start

_start:
  mov eax, 4
  mov ebx, 1
  mov ecx, fn_prompt
  mov edx, fn_prompt_len
  int 0x80

  mov eax, 3
  mov ebx, 1
  mov ecx, num1
  mov edx, 5
  int 0x80

  mov eax, 4
  mov ebx, 1
  mov ecx, sn_prompt
  mov edx, sn_prompt_len
  int 0x80
  
  mov eax, 3
  mov ebx, 1
  mov ecx, num2
  mov edx, 5
  int 0x80

  mov eax, [num1]
  sub eax, '0'
  mov ebx, [num2]
  sub eax, '0'
  add eax, ebx
  add eax, '0'
  mov [ans], eax

  mov eax, 4
  mov ebx, 1
  mov ecx, answer
  mov edx, answer_len
  int 0x80

  mov eax, 4
  mov ebx, 1
  mov ecx, ans
  mov edx, 5
  int 0x80

  mov eax, 1
  xor ebx, ebx
  int 0x80
