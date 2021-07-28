
unofficial_opcodes = 1

immediate    = $10000
indexed_X    = $20000
indexed_Y    = $30000
indirect_X   = $40000

! = immediate
x = indexed_X
y = indexed_Y
z = indirect_X

lo_0 = 0
hi_0 = 1
lo_2 = 2
hi_2 = 3



@l  fix @b
@s  fix @f
@   fix @@:


macro dbw [byte,word] {db byte
                       dw word}
.dbw fix dbw

macro dwb [word,byte] {dw word
                       db byte}
.dwb fix dwb

macro dl  [byte] {db byte and $ff }
macro dh  [byte] {db byte shr 8 }
macro lohi name,[word] {common
                       lo_#name:
                       forward
                       dl word
                       common
                       hi_#name:
                       forward
                       dh word       }

macro .hex [byte] {db $#byte}
.hx fix .hex
hx fix .hex

.        fix db
.db      fix db
.dw      fix dw
.dl      fix dl
.dh      fix dh
.lohi    fix lohi
.include fix include
incbin   fix file
.incbin  fix file
.org     fix org
.bin     fix file

macro sec       {db $38}                ;SEC
macro clc       {db $18}                ;CLC
macro sed       {db $f8}                ;SED
macro cld       {db $d8}                ;CLD
macro clv       {db $b8}                ;CLV
macro cli       {db $58}                ;CLI
macro ei        {db $58}                ;CLI
macro sei       {db $78}                ;SEI
macro di        {db $78}                ;SEI
macro nop       {db $ea}                ;NOP
macro tax       {db $aa}                ;TAX
macro tay       {db $a8}                ;TAY
macro tsx       {db $ba}                ;TSX
macro txa       {db $8a}                ;TXA
macro txs       {db $9a}                ;TXS
macro tya       {db $98}                ;TYA
;macro pha       {db $48}                ;PHA
macro php       {db $08}                ;PHP
;macro pla       {db $68}                ;PLA
macro plp       {db $28}                ;PLP
macro inx       {db $e8}                ;INX
macro iny       {db $c8}                ;INY
macro dex       {db $ca}                ;DEX
macro dey       {db $88}                ;DEY
macro bpl  op1* {db $10,(op1)-1-$}      ;BPL Reladdress
macro bmi  op1* {db $30,(op1)-1-$}      ;BMI Reladdress
macro bvc  op1* {db $50,(op1)-1-$}      ;BVC Reladdress
macro bvs  op1* {db $70,(op1)-1-$}      ;BVS Reladdress
macro bcc  op1* {db $90,(op1)-1-$}      ;BCC Reladdress
macro bcs  op1* {db $b0,(op1)-1-$}      ;BCS Reladdress
macro bne  op1* {db $d0,(op1)-1-$}      ;BNE Reladdress
macro jnz  op1* {db $d0,(op1)-1-$}      ;BNE Reladdress
macro beq  op1* {db $f0,(op1)-1-$}      ;BEQ Reladdress
macro jz   op1* {db $f0,(op1)-1-$}      ;BEQ Reladdress
macro bz   op1* {db $f0,(op1)-1-$}      ;BEQ Reladdress
macro bnz  op1* {db $f0,(op1)-1-$}      ;BEQ Reladdress
macro jmp  op1* {dbw $4c,op1}           ;JMP Address
macro ijmp op1* {dbw $6c,op1}           ;JMP ($6502)
macro jsr  op1* {dbw $20,op1}           ;JSR Address
macro call op1* {dbw $20,op1}           ;JSR Address
macro rts       {db $60}                ;RTS
macro ret       {db $60}                ;RTS
macro brk  op1* {db $00,op1}            ;BRK Anything
macro rti       {db $40}                ;RTI
macro reti      {db $40}                ;RTI

macro macro_bpl op1 {db $10,(op1)-1-$}
macro macro_bne op1 {db $d0,(op1)-1-$}
macro macro_beq op1 {db $f0,(op1)-1-$}
;=============================================================================
;       instruction macro
;-----------------------------------------------------------------------------
macro instru6502 mnem*,impl*,zepa*,abbs*,imme*,zepx*,abbx*,zepy*,abby*,indx*
    { macro mnem op1 \{

                 if op1 eq                      ;STANDARD      FLAT6502.INC
                  .db  impl                     ;mne           mne
                 else if op1 <= $ff
                  .db  zepa,op1                 ;mne $65       mne $65
                 else if op1 <= $ffff
                  .dbw abbs,op1                 ;mne $6502     mne $6502
                 else if op1 <= $ff+immediate
                  .db  imme,op1-immediate       ;mne #$65      mne !+$65
                 else if op1 <= $ff+indexed_X
                  .db  zepx,op1-indexed_X       ;mne $65,x     mne $65+x
                 else if op1 <= $ffff+indexed_X
                  .dbw abbx,op1-indexed_X       ;mne $6502,x   mne $6502+x
                 else if op1 <= $ff+indexed_Y
                  .db  zepy,op1-indexed_Y       ;mne ($65),y   mne ($65)+y
                 else if op1 <= $ffff+indexed_Y
                  .dbw abby,op1-indexed_Y       ;mne $6502,y   mne $6502+y
                 else if op1 <= $ff+indirect_X
                  .db  indx,op1-indirect_X      ;mne ($65,x)   mne ($6502+z)
                 end if \} }
;-----------------------------------------------------------------------------
_TYPO_ = 666  ;16-bit number to generate error message
;          MNE,impl  ,zp    ,abb   ,imm   ,zp+x  ,abb+x ,zp+y  ,abb+y ,ind+x
instru6502 lda,_TYPO_,$a5   ,$ad   ,$a9   ,$b5   ,$bd   ,$b1   ,$b9   ,$a1
instru6502 sta,_TYPO_,$85   ,$8d   ,_TYPO_,$95   ,$9d   ,$91   ,$99   ,$81
instru6502 ldx,_TYPO_,$a6   ,$ae   ,$a2   ,_TYPO_,_TYPO_,$b6   ,$be   ,_TYPO_
instru6502 stx,_TYPO_,$86   ,$8e   ,_TYPO_,_TYPO_,_TYPO_,$96   ,_TYPO_,_TYPO_
instru6502 ldy,_TYPO_,$a4   ,$ac   ,$a0   ,$b4   ,$bc   ,_TYPO_,_TYPO_,_TYPO_
instru6502 sty,_TYPO_,$84   ,$8c   ,_TYPO_,$94   ,_TYPO_,_TYPO_,_TYPO_,_TYPO_
instru6502 adc,_TYPO_,$65   ,$6d   ,$69   ,$75   ,$7d   ,$71   ,$79   ,$61
instru6502 sbc,_TYPO_,$e5   ,$ed   ,$e9   ,$f5   ,$fd   ,$f1   ,$f9   ,$e1
instru6502 and,_TYPO_,$25   ,$2d   ,$29   ,$35   ,$3d   ,$31   ,$39   ,$21
instru6502 ora,_TYPO_,$05   ,$0d   ,$09   ,$15   ,$1d   ,$11   ,$19   ,$01
instru6502 eor,_TYPO_,$45   ,$4d   ,$49   ,$55   ,$5d   ,$51   ,$59   ,$41
instru6502 inc,_TYPO_,$e6   ,$ee   ,_TYPO_,$f6   ,$fe   ,_TYPO_,_TYPO_,_TYPO_
instru6502 dec,_TYPO_,$c6   ,$ce   ,_TYPO_,$d6   ,$de   ,_TYPO_,_TYPO_,_TYPO_
instru6502 cmp,_TYPO_,$c5   ,$cd   ,$c9   ,$d5   ,$dd   ,$d1   ,$d9   ,$c1
instru6502 cpx,_TYPO_,$e4   ,$ec   ,$e0   ,_TYPO_,_TYPO_,_TYPO_,_TYPO_,_TYPO_
instru6502 cpy,_TYPO_,$c4   ,$cc   ,$c0   ,_TYPO_,_TYPO_,_TYPO_,_TYPO_,_TYPO_
instru6502 asl,$0a   ,$06   ,$0e   ,_TYPO_,$16   ,$1e   ,_TYPO_,_TYPO_,_TYPO_
instru6502 lsr,$4a   ,$46   ,$4e   ,_TYPO_,$56   ,$5e   ,_TYPO_,_TYPO_,_TYPO_
instru6502 rol,$2a   ,$26   ,$2e   ,_TYPO_,$36   ,$3e   ,_TYPO_,_TYPO_,_TYPO_
instru6502 ror,$6a   ,$66   ,$6e   ,_TYPO_,$76   ,$7e   ,_TYPO_,_TYPO_,_TYPO_
instru6502 bit,_TYPO_,$24   ,$2c   ,_TYPO_,_TYPO_,_TYPO_,_TYPO_,_TYPO_,_TYPO_

instru6502 macro_sta,_TYPO_,$85   ,$8d   ,_TYPO_,$95   ,$9d   ,$91   ,$99   ,$81

;immediate synonyms
macro lda! op1* {db $a9,op1}
macro ldx! op1* {db $a2,op1}
macro ldy! op1* {db $a0,op1}
macro adc! op1* {db $69,op1}
macro sbc! op1* {db $e9,op1}
;macro andi op1* {db $29,op1}
macro ora! op1* {db $09,op1}
macro eor! op1* {db $49,op1}
;macro cmp! op1* {db $c9,op1}
;macro cpx! op1* {db $e0,op1}
;macro cpy! op1* {db $c0,op1}
;macro addi op1* {db $18,$69,op1}
;macro subi op1* {db $38,$e9,op1}
;immediate lo byte
macro ldal op1* {db $a9,(op1) and $ff}
macro ldxl op1* {db $a2,(op1) and $ff}
macro ldyl op1* {db $a0,(op1) and $ff}
;immediate hi byte
macro ldah op1* {db $a9,(op1) shr 8}
macro ldxh op1* {db $a2,(op1) shr 8}
macro ldyh op1* {db $a0,(op1) shr 8}
;=============================================================================
;       8-bit moves
;-----------------------------------------------------------------------------
macro mov     dest*,src*        {
      lda     src
      sta     dest              }
macro mvx     dest*,src*        {
      ldx     src
      stx     dest              }
macro mvy     dest*,src*        {
      ldy     src
      sty     dest              }
macro mov!    dest*,src*        {
      lda     immediate+(src)
      sta     dest              }
macro mvx!    dest*,src*        {
      ldx     immediate+(src)
      stx     dest              }
macro mvy!    dest*,src*        {
      ldy     immediate+(src)
      sty     dest              }

macro tra     src*,[dest*]      {
common
      lda     src
forward
      sta     dest              }

macro trx     src*,[dest*]      {
common
      ldx     src
forward
      stx     dest              }

macro try     src*,[dest*]      {
common
      ldy     src
forward
      sty     dest              }

macro tra!    src*,[dest*]      {
common
      lda     immediate+(src)
forward
      sta     dest              }

macro trx!    src*,[dest*]      {
common
      ldx     immediate+(src)
forward
      stx     dest              }

macro try!    src*,[dest*]      {
common
      ldy     immediate+(src)
forward
      sty     dest              }


macro pha     op1               {
if op1 eq
      db $48  ;pha
else
      lda     op1
      db $48  ;pha
end if                          }



macro sta     [dest*]   {
      sta     dest      }
macro sty     [dest*]   {
      sty     dest      }
macro stx     [dest*]   {
      stx     dest      }


macro pla     op1               {
if op1 eq
      db $68  ;pla
else
      db $68  ;pla
      macro_sta     op1
end if                          }




;--------------------------------------
macro lda.ne op1*    {
local .skiplda
      macro_beq .skiplda
      lda     op1
.skiplda:           }

macro lda.ne! op1*    {
local .skiplda
      macro_beq .skiplda
      lda     immediate+(op1)
.skiplda:           }

macro lda.mi op1*    {
local .skiplda
      macro_bpl .skiplda
      lda     op1
.skiplda:           }

macro lda.mi! op1*    {
local .skiplda
      macro_bpl .skiplda
      lda     immediate+(op1)
.skiplda:           }


;=============================================================================
;       16-bit moves
;-----------------------------------------------------------------------------
macro movw    dest*,src*                {
      lda     src
      sta     dest
      lda     src+1
      sta     dest+1                    }
macro movw!   dest*,src*                {
      lda     immediate+((src) and $ff)
      sta     dest
      lda     immediate+((src) shr 8)
      sta     dest+1                    }

macro movlh   dest*,src*                {
      lda     lo_#src
      sta     lo_#dest
      lda     hi_#src
      sta     hi_#dest                  }
macro movlh!  dest*,src*                {
      lda     immediate+((src) and $ff)
      sta     lo_#dest
      lda     immediate+((src) shr 8)
      sta     hi_#dest                  }

macro ldxy    src       {
      ldx     src
      ldy     src+1     }
macro ldyx    src       {
      ldy     src
      ldx     src+1     }
macro ldxy!   src                       {
      ldx     immediate+((src) and $ff)
      ldy     immediate+((src) shr 8)   }
macro ldyx!   src                       {
      ldy     immediate+((src) and $ff)
      ldx     immediate+((src) shr 8)   }
macro styx    dst       {
      sty     dst
      stx     dst+1     }
macro stxy    dst       {
      stx     dst
      sty     dst+1     }
;=============================================================================
;       block moves
;-----------------------------------------------------------------------------
macro xcopy op1*,op2*,op3       {
local .xcopyloop
if op3 eq
      db $a2,(len_#op2)-1
else
      db $a2,op3  ;ldx! op3
end if
.xcopyloop:
      lda (op2)+x
      sta (op1)+x
      dex
      macro_bpl .xcopyloop      }


;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------
macro dex op1                   {
if op1 eq
      dex
else
      dex
      macro_bpl op1
end if                          }

macro dexnz op1*                {
      dex
      bne op1                   }

macro deynz op1*                {
      dey
      bne op1                   }

macro decnz op1*, op2*          {
      dec op1
      bne op2                   }

macro dexz op1*                 {
      dex
      beq op1                   }

macro deyz op1*                 {
      dey
      beq op1                   }

macro decz op1*, op2*           {
      dec op1
      beq op2                   }

macro dexpl op1*                {
      dex
      bpl op1                   }

macro deypl op1*                {
      dey
      bpl op1                   }

macro decpl op1*, op2*           {
      dec op1
      bpl op2                   }



macro inxnz op1*                {
      inx
      bne op1                   }

macro inynz op1*                {
      iny
      bne op1                   }

macro inxz op1*                 {
      inx
      beq op1                   }

macro inyz op1*                 {
      iny
      beq op1                   }



;-----------------------------------------------------------------------------
macro incw op1*         {
local .skipinchi
      inc op1
      macro_bne .skipinchi
      inc op1+1
.skipinchi:             }

macro inclh op1*        {
local .skipinchi
      inc lo_#op1
      macro_bne .skipinchi
      inc hi_#op1
.skipinchi:             }

macro decw op1*         {
local .skipdechi
      lda op1
      macro_bne .skipdechi
      dec op1+1
.skipdechi:
      dec op1           }

macro declh op1*        {
local .skipdechi
      lda lo_#op1
      macro_bne .skipdechi
      dec hi_#op1
.skipdechi:
      dec lo_#op1       }

;=============================================================================
;       8-bit math
;-----------------------------------------------------------------------------
macro add op1*,op2              {
      clc
if op2 eq
      adc op1
else
      lda op1
      adc op2
end if                          }
;--------------------------------------
macro add! op1*,op2             {
      clc
if op2 eq
      adc immediate+(op1)
else
      lda op1
      adc immediate+(op2)
end if                          }
;--------------------------------------
macro add.b op1*,op2*,op3        {
      clc
if op3 eq
      lda op1
      adc op2
      sta op1
else
      lda op2
      adc op3
      sta op1
end if                          }
;--------------------------------------
macro add.b! op1*,op2*,op3       {
      clc
if op3 eq
      lda op1
      adc immediate+(op2)
      sta op1
else
      lda op2
      adc immediate+(op3)
      sta op1
end if                          }
;-----------------------------------------------------------------------------
macro sub op1*,op2              {
      sec
if op2 eq
      sbc op1
else
      lda op1
      sbc op2
end if                          }
;--------------------------------------
macro sub! op1*,op2             {
      sec
if op2 eq
      sbc immediate+(op1)
else
      lda op1
      sbc immediate+(op2)
end if                          }
;--------------------------------------
macro sub.b op1*,op2*,op3        {
      sec
if op3 eq
      lda op1
      sbc op2
      sta op1
else
      lda op2
      sbc op3
      sta op1
end if                          }
;--------------------------------------
macro sub.b! op1*,op2*,op3       {
      sec
if op3 eq
      lda op1
      sbc immediate+(op2)
      sta op1
else
      lda op2
      sbc immediate+(op3)
      sta op1
end if                          }
;-----------------------------------------------------------------------------
macro cmp op1*,op2              {
if op2 eq
      cmp op1
else
      lda op1
      cmp op2
end if                          }
;--------------------------------------
macro cmp! op1*,op2             {
if op2 eq
      cmp immediate+(op1)
else
      lda op1
      cmp immediate+(op2)
end if                          }
;--------------------------------------
macro cpx op1*,op2              {
if op2 eq
      cpx op1
else
      ldx op1
      cpx op2
end if                          }
;--------------------------------------
macro cpx! op1*,op2             {
if op2 eq
      cpx immediate+(op1)
else
      ldx op1
      cpx immediate+(op2)
end if                          }
;--------------------------------------
macro cpy op1*,op2              {
if op2 eq
      cpy op1
else
      ldy op1
      cpy op2
end if                          }
;--------------------------------------
macro cpy! op1*,op2             {
if op2 eq
      cpy immediate+(op1)
else
      ldy op1
      cpy immediate+(op2)
end if                          }
;=============================================================================
;       16-bit math
;-----------------------------------------------------------------------------
macro add.w op1*,op2*,op3  {
      clc
if op3 eq
      lda op1
      adc op2
      sta op1
      lda 1+op1
      adc 1+op2
      sta 1+op1
else
      lda op2
      adc op3
      sta op1
      lda 1+op2
      adc 1+op3
      sta 1+op1
end if                     }
;--------------------------------------
macro add.w! op1*,op2*,op3  {
      clc
if op3 eq
      lda op1
      adc immediate+((op2) and $ff)
      sta op1
      lda 1+op1
      adc immediate+((op2) shr 8)
      sta 1+op1
else
      lda op2
      adc immediate+((op3) and $ff)
      sta op1
      lda 1+op2
      adc immediate+((op3) shr 8)
      sta 1+op1
end if                     }
;--------------------------------------
macro add.lh op1*,op2*,op3  {
      clc
if op3 eq
      lda lo_#op1
      adc lo_#op2
      sta lo_#op1
      lda hi_#op1
      adc hi_#op2
      sta hi_#op1
else
      lda lo_#op2
      adc lo_#op3
      sta lo_#op1
      lda hi_#op2
      adc hi_#op3
      sta hi_#op1
end if                     }
;--------------------------------------
macro add.lh! op1*,op2*,op3  {
      clc
if op3 eq
      lda lo_#op1
      adc immediate+((op2) and $ff)
      sta lo_#op1
      lda hi_#op1
      adc immediate+((op2) shr 8)
      sta hi_#op1
else
      lda lo_#op2
      adc immediate+((op3) and $ff)
      sta lo_#op1
      lda hi_#op2
      adc immediate+((op3) shr 8)
      sta hi_#op1
end if                     }
;--------------------------------------
macro sub.w op1*,op2*,op3  {
      sec
if op3 eq
      lda op1
      sbc op2
      sta op1
      lda 1+op1
      sbc 1+op2
      sta 1+op1
else
      lda op2
      sbc op3
      sta op1
      lda 1+op2
      sbc 1+op3
      sta 1+op1
end if                     }
;--------------------------------------
macro sub.w! op1*,op2*,op3  {
      sec
if op3 eq
      lda op1
      sbc immediate+((op2) and $ff)
      sta op1
      lda 1+op1
      sbc immediate+((op2) shr 8)
      sta 1+op1
else
      lda op2
      sbc immediate+((op3) and $ff)
      sta op1
      lda 1+op2
      sbc immediate+((op3) shr 8)
      sta 1+op1
end if                     }
;--------------------------------------
macro sub.lh op1*,op2*,op3  {
      sec
if op3 eq
      lda lo_#op1
      sbc lo_#op2
      sta lo_#op1
      lda hi_#op1
      sbc hi_#op2
      sta hi_#op1
else
      lda lo_#op2
      sbc lo_#op3
      sta lo_#op1
      lda hi_#op2
      sbc hi_#op3
      sta hi_#op1
end if                     }
;--------------------------------------
macro sub.lh! op1*,op2*,op3  {
      sec
if op3 eq
      lda lo_#op1
      sbc immediate+((op2) and $ff)
      sta lo_#op1
      lda hi_#op1
      sbc immediate+((op2) shr 8)
      sta hi_#op1
else
      lda lo_#op2
      sbc immediate+((op3) and $ff)
      sta lo_#op1
      lda hi_#op2
      sbc immediate+((op3) shr 8)
      sta hi_#op1
end if                     }
;-----------------------------------------------------------------------------
macro cp.w op1*,op2*             {
local .compdone
      lda op1+1
      cmp op2+1
      bcc .compdone
      bne .compdone
      lda op1
      cmp op2
.compdone:                       }

;--------------------------------------
macro cp.w! op1*,op2*            {
local .compdone
      lda op1+1
      cmp immediate+((op2) shr 8)
      bcc .compdone
      bne .compdone
      lda op1
      cmp immediate+((op2) and $ff)
.compdone:                       }













;-----------------------------------------------------------------------------
macro and op1*,op2              {
if op2 eq
      and op1
else
      lda op1
      and op2
end if                          }
;-----------------------------
macro and! op1*,op2             {
if op2 eq
      and immediate+(op1)
else
      lda op1
      and immediate+(op2)
end if                          }
;-----------------------------
macro and.b op1*,op2,op3         {
if op3 eq
      lda op1
      and op2
      sta op1
else
      lda op2
      and op3
      sta op1
end if                          }
;-----------------------------
macro and.b! op1*,op2,op3        {
if op3 eq
      lda op1
      and immediate+(op2)
      sta op1
else
      lda op2
      and immediate+(op3)
      sta op1
end if                          }
;-----------------------------------------------------------------------------
macro or op1*,op2               {
if op2 eq                                    
      ora op1
else
      lda op1                                
      ora op2
end if                          }
;-----------------------------
macro or! op1*,op2              {
if op2 eq                                    
      ora immediate+(op1)
else
      lda op1                                
      ora immediate+(op2)
end if                          }
;-----------------------------
macro or.b op1*,op2,op3          {
if op3 eq
      lda op1                                
      ora op2
      sta op1
else
      lda op2                                
      ora op3
      sta op1                                
end if                          }
;-----------------------------
macro or.b! op1*,op2,op3         {
if op3 eq
      lda op1                                
      ora immediate+(op2)
      sta op1
else
      lda op2                                
      ora immediate+(op3)
      sta op1                                
end if                          }
;-----------------------------------------------------------------------------
macro xor op1*,op2              {
if op2 eq                                    
      eor op1
else
      lda op1                                
      eor op2
end if                          }
;-----------------------------
macro xor! op1*,op2             {
if op2 eq                                    
      eor immediate+(op1)
else
      lda op1                                
      eor immediate+(op2)
end if                          }
;-----------------------------
macro xor.b op1*,op2,op3         {
if op3 eq
      lda op1                                
      eor op2
      sta op1
else
      lda op2
      eor op3
      sta op1
end if                          }
;-----------------------------
macro xor.b! op1*,op2,op3        {
if op3 eq
      lda op1                                
      eor immediate+(op2)
      sta op1
else
      lda op2
      eor immediate+(op3)
      sta op1
end if                          }
;-----------------------------------------------------------------------------



macro xloop op1*,op2=.loop      {
      inx
      cpx op1
      macro_bne op2             }

macro xloop! op1*,op2=.loop     {
      inx
      cpx immediate+(op1)
      macro_bne op2             }

macro xcount op1*,op2=.done     {
      inx
      cpx op1
      macro_beq op2             }

macro xcount! op1*,op2=.done    {
      inx
      cpx immediate+(op1)
      macro_beq op2             }

;-----------------------------------------------------------------------------
macro ror8 op1 {
if op1 eq
      cmp immediate+$80
      ror
else
      lda op1
      cmp immediate+$80
      ror op1
end if         }

macro rol8 op1 {
if op1 eq
      cmp immediate+$80
      rol
else
      lda op1
      cmp immediate+$80
      rol op1
end if         }


macro swp {
 asl
 adc immediate+$80
 rol
 asl
 adc immediate+$80
 rol       }


macro set! op1*,op2* {
 lda op1
 ora immediate+(op2)
 sta op1              }

macro exc op1*,op2* {
 lda op1
 pha
 lda op2
 sta op1
 pla
 sta op2            }

macro add_wy op1*  {
local .skip
      tya
      clc
      adc     op1
      sta     op1
      bcc .skip
      inc     op1+1
.skip:               }

;=============================================================================
;       UNOFFICIAL
;=============================================================================

if unofficial_opcodes > 0
macro lax op1* {
                 if op1 <= $ff
                  .db  $a7,op1
                 else if op1 <= $ffff
                  .dbw $af,op1
                 else if op1 <= $ff+indexed_Y
                  .db  $b3,op1-indexed_Y
                 else if op1 <= $ffff+indexed_Y
                  .dbw $bf,op1-indexed_Y
                 end if  }
else
macro lax op1* {
                 if op1 <= $ff
                  .db  $a5,op1,$aa
                 else if op1 <= $ffff
                  .dbw $ad,op1,$aa
                 else if op1 <= $ff+indexed_Y
                  .db  $b1,op1-indexed_Y,$aa
                 else if op1 <= $ffff+indexed_Y
                  .dbw $b9,op1-indexed_Y,$aa
                 end if  }
end if

;-----------------------------------------------------------------------------


;=============================================================================
macro .orgpad op1,op2 {if op2 eq
                         .db (op1-$) dup $ff
                      else
                         .db (op1-$) dup op2
                      end if
                      org op1}
macro .pad op1,op2    {if op2 eq
                         .db (op1-$) dup $ff
                      else
                         .db (op1-$) dup op2
                      end if }


;=============================================================================
;       MACRO INSTRUCTIONS
;-----------------------------------------------------------------------------

;=============================================================================
;       MACRO DATA
;-----------------------------------------------------------------------------
macro lendata op1* { macro end#op1 \{ end#op1: \}
#op1:
len_#op1 = end#op1 - #op1 }

macro lenbin op1*,[op2*] {
common
#op1:
len_#op1 = end#op1 - #op1
forward
.incbin #op2
common
end#op1:               }

macro len tablename*,datatype*,[data*] {
common
#tablename:
len_#tablename = end#tablename - #tablename
forward
#datatype data
common
end#tablename:               }
;----------------------------------------
macro .rts_table tablename*,subname*,subnumber*,filler*,tablesize*, [word*] {
number = subnumber
common
#tablename:
forward
.dw word-1
#subname#word   =  number
number = number + 1
common
.dw (tablesize-($-tablename))/2 dup filler           }
;-----------------------------------------------------------------
macro .word_table tablename*,subname*,subnumber*,filler*,tablesize*, [word*] {
number = subnumber
common
#tablename:
forward
.dw word
#subname#word   =  number
number = number + 1
common
.dw (tablesize-($-tablename))/2 dup filler           }
;-----------------------------------------------------------------
macro .lohi_table tablename*,subname*,subnumber*,filler*,tablesize*, [word*] {
number = subnumber
common
lo_#tablename:
forward
.dl word
#subname#word   =  number
number = number + 1
common
.dl (tablesize-($-lo_#tablename)) dup filler
hi_#tablename:
forward
.dh word
common
.dh (tablesize-($-hi_#tablename)) dup filler                }

;=============================================================================
;       HEADERS
;-----------------------------------------------------------------------------
NROM_V  = $0000
NROM_H  = $0001
UxROM_V = $0020
UxROM_H = $0021
AxROM   = $0070
MMC1    = $0011
MMC2    = $0090
MMC3    = $0040
MMC5    = $0050
VRC6    = $1080
VRC7    = $5050
FME7    = $4050
N106    = $1030
PINBOT  = $7070
macro inesheader prg=32,chr=8,board=NROM_H,batt=0,four=0 {
      format binary as "NES"
         db $4e,$45,$53,$1a
         db prg shr 4,chr shr 3
         dw board or (batt shl 1) or (four shl 4)
         dq 0 }
.inesheader fix inesheader
;-----------------------------------------------------------------------------
macro nsfheader songs=1,load=$8000,init=$8000,play=$8003,\
      title="<?>",artist="<?>",copyright="<?>",extra=0 {
      format binary as "NSF"
         db $4E,$45,$53,$4D,$1A,$01  ;NSF file
         db songs,$01                ;total songs/starting song
         dw load,init,play
      t.:db title,$00     ,$20-($-t.) dup $00
      a.:db artist,$00    ,$20-($-a.) dup $00
      c.:db copyright,$00 ,$20-($-c.) dup $00
         dw $411A                            ;NTSC speed
         db $00,$00,$00,$00,$00,$00,$00,$00  ;Bankswitch Init Values
         dw $0000                            ;Pal speed
         db $00                              ;NTSC/PAL
         db extra                            ;Extra sound chip
         dd 0 }
.nsfheader fix nsfheader

;=============================================================================
;       DATA
;-----------------------------------------------------------------------------
macro .dmcfile op1 {
align 64
DMC_START#op1:
file `op1
DMC_END#op1:
adr_#op1 = (DMC_START#op1 shr 6) and $00ff
len_#op1 = (((DMC_END#op1 - DMC_START#op1) shr 4 )-1) and $00ff }
;-----------------------------------------------------------------
macro .dmcfile_table tablename*, [dmcfile*] {
number = 1
common
#tablename:
.db 0,0

forward
.db adr_#dmcfile,len_#dmcfile
dmc_#dmcfile   =  number
number = number + 1

forward
align 64
DMC_START#dmcfile:
file `dmcfile
DMC_END#dmcfile:
adr_#dmcfile = (DMC_START#dmcfile shr 6) and $00ff
len_#dmcfile = (((DMC_END#dmcfile - DMC_START#dmcfile) shr 4 )-1) and $00ff   }
;-----------------------------------------------------------------
macro palettefile op1*      {
count = 1
rept 4 \{ file op1:count,3
         count = count+4 \} }





