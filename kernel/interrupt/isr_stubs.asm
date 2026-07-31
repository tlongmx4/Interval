bits 32
extern exception_handler
global isr_stub_table

%macro isr_err_stub 1
isr_stub_%+%1:
    push %1
    jmp isr_common_stub
%endmacro

%macro isr_no_err_stub 1
isr_stub_%+%1:
    push 0
    push %1
    jmp isr_common_stub
%endmacro

isr_common_stub:
    pusha
    mov eax, esp
    push eax
    call exception_handler
    add esp, 4
    popa
    add esp, 8              ; drop vector and error code
    iret

; --- CPU Exceptions, 0-31 ---
isr_no_err_stub 0
isr_no_err_stub 1
isr_no_err_stub 2
isr_no_err_stub 3
isr_no_err_stub 4
isr_no_err_stub 5
isr_no_err_stub 6
isr_no_err_stub 7
isr_err_stub 8
isr_no_err_stub 9
isr_err_stub 10
isr_err_stub 11
isr_err_stub 12
isr_err_stub 13
isr_err_stub 14
isr_no_err_stub 15
isr_no_err_stub 16
isr_err_stub 17
isr_no_err_stub 18
isr_no_err_stub 19
isr_no_err_stub 20
isr_no_err_stub 21
isr_no_err_stub 22
isr_no_err_stub 23
isr_no_err_stub 24
isr_no_err_stub 25
isr_no_err_stub 26
isr_no_err_stub 27
isr_no_err_stub 28
isr_no_err_stub 29
isr_no_err_stub 30
isr_no_err_stub 31

; --- Hardware IRQs, remapped to 32-47 ---
isr_no_err_stub 32
isr_no_err_stub 33
isr_no_err_stub 34
isr_no_err_stub 35
isr_no_err_stub 36
isr_no_err_stub 37
isr_no_err_stub 38
isr_no_err_stub 39
isr_no_err_stub 40
isr_no_err_stub 41
isr_no_err_stub 42
isr_no_err_stub 43
isr_no_err_stub 44
isr_no_err_stub 45
isr_no_err_stub 46
isr_no_err_stub 47

; --- table of pointers, for the C++ side ---
isr_stub_table:
    dd isr_stub_1
    dd isr_stub_2
    dd isr_stub_3
    dd isr_stub_4
    dd isr_stub_5
    dd isr_stub_6
    dd isr_stub_7
    dd isr_stub_8
    dd isr_stub_9
    dd isr_stub_10
    dd isr_stub_11
    dd isr_stub_12
    dd isr_stub_13
    dd isr_stub_14
    dd isr_stub_15
    dd isr_stub_16
    dd isr_stub_17
    dd isr_stub_18
    dd isr_stub_19
    dd isr_stub_20
    dd isr_stub_21
    dd isr_stub_22
    dd isr_stub_23
    dd isr_stub_24
    dd isr_stub_25
    dd isr_stub_26
    dd isr_stub_27
    dd isr_stub_28
    dd isr_stub_29
    dd isr_stub_30
    dd isr_stub_31
    dd isr_stub_32
    dd isr_stub_33
    dd isr_stub_34
    dd isr_stub_35
    dd isr_stub_36
    dd isr_stub_37
    dd isr_stub_38
    dd isr_stub_39
    dd isr_stub_40
    dd isr_stub_41
    dd isr_stub_42
    dd isr_stub_43
    dd isr_stub_44
    dd isr_stub_45
    dd isr_stub_46
    dd isr_stub_47