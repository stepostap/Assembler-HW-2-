format PE console

include 'win32a.inc'

entry start

section '.data' data readable writable

        strVecSize      db 'size of vector?', 10, 0
        strIncorSize    db 'Incorrect size of vector = %d', 10, 0
        strVecElemI     db '[%d]? ', 0
        strScanInt      db '%d', 0
        strVecElemOut   db '[%d] = %d', 10, 0
        strVecBracketS  db '[', 0
        strVecBracketE  db ']', 10, 0
        strDigit        db '%d ', 0
        strArrA         db 'Array A: ', 0
        strArrB         db 'Array B: ', 0

        arrA_size       dd 0
        arrB_size       dd 0
        arrA            rd 100
        arrB            rd 100
        min             dd ?
        i               dd ?
        tmp             dd ?
        tmpB            dd ?
        stackPointer    dd ?
        a               dd ?

        NULL = 0


section '.code' code readable executable

;____________________—◊»“€¬¿Õ»≈_Ã¿——»¬¿_______________
        readArr:

                push eax
                mov  eax, esp
                push ecx
                push edx

                xor  ecx, ecx
                mov  edx, [ss:eax+8+0]

        inputArrLoop:

                mov  [stackPointer], eax
                mov  [tmp], edx

                cmp  ecx, [ss:eax+8+4]
                jge  endInputArrLoop

                mov  [i], ecx
                push ecx
                push strVecElemI
                call [printf]

                push [tmp]
                push strScanInt
                call [scanf]

                mov  ecx, [i]
                inc  ecx
                mov  edx, [tmp]

                add  edx, 4
                mov  eax, [stackPointer]
                jmp  inputArrLoop

        endInputArrLoop:

                sub  eax, 8
                mov  esp, eax
                pop  edx
                pop  ecx
                pop  eax

        ret
;___________________—◊»“€¬¿Õ»≈_Ã¿——»¬¿_ ŒÕ≈÷____________

;_____________________œŒ»— _Ã»Õ»Ã”Ã¿______________

        findMin:

                push eax
                mov  eax, esp
                push ecx
                push edx
                push ebx

                xor  ecx, ecx
                mov  edx, [ss:eax+8+0]
                mov  ebx, [edx]
                mov  [min], ebx

        findMinLoop:

                mov  [stackPointer], eax
                mov  [tmp], edx
                mov  [i], ecx

                cmp  ecx, [ss:eax+8+4]
                jge  endFindMinLoop


                cmp  ebx, [edx]
                jle  findMinLoopElse

                mov  ebx, [edx]
                mov  [min], ebx

        findMinLoopElse:
                mov  edx, [tmp]
                add  edx, 4
                mov  ecx, [i]
                inc  ecx

                jmp  findMinLoop


        endFindMinLoop:

                sub  eax, 12
                mov  esp, eax

                pop  ebx
                pop  edx
                pop  ecx
                pop  eax

        ret
;__________________œŒ»— _Ã»Õ»Ã”Ã¿_ ŒÕ≈÷____________


;______________«¿Ã≈Õ¿_Õ”À≈…_______

        NewARRWithMin:

                push eax
                mov  eax, esp
                push ecx
                push edx
                push ebx

                mov  edx, [ss:eax+8+4]
                mov  ebx, [ss:eax+8+0]

                mov  ecx, [ss:eax+8+8]

                push ecx
                push edx
                call findMin

                xor  ecx, ecx ;ecx = 0

        NewARRWithMinLoop:

                mov  [tmp], edx
                mov  [tmpB], ebx
                mov  [i], ecx
                cmp  ecx, [ss:eax+8+8]
                jge   endNewARRWithMinLoop


                mov  ecx, 0
                cmp  [edx], ecx
                jne   equalWithMin


                mov  ecx, [min]
                mov  [ebx], ecx
                mov  ebx, [tmpB]
                add  ebx, 4
                inc  [arrB_size]
                mov  ecx, [i]
                inc  ecx
                mov  edx, [tmp]
                add  edx, 4
                jmp NewARRWithMinLoop

        equalWithMin:
                mov  ecx, [edx]
                mov  [ebx], ecx
                mov  ebx, [tmpB]
                add  ebx, 4

                mov  ecx, [i]
                inc  ecx
                mov  edx, [tmp]
                add  edx, 4
                jmp  NewARRWithMinLoop


        endNewARRWithMinLoop:

                sub  eax, 12
                mov  esp, eax

                pop  ebx
                pop  edx
                pop  ecx
                pop  eax

        ret

;_____________«¿Ã≈Õ¿_Õ”À≈…_ ŒÕ≈÷_____


;____________________¬€¬Œƒ_Ã¿——»¬¿______________

        printArr:


                push eax
                mov  eax, esp
                push ecx
                push edx

                mov  [stackPointer], eax

                push strVecBracketS
                call [printf]

                mov  eax, [stackPointer]

                xor  ecx, ecx
                mov  edx, [ss:eax+8+0]

        printArrLoop:

                mov  [tmp], edx
                mov  [i], ecx

                cmp  ecx, [ss:eax+8+4]
                jge  endPrintArrLoop

                mov  ecx, [edx]
                push ecx
                push strDigit
                call [printf]


                mov  edx, [tmp]
                add  edx, 4
                mov  ecx, [i]
                inc  ecx
                mov  eax, [stackPointer]
                jmp  printArrLoop

        endPrintArrLoop:

                push strVecBracketE
                call [printf]


                mov  eax, [stackPointer]


                sub  eax, 8
                mov  esp, eax

                pop  edx
                pop  ecx
                pop  eax

        ret

;__________________¬€¬Œƒ_Ã¿——»¬¿_ ŒÕ≈÷____________

;______________________MAIN_________________
        start:
                push strVecSize
                call [printf]

                push arrA_size
                push strScanInt
                call [scanf]


                mov  eax, [arrA_size]
                cmp  eax, 0
                jg  successInput


                push strIncorSize
                push [arrA_size]
                call [printf]

                jmp finish

        successInput:

                push [arrA_size]
                push arrA
                call readArr


                push [arrA_size]
                push arrA
                push arrB
                call NewARRWithMin

                ;‚˚‚Ó‰ËÏ Ï‡ÒÒË‚˚
                push strArrA
                call [printf]

                push [arrA_size]
                push arrA
                call printArr

                push strArrB
                call [printf]

                push [arrA_size]
                push arrB
                call printArr

        finish:
                call [getch]

                push NULL
                call ExitProcess
;_________________END_MAIN_________________

section '.idata' data readable import

        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt,\
               printf, 'printf',\
               scanf, 'scanf',\
               getch, '_getch'