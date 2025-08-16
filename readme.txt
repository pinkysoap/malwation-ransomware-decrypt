Code unpacks itself then execution continues with simd instructions 
encrypting file content 16 byte blocks in each iteration.
In every iteration key also recalculated to a new value. 

I have precalculated a lookup table up to 100 mb.

The file encrypting essential part is here from original Setup.exe:

000000014017E1D9 | 8B95 80010000            | mov edx,dword ptr ss:[rbp+180]             |
000000014017E1DF | 3317                     | xor edx,dword ptr ds:[rdi]                 |
000000014017E1E1 | 44:8B85 EC010000         | mov r8d,dword ptr ss:[rbp+1EC]             |
000000014017E1E8 | 44:89C0                  | mov eax,r8d                                |
000000014017E1EB | 44:89C1                  | mov ecx,r8d                                |
000000014017E1EE | 6641:0F6EC0              | movd xmm0,r8d                              |
000000014017E1F3 | 41:C1E8 18               | shr r8d,18                                 |
000000014017E1F7 | 6641:0F6EE0              | movd xmm4,r8d                              |
000000014017E1FC | C1E8 08                  | shr eax,8                                  |
000000014017E1FF | C1E9 10                  | shr ecx,10                                 |
000000014017E202 | 66:0F6EC9                | movd xmm1,ecx                              |
000000014017E206 | 44:89F9                  | mov ecx,r15d                               |
000000014017E209 | 66:0F6ED8                | movd xmm3,eax                              |
000000014017E20D | 44:89F8                  | mov eax,r15d                               |
000000014017E210 | 6641:0F6ED7              | movd xmm2,r15d                             |
000000014017E215 | 41:C1EF 18               | shr r15d,18                                |
000000014017E219 | 6641:0F6EEF              | movd xmm5,r15d                             |
000000014017E21E | C1E8 10                  | shr eax,10                                 |
000000014017E221 | 66:0F6EF0                | movd xmm6,eax                              |
000000014017E225 | C1E9 08                  | shr ecx,8                                  |
000000014017E228 | 66:0F6EF9                | movd xmm7,ecx                              |
000000014017E22C | 44:89E8                  | mov eax,r13d                               |
000000014017E22F | C1E8 18                  | shr eax,18                                 |
000000014017E232 | 6644:0F6EC8              | movd xmm9,eax                              |
000000014017E237 | 44:89E8                  | mov eax,r13d                               |
000000014017E23A | C1E8 10                  | shr eax,10                                 |
000000014017E23D | 6644:0F6ED0              | movd xmm10,eax                             |
000000014017E242 | 6645:0F6EC5              | movd xmm8,r13d                             |
000000014017E247 | 44:89E8                  | mov eax,r13d                               |
000000014017E24A | C1E8 08                  | shr eax,8                                  |
000000014017E24D | 6644:0F6ED8              | movd xmm11,eax                             |
000000014017E252 | 89D0                     | mov eax,edx                                |
000000014017E254 | C1E8 18                  | shr eax,18                                 |
000000014017E257 | 6644:0F6EE0              | movd xmm12,eax                             |
000000014017E25C | 89D0                     | mov eax,edx                                |
000000014017E25E | C1E8 10                  | shr eax,10                                 |
000000014017E261 | 6644:0F6EE8              | movd xmm13,eax                             |
000000014017E266 | 6644:0F6EF2              | movd xmm14,edx                             |
000000014017E26B | 89D0                     | mov eax,edx                                |
000000014017E26D | C1E8 08                  | shr eax,8                                  |
000000014017E270 | 6644:0F6EF8              | movd xmm15,eax                             |
000000014017E275 | 66:0F60CC                | punpcklbw xmm1,xmm4                        |
000000014017E279 | 48:8B85 10010000         | mov rax,qword ptr ss:[rbp+110]             |
000000014017E280 | F3:0F6F20                | movdqu xmm4,xmmword ptr ds:[rax]           |
000000014017E284 | 66:0F60C3                | punpcklbw xmm0,xmm3                        |
000000014017E288 | 66:0F61C1                | punpcklwd xmm0,xmm1                        |
000000014017E28C | 66:0F60F5                | punpcklbw xmm6,xmm5                        |
000000014017E290 | 66:0F60D7                | punpcklbw xmm2,xmm7                        |
000000014017E294 | 66:0F61D6                | punpcklwd xmm2,xmm6                        |
000000014017E298 | 66:0F62C2                | punpckldq xmm0,xmm2                        |
000000014017E29C | 6645:0F60D1              | punpcklbw xmm10,xmm9                       |
000000014017E2A1 | 6645:0F60C3              | punpcklbw xmm8,xmm11                       |
000000014017E2A6 | 6645:0F61C2              | punpcklwd xmm8,xmm10                       |
000000014017E2AB | 6645:0F60EC              | punpcklbw xmm13,xmm12                      |
000000014017E2B0 | 6645:0F60F7              | punpcklbw xmm14,xmm15                      |
000000014017E2B5 | 6645:0F61F5              | punpcklwd xmm14,xmm13                      |
000000014017E2BA | 6645:0F62C6              | punpckldq xmm8,xmm14                       |
000000014017E2BF | 6641:0F6CC0              | punpcklqdq xmm0,xmm8                       |
000000014017E2C4 | 66:0FEFE0                | pxor xmm4,xmm0                             |
