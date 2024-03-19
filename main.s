  .code32

  .text
  .global _start

_start:
  # Init procedure
  push %ebp
  mov %esp, %ebp
  sub $12, %esp
  # Print main menu
  movl $SYS_WRITE, %eax
  movl $STDOUT, %ebx
  leal main_menu, %ecx
  movl $main_menu_len, %edx
  int $0x80
  # Read number from stdin
  call _read_number
  # Check choosed option
  cmp $1, %eax
  je addition
  # Finish procedure
  mov %ebp, %esp
  pop %ebp
  movl $SYS_EXIT, %eax
  xorl %ebx, %ebx
  int $0x80

addition:
  # Print first number prompt
  movl $SYS_WRITE, %eax
  movl $STDOUT, %ebx
  leal fn_prompt, %ecx
  movl $fn_prompt_len, %edx
  int $0x80
  # Read first number from stdin
  call _read_number
  mov %eax, -4(%ebp)
  # Print second number prompt
  movl $SYS_WRITE, %eax
  movl $STDOUT, %ebx
  leal sn_prompt, %ecx
  movl $sn_prompt_len, %edx
  int $0x80
  # Read second number from stdin
  call _read_number
  mov %eax, -8(%ebp)
  # Add two numbers
  mov -4(%ebp), %eax
  mov -8(%ebp), %ebx
  add %ebx, %eax
  push %eax
  # Print answer prompt
  movl $SYS_WRITE, %eax
  movl $STDOUT, %ebx
  leal answer, %ecx
  movl $answer_len, %edx
  int $0x80
  # Print answer value
  call _write_number
  # Print newline
  movl $SYS_WRITE, %eax
  movl $STDOUT, %ebx
  leal newline, %ecx
  movl $newline_len, %edx
  int $0x80
  # Back to start
  jmp _start

subtraction:
  movl $SYS_WRITE, %eax
  movl $STDOUT, %ebx
  movl $321, %ecx
  movl $10, %edx
  int $0x80
  jmp _start

_write_number:
  # Init procedure
  push %ebp
  mov %esp, %ebp
  # Convert number into string
  mov 8(%ebp), %eax
  leal buffer, %edi
  movl $10, %ebx
  movl $0, %ecx
write_number_loop:
  cmpl $0, %eax
  je write_number_end
  xor %edx, %edx
  idiv %ebx
  addl $48, %edx
  movb %dl, (%edi)
  inc %edi
  inc %ecx
  jmp write_number_loop
write_number_end:
  # Reverse buffer
  leal buffer, %esi
  subl $1, %edi
reverse_loop:
  cmp %edi, %esi
  jge reverse_loop_end
  movb (%esi), %al
  movb (%edi), %bl
  movb %bl, (%esi)
  movb %al, (%edi)
  inc %esi
  dec %edi
  jmp reverse_loop
reverse_loop_end:
  # Print number
  movl $SYS_WRITE, %eax
  movl $STDOUT, %ebx
  mov %ecx, %edx
  leal buffer, %ecx
  int $0x80
  # Finish procedure
  mov %ebp, %esp
  pop %ebp
  ret

_read_number:
  # Init procedure
  push %ebp
  mov %esp, %ebp
  # Read input to buffer
  movl $SYS_READ, %eax
  movl $STDIN, %ebx
  leal buffer, %ecx
  movl $8, %edx
  int $0x80
  # Add \0 at the end, delete \n
  cmpb $0x0a, (%ecx, %edx, 1)
  jne not_newline
  dec %edx
  movb $0x00, (%ecx, %edx, 1)
  jmp added_end
not_newline:
  movb $0x00, (%ecx, %edx, 1)
added_end:    
  # Convert input into number
  xor %eax, %eax
  xor %ebx, %ebx
  leal buffer, %ecx
convert_loop:
  cmpb $0x0a, (%ecx)
  je loop_end
  movzbl (%ecx), %ebx
  sub $'0', %ebx
  imul $10, %eax
  add %ebx, %eax
  inc %ecx
  jmp convert_loop
loop_end:
  # Finish procedure
  mov %ebp, %esp
  pop %ebp
  ret 

  .data
  .equ SYS_EXIT, 1
  .equ SYS_READ, 3
  .equ SYS_WRITE, 4
  .equ STDIN, 0
  .equ STDOUT, 1
main_menu:
  .asciz "Kalkulator, wybierz działanie:\n1. Dodawanie\n2. Odejmowanie\n3. Mnożenie\n4. Dzielenie\n"
main_menu_end:
  .equ main_menu_len, main_menu_end - main_menu
fn_prompt:
  .asciz "Pierwsza liczba: "
fn_prompt_end:
  .equ fn_prompt_len, fn_prompt_end - fn_prompt
sn_prompt:
  .asciz "Druga liczba: "
sn_prompt_end:
  .equ sn_prompt_len, sn_prompt_end - sn_prompt
answer:
  .asciz "Wynik: "
answer_end:
  .equ answer_len, answer_end - answer
newline:
  .asciz "\n\r"
newline_end:
  .equ newline_len, newline_end - newline
buffer:
  .space 10
