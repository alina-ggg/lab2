section .data
    msg_input: db "Введите N и числа: ", 0 ; dp - запись строки в память
    len_input: equ $ - msg_input ; вычисление длины строки
    nextline: db 10 ; код символа переноса строки

section .bss ; секция неиницилизированных данных
    buffer: resb 1024
    num_array: resq 256
    out_buf: resb 32

section .text
    global _start ; точка входа

_start:
    mov rax, 1 ; кладем 1 в RAX - номер системного вывода write
    mov rdi, 1 ; RDI = 1 (экран)
    mov rsi, msg_input ; RSI - адрес начала строки
    mov rdx, len_input ; RDX - сколько байт напечатать
    syscall ; выполнение вывода

    mov rax, 0 ; RAX = 0 - номер вызова read
    mov rdi, 0 ; RDI = 0 - клавиатура
    mov rsi, buffer ; место сохранения введенного текста
    mov rdx, 1024 ; максимальный размер вывода
    syscall
    mov r12, rax ; сохранение сколько байт ввел пользователь

    lea rsi, [buffer] ; загрузка адреса начала текста
    lea rdi, [num_array] ; загрузка адреса массива чисел
    xor r13, r13 ; R13 - индекс в массиве чисел

parse_loop:
    call skip_spaces
    mov al, [rsi]
    cmp al, 10           ; Проверка на конец строки (Enter)
    je start_algorithm
    cmp al, 0            ; Проверка на конец данных
    je start_algorithm

    call string_to_int ; из текста в число
    mov [rdi + r13*8], rax ; сохранение полученного числа rax в массив
    inc r13 ; увеличение счётчика найденных чисел
    jmp parse_loop ; за следующим числом

start_algorithm:
    cmp r13, 2 ; если в массиве меньше 2 элементов, то пар нет 
    jl exit_zero

    mov r8, [num_array]
    cmp r8, 1 ; если N <= 1, пар нет 
    jle exit_zero

    xor r14, r14 ; обнуляем R14 - итоговый count
    mov rcx, 1 ; RCX = 1 - индекс первого числа в последовательности

algo_loop:
    mov r10, rcx ; копирование текущего индекса
    inc r10 ; индекс следующего числа
    cmp r10, r13 ; проверка выхода за границы массива
    jge print_res ; если вышли - печать результата

    ; сравнение текущего и следующего
    mov rax, [num_array + rcx*8] ; текущее число
    mov rbx, [num_array + r10*8] ; следующее число
    cmp rax, rbx ; сравнение 
    jne next_iter ; если не равны - пропуск
    inc r14 ; если равны count увеличивается

next_iter:
    inc rcx ; переход к следующему числу
    dec r8 ; уменьшение N 
    cmp r8, 1 ; пока N > 1
    jg algo_loop ; продолжение цикла

print_res:
    mov rax, r14 ; кладем результат count в rax для вывода
    call int_to_string ; из числа в текст и печать
    jmp exit 

exit_zero:
    ; вывод 0 и переход на новую строку
    mov rax, 1
    mov rdi, 1
    mov rsi, out_buf
    mov byte [rsi], '0'
    mov byte [rsi+1], 10
    mov rdx, 2
    syscall

exit:
    mov rax, 60 ; системный возов 60 - выход
    xor rdi, rdi ; код возврата 0
    syscall
    
; вспомогательные функции
skip_spaces:
.loop:
    mov al, [rsi] ; текущий символ
    cmp al, ' ' ; проверка на пробел
    jne .done ; если не пробел - выход
    inc rsi ; если пробел - к следующему
    jmp .loop
.done:
    ret

string_to_int: ; перевод текста в число
    xor rax, rax ; обнуление результата
.loop:
    movzx rdx, byte [rsi] ; чтение байта
    sub dl, '0' ; перевод в цифру
    jb .done ; если результат меньше 0 - все 
    cmp dl, 9 ; если результат больше 9 - все 
    ja .done

    imul rax, 10 ; rax = rax * 10
    add rax, rdx ; прибавление новой цифры
    inc rsi ; указатель строки
    jmp .loop
.done:
    ret

; вывод числа
int_to_string:
    lea rsi, [out_buf + 30] ; точка старта в конце буфера
    mov byte [rsi], 10
    dec rsi
    mov rbx, 10 ; делитель
.loop:
    xor rdx, rdx
    div rbx ; RAX/10, остаток в RDX
    add dl, '0' ; из цифры в символ
    mov [rsi], dl ; запись в буфер 
    dec rsi ; влево
    test rax, rax ; проверка окончания числа
    jnz .loop ; если число не кончилось, то дальше

    ; вывод
    mov rax, 1 ; syscall: write
    mov rdi, 1
    inc rsi
    lea rdx, [out_buf + 31] ; конец буфера
    sub rdx, rsi ; длина = конец - начало
    syscall
    ret

