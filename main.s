.section .data
  .equ SYS_EXIT, 1
  .equ SYS_READ, 3
  .equ SYS_WRITE, 4
  .equ STDIN, 0
  .equ STDOUT, 1
  main_menu: .asciz "Kalkulator, wybierz działanie:\n1. Dodawanie\n2. Odejmowanie\n3. Mnożenie\n4. Dzielenie\n"
  main_menu_end: .equ main_menu_len, main_menu_end - main_menu
  fn_prompt: .asciz "Pierwsza liczba: "
  fn_prompt_end: .equ fn_prompt_len, fn_prompt_end - fn_prompt
  sn_prompt: .asciz "Druga liczba: "
  sn_prompt_end: .equ sn_prompt_len, sn_prompt_end - sn_prompt
  answer: .asciz "Wynik: "
  answer_end: .equ answer_len, answer_end - answer
  newline: .asciz "\n\r"
  newline_end: .equ newline_len, newline_end - newline

.section .bss
  .lcomm choice, 1
  .lcomm num1, 4
  .lcomm num2, 4
  .lcomm ans, 4

.section .text
  .global _start

_start:
  movl $SYS_WRITE, %eax
  movl $STDOUT, %ebx
  leal main_menu, %ecx
  movl $main_menu_len, %edx
  int $0x80
  movl $SYS_READ, %eax
  movl $STDIN, %ebx
  leal choice, %ecx
  movl $4, %edx
  int $0x80
  movb (choice), %al
  cmpb $'1', %al
  je addition
  movl $SYS_EXIT, %eax
  xorl %ebx, %ebx
  int $0x80

addition:
  movl $SYS_WRITE, %eax
  movl $STDOUT, %ebx
  leal fn_prompt, %ecx
  movl $fn_prompt_len, %edx
  int $0x80
  movl $SYS_READ, %eax
  movl $STDIN, %ebx
  leal num1, %ecx
  movl $4, %edx
  int $0x80
  movl $SYS_WRITE, %eax
  movl $STDOUT, %ebx
  leal sn_prompt, %ecx
  movl $sn_prompt_len, %edx
  int $0x80
  movl $SYS_READ, %eax
  movl $STDIN, %ebx
  leal num2, %ecx
  movl $4, %edx
  int $0x80
  movl (num1), %eax
  subl $'0', %eax
  movl (num2), %ebx
  subl $'0', %ebx
  addl %ebx, %eax
  addl $'0', %eax
  movl %eax, (ans)
  movl $SYS_WRITE, %eax
  movl $STDOUT, %ebx
  leal answer, %ecx
  movl $answer_len, %edx
  int $0x80
  movl $SYS_WRITE, %eax
  movl $STDOUT, %ebx
  leal ans, %ecx
  movl $4, %edx
  int $0x80
  movl $SYS_WRITE, %eax
  movl $STDOUT, %ebx
  leal newline, %ecx
  movl $newline_len, %edx
  int $0x80
  jmp _start

subtraction:
  movl $SYS_WRITE, %eax
  movl $STDOUT, %ebx
  movl $321, %ecx
  movl $10, %edx
  int $0x80
  jmp _start
