include "flat6502.inc"

nsf_file        = 0
debug           = 0 ;what is matrix? hold select to move meatballs
cputest         = 0 ;2001 mono bit

if nsf_file = 1
nsfheader 1,$c000,INIT_NSF,SOUND_BLASTER,"jupiter2","khaos","2012"
else
inesheader 16,8,NROM_H
end if
;=============================================================================
;       MEMMAP
;=============================================================================
COLOR_MASK              = $40
MEATBALL_EXPLODE_TIME   = $12
MEATBALL_NORMAL_FRAME   = $d9
MEATBALL_EXPLODE_FRAME  = $dd
MEATBALL_NUMBER_EASY    = 5
MEATBALL_NUMBER_NORMAL  = 10
MEATBALL_NUMBER_HARD    = 28

LIMIT_UP                = $18
LIMIT_DOWN              = $C0
LIMIT_LEFT              = $70
LIMIT_RIGHT             = $90

LAZER_SPEED             = $07

SCORE_ADDRESS           = $2362
HI_SCORE_ADDRESS        = $2378
DIFFICULTY_ADDRESS      = $236C

mask01                  = $b0
mask02                  = $b1
mask04                  = $b2
mask08                  = $b3
mask10                  = $b4
mask20                  = $b5
mask40                  = $b6
mask80                  = $b7
mask03                  = $b8
mask07                  = $b9
mask0f                  = $ba

lazer0_x                = $c2
lazer1_x                = $c3
lazer2_x                = $c4
lazer0_y                = $c5
lazer1_y                = $c6
lazer2_y                = $c7

player_stat             = $c8
player_x                = $c9
player_y                = $ca
pal_cycle_pointer       = $cb

meatball_number         = $ce
player_frame            = $cf

jupiter_scroll_lo       = $d0
jupiter_scroll_hi       = $d1
start_mode              = $d2

oam_base1               = $d3
oam_base2               = $d4

europa_logo_y           = $d8
europa_logo_x           = $d9
europa_logo_atari       = $da

start_game_flag         = $e0
level_timer             = $e1
player_speed_y          = $e3
player_speed_x          = $e5

scrolldisable           = $e7
scoreadd                = $e8
rgbmodeback             = $e9
rgbmode                 = $ea
tintvalue               = $eb
palntsc_counter         = $ec
tmp_a                   = $ed
tmp_x                   = $ee
tmp_y                   = $ef

pad_hold                = $f0
pad2_hold               = $f1
pad_tap                 = $f2
pad2_tap                = $f3
pad_release             = $f4
pad2_release            = $f5
 B_RIGHT                  = $01
 B_LEFT                   = $02
 B_DOWN                   = $04
 B_UP                     = $08
 B_START                  = $10
 B_SELECT                 = $20
 B_B                      = $40
 B_A                      = $80

timer1                  = $f6
z2005x                  = $f7
oam_base                = $f8
nmi_check               = $f9
game_mode               = $fa
framecount              = $fc
pausemode               = $fd
oambase                 = $fe
z2000                   = $ff

pal_buffer              = $140
bg_pal0_1               = pal_buffer +$00    
bg_pal0_2               = pal_buffer +$01    
bg_pal0_3               = pal_buffer +$02    
bg_pal1_1               = pal_buffer +$03    
bg_pal1_2               = pal_buffer +$04    
bg_pal1_3               = pal_buffer +$05    
bg_pal2_1               = pal_buffer +$06    
bg_pal2_2               = pal_buffer +$07    
bg_pal2_3               = pal_buffer +$08    
bg_pal3_1               = pal_buffer +$09    
bg_pal3_2               = pal_buffer +$0A    
bg_pal3_3               = pal_buffer +$0B    
obj_pal0_1              = pal_buffer +$0C    
obj_pal0_2              = pal_buffer +$0D    
obj_pal0_3              = pal_buffer +$0E    
obj_pal1_1              = pal_buffer +$0F    
obj_pal1_2              = pal_buffer +$10    
obj_pal1_3              = pal_buffer +$11    
obj_pal2_1              = pal_buffer +$12    
obj_pal2_2              = pal_buffer +$13    
obj_pal2_3              = pal_buffer +$14    
obj_pal3_1              = pal_buffer +$15    
obj_pal3_2              = pal_buffer +$16    
obj_pal3_3              = pal_buffer +$17    
bg_palette              = pal_buffer +$18

ppu_buffer              = $300
                        ; $300 ppu address hi
                        ; $301 ppu address lo
                        ; $302 drawcode
score_print             = $303
hiscore_print           = $319

difficulty_text         = $30b

meatball_tile           = $400
meatball_atari          = $420
meatball_timer          = $440
meatball_stat           = $460
meatball_x              = $480
meatball_y              = $4a0

lo_europa_scroll_0      = $680
hi_europa_scroll_0      = $690
euro_scroll_delay       = $7e0

random0                 = $7d8
random1                 = $7d9
random2                 = $7da
random3                 = $7db
random4                 = $7dc
random5                 = $7dd
random6                 = $7de
random7                 = $7df

hi_score_lo             = $7f0
hi_score_hi             = $7f1
hi_score_lo_norm        = $7f2
hi_score_hi_norm        = $7f3
hi_score_lo_hard        = $7f4
hi_score_hi_hard        = $7f5

score_lo                = $7f6
score_hi                = $7f7

difficulty_level        = $7f8
;=============================================================================
;       PRG-ROM
;=============================================================================
.org $c000
lenbin jovian_scene,"jupibg.nam","jupibg2.nam"
;=============================================================================
RST:
                sei
                cld
                ldx!    $ff
                txs
                inx
                stx     2000h,2001h,4010h
                mov!    4017h, $60
.wait_ppu:      bit     2002h
                bpl     .wait_ppu
                asl
                bne     .wait_ppu

                ldy!    $07
                ldx!    $10
                cpy     mask07
                bne     .cold_boot
                cpx     mask10
                bne     .cold_boot
                dey
.cold_boot:     sty     1
                sta     0
                tay
.set_mem:       sta     (0)+y
                dey
                bne     .set_mem
                dec     1
                bpl     .set_mem

                sec
                tax
.load_bits:     inx
                rol
                sta     mask01-1  +x
                bpl     .load_bits

                dex
                lda!    $a9
              @ rol
                sta     random0+x
                dex @l

                mov!    mask03, $03
                mov!    mask07, $07
                mov!    mask0f, $0f

                lda!    $a8
                sta     z2000, 2000h

                call    init_stuff
                call    init_background
                mov!    song_number, 1
                call    INIT_BLASTER
                call    init_title
                mov!    nmi_check, $80
                mov!    game_mode, $40
                mov!    difficulty_level, $01

spiral_architect: jmp FRAMELOOP
;=============================================================================
lendata INIT_PALETTE
palettefile 'jupibg.pal'
palettefile 'jupiobj.pal'
.hx 8f
endINIT_PALETTE

;lendata INIT_PALETTE_RGB
;palettefile 'jupibgrgb.pal'
;palettefile 'jupiobjrgb.pal'
;.hx 8f
;endINIT_PALETTE_RGB

len STATUSBAR,db,\
$23,$62,28,       \
$00,$00,$00,$00,$00,$00,$20, \
$20,$20,$20,$16,$00,$19,$15,$0a,$14,$20,$20,$20,$11,$01, \
$20,$00,$00,$00,$00,$00,$00, \
0

SCROLL_SCANLINES_NTSC: .hex 64,5c,4d,3d,2d,2d,2d,46,01
SCROLL_SCANLINES_PAL: .hex 60,50,48,3A,2A,2A,2A,40,01
align $100
init_stuff:

                xcopy   $300,STATUSBAR
                xcopy   $140,INIT_PALETTE

                mov!    nmi_check, $00
              @ bit     nmi_check
                bvc @l

                mov!    nmi_check, $00
              @ inx
                bit     nmi_check
                bvc @l

                stx     $7ff
                cpx!    $70   ;ntsc 82, pal 33, dendy 48
                bcs     .ntsc
                cpx!    $40
                bcs     .dendy

.pal:           xcopy   euro_scroll_delay,SCROLL_SCANLINES_PAL, $08
                mov!    tintvalue, COLOR_MASK xor $60
                ret

.dendy:         xcopy   euro_scroll_delay,SCROLL_SCANLINES_NTSC, $08
                mov!    tintvalue, COLOR_MASK xor $60
                ret

.ntsc:          xcopy   euro_scroll_delay,SCROLL_SCANLINES_NTSC, $08
                mov!    tintvalue, COLOR_MASK
                ret
;=============================================================================
init_background:
                ldah    jovian_scene
                sta     1
                ldx!    $08
                bit     2002h
                mov!    2006h, $20
                lda!    $00
                sta     0, 2, 2006h
                call    LOAD_PPU
                bit     2002h
                mov!    2006h, $3f
                stx     2006h
                ldx!    $20
                call    LOAD_PPU.byteloop
                ret
;=============================================================================

;=============================================================================
init_game:
                mov!    oam_base1, $20
                mov!    oam_base2, $90

                movw!   level_timer,$140

                ldx     difficulty_level
                mov     meatball_number, TBL_MEATBALL_NUMBER +x

                mov!    player_stat, $00
                ldx!    $14
                lda!    $ef
              @ sta     $200+x
                inxnz @l

                tra!    $ef, lazer0_y,lazer1_y,lazer2_y
                tra!    $d7, $215,$219,$21d
                tra!    $01, $216,$21a,$21e

                ldx!    $00
.loop:          mov     meatball_timer +x, MEATBALL_DELAY +x
                call    random_accu
                ldy     difficulty_level
                beq @s
                and!    $c0
              @ sta     meatball_atari +x
                tra!    $e0, meatball_x +x, meatball_y +x
                xloop!  28

                mov!    $200,$ac
                mov!    $201,$e1
                mov!    $202,$20
                mov!    $203,$f8

                ret
MEATBALL_DELAY:
.db $0f,$1e,$2d,$3c, $4b,$5a,$69,$78, $87,$96,$a5,$b4, $c3,$d2,$e1,$f0
.db $01,$12,$23,$34, $45,$56,$67,$78, $88,$97,$a6,$b5, $c4,$d3,$e2,$f1
                     
len data_player_init,db,                \
$e0,$d1,$02,$00,                        \
$e0,$d3,$02,$00, $e0,$d3,$42,$00,       \
$e0,$d5,$01,$00
;=============================================================================
init_title:

                mov!    oam_base1, $60
                mov!    oam_base2, $e0


                mov!    meatball_number, $08
                mov!    europa_logo_x, $28
                mov!    europa_logo_y, $a0
                mov!    start_mode, $0
                ldx!    $14
                lda!    $ef
              @ sta     $200+x
                inxnz @l

                ldxy!    $0
              @ iny
                mov     $220+y, JUPITER_LOGO_DATA +x
                inx
                iny
                mov!    $220+y, $00
                iny
                mov     $220+y, JUPITER_LOGO_DATA +x
                iny
                inx
                cpx!    $20
                bcc @l
                mov!    $25e, $c0


                ldx!    $0
              @ mov     meatball_tile +x, TBL_OPERATION_EUROPA_left +x
                mov!    meatball_atari +x, $0
                xloop   meatball_number, @l

                movw!   0, data_player_init
                ldyl    len_data_player_init-1
              @ mov     $204+y, (0)+y
                deypl @l

                mov!    player_y, $e0
                mov!    player_x, $78
                mov!    player_frame, $00
                mov!    start_game_flag, $80

                mov!    $200,$ac
                mov!    $201,$e1
                mov!    $202,$20
                mov!    $203,$f8

                ret
JUPITER_LOGO_DATA:
;J
.db $01,$50, $03,$48, $05,$50
;upiter
.db $07,$5b, $09,$66, $0b,$71
.db $0d,$79, $0f,$83, $11,$8e
;scope 2
.db $13,$5b, $15,$66, $17,$71, $09,$7c, $0f,$87
.db $19,$99, $19,$a1

TBL_OPERATION_EUROPA_left:
;    o p e r a t i o n _ e u r o p a
.hex 1b, 1f, 23, 27, 2b, 2f, 33, 37
;TBL_OPERATION_EUROPA_right:
;.hex   1d, 21, 25, 29, 2d, 31, 35, 39
;=============================================================================
FRAMELOOP:      bit     nmi_check
                bvc     FRAMELOOP

                mov!    nmi_check, $00

                jsr     THE_GAME

                mov!    nmi_check, $80

                jnz     FRAMELOOP
;=============================================================================
THE_GAME:
if cputest=1
               mov!    2001h,$19 or (COLOR_MASK xor $e0)
else
                or.b!   2001h, tintvalue, $18 or COLOR_MASK
end if
           ;      call    SOUND_BLASTER

         ;       ldx     $7ff
         ;       cpx!    $58   ;ntsc 82, pal 33, dendy 48
         ;       bcc @s
         ;      dec     palntsc_counter
         ;      bpl @s
         ;      mov!    palntsc_counter, $5
         ;      jmp     .skipframe
         ;    @
                call    SOUND_BLASTER

                call    PADREAD

                call    ModeSelect

  ;             ldy!    17
  ;  .lag:      ldx!    $ff
  ;           @ dex
  ;             bne @b
  ;             dey
  ;             bne .lag
                ;-------------------------------

.skipframe:    or.b!   2001h, tintvalue, $18 or COLOR_MASK

                call    EUROPA_SCROLL
                mov!    2001h, $08
                mov!    2000h, $a8

                rts



;=============================================================================
db "Jupiter Scope 2 by nin-kuuku 2012,2017. "
db "Thanks: Tomaz Grysztar (flat assembler). "
db "shiru (NES Screen Tool). "
db "NESdev and AtariAge (info and ideas). "
db "Active Enterprise (original Jupiter Scope). "
db "NASA (jovian pictures). "
align $100
NMI:            pha
                txa
                pha
                tya
                pha

                bit     2002h
                bit     nmi_check
                bmi     .oam_dma
                lda!    $40
                jmp     .skip_nmi

.oam_dma:       ldy!    $00
                sty     2001h, 2003h
                mov!    4014h, $02


.color_buffer:  lda     $158      ;bg_color stopbit
                bpl     .skip_color
                tsx
                stx     0
                ldx!    $3f
                txs                     ;pal_buffer at $0140
                stx     2006h
                sty     2006h   ;y=00
                tax
                pla
              @ stx     2007h
                sta     2007h           ;load 3 colors
                pla
                sta     2007h
                pla
                sta     2007h
                pla
                bpl @l                  ;loop until stopbit
                ldx     0
                txs

.skip_color:    ldxy!   $300
                call    PPU_DRAW

                bit     2002h
                mov     2005h, jupiter_scroll_hi
                mov!    2005h, $00
                mov     2000h, z2000
                mov!    2001h, $18 or COLOR_MASK

                inc     framecount
                call    RANDOMIZER
                exc     oam_base1, oam_base2

                lda!    $c0
.skip_nmi:      sta     nmi_check
                pla
                tay
                pla
                tax
                pla

IRQ:            rti
;-----------------------------------------------------------------------------
ModeSelect:     bit     game_mode
                bvs TitleScreen
                bmi .ingame
                rts

.ingame:        jmp InGame
;=============================================================================
TitleScreen:    lda     start_game_flag       ;test logo fade anim
                bne     .no_control               ;zero = no animation
                call    TITLE_CONTROL
                call    rgbhack

                and!    pad_tap, B_A
                beq     @f
                xor.b!  scrolldisable, $80
              @
                and!    pad_tap, B_START
                beq     .game_start
                mov!    start_game_flag, $40  ;set logo fadeout anim
                lda!    $00
                sta     score_lo, score_hi

.no_control:    bpl     .game_start               ;test logo fadein anim
                cmp!    europa_logo_y, JUPI_SHOW
                bcs     .game_start
                asl     start_game_flag       ;enable title control

.game_start:
                call    OPERATION_EUROPA
                call    PLAYER_OBJ
                call    SPRITES.Meatball
                bit     scrolldisable
                bmi @f
                call    SCROLL
              @
                call    PRINT_HISCORE

                bit     start_game_flag       ;test logo fadeout anim
                bvc     .no_start
                ;lda     difficulty_level
                ;beq     .exit
                dec     player_y
                dec     player_y
                bmi     .no_start

                call    init_game
                mov!    game_mode, $80

.no_start:      ret
.exit:          ;ijmp    0fffch
;=============================================================================
InGame:         call    COLOR_CYCLE

                bit     player_stat
                bvc @s
                jmp     GameOver

              @ and!    pad_tap, B_START
                beq @s
                xor.b!  pausemode, $80
              @ bit     pausemode
                bmi     .pause
if debug=1
                @ and!    pad_hold, B_SELECT
                beq .deb
end if
                call    MEATBALLMOVE
        .deb:
                call    PLAYERMOVE
                call    PLAYERSHOOT
                call    LAZERMOVE
                call    LAZER_MEATBALL_HIT
                call    PLAYER_MEATBALL_HIT
                call    MEATBALL_STATUS

                call    PRINT_SCORE
              ;  cmp!    meatball_number, 28
              ;  bcs     .skip_inclevel

                sub.w   level_timer, meatball_number
                bcs     .skip_inclevel


                cmp!    meatball_number, 28
                bcs @f
                inc     meatball_number
              @ movw!   level_timer, $666
                lda     meatball_number
                call    ADD_SCORE
.skip_inclevel:

.pause:
                call    SPRITES.Lazer
                call    PLAYER_OBJ
                call    SPRITES.Meatball

                ret
;-----------------------------------------------------------------------------
GameOver:       call    PLAYER_OBJ
                call    SPRITES.Meatball
                call    MEATBALL_STATUS

                cmp!    timer1, $0c
                bcs @s
                mov!    player_frame, $05
              @
                dec     timer1
                bne     .skip

                lda     difficulty_level
                asl
                tax
                cp.w    score_lo, hi_score_lo+x
                bcc     .no_record

.new_record:    mov     hi_score_lo+x, score_lo
                mov     hi_score_hi+x, score_hi

.no_record:     call    init_title
                mov!    game_mode, $40

.skip:          ret
;=============================================================================
PRINT_HISCORE:  lda     difficulty_level
                asl
                tax
                lda     hi_score_lo+x
                ldy     hi_score_hi+x
                call    SCORE_CONVERT
                sty     0+hiscore_print
                stx     1+hiscore_print
                sta     2+hiscore_print
                mov     3+hiscore_print,1
                mov     4+hiscore_print,0

PRINT_SCORE:    lda     score_lo
                ldy     score_hi
                call    SCORE_CONVERT
                sty     0+score_print
                stx     1+score_print
                sta     2+score_print
                mov     3+score_print,1
                mov     4+score_print,0

                ret
;=============================================================================
LOAD_PPU:       ldy!    $0
.pageloop:      mov     2007h, (0)+y
                inynz .pageloop
                inc     1
                dexnz .pageloop

                ldx     2
                beq .done

.byteloop:      mov     2007h, (0)+y
                iny
                dexnz .byteloop

.done:          rts
;=============================================================================
PADREAD:        ldx!    $00
                call .padread
                inx

.padread:       mov     0, pad_hold+x
                pha
.padloop:       ldy     0
                lda!    $01
                sta     0, 4016h
                lsr
                sta     4016h
.getbits:       lda     4016h+x
                ror
                rol     0
                bcc .getbits
                cpy     0
                bne .padloop

                pla
                xor     0
                tay
                and     0
                sta     pad_tap+x
                tya
                xor     pad_tap+x
                sta     pad_release+x
                mov     pad_hold+x, 0

                rts
;=============================================================================
PPU_DRAW:
;Draw horizontal/vertical lines of sequence/repeat data.
;Dataformat: byte0 = destination Hi.
;            byte1 = destination Lo.
;            byte2 = drawcode
;                    bit7: 0=horizontal. 1=vertical
;                    bit6: 0=sequence. 1=repeat
;                    bit0-5: number of bytes
;            byte3 = start of sequence/repeat byte
;regs: a,x,y,zp0-zp2
;input:  x = source Lo.
;        y = source Hi.
;output: a = $00
;        x = $00
;        y = $00
                stxy    0
.Draw_loop:     ldy!    $0
                lda     (0)+y
                beq .ret

                bit     2002h
                sta     2006h
                iny

                mov     2006h, (0)+y
                iny
                lda     (0)+y
                iny
                sta     2
                and!    $3f
                tax
                bit     2
                bpl .hor_draw

                or.b!    2000h, z2000,$04
.hor_draw:      bvc .seq_draw

                lda     (0)+y
                iny
.rep_draw:      sta     2007h
                dexnz .rep_draw

                bvs .draw_done

.seq_draw:      mov     2007h, (0)+y
                iny
                dexnz .seq_draw

.draw_done:     mov     2000h, z2000

                tya
                add     0
                sta     0
                bcc .Draw_loop
                inc     1
                bcs .Draw_loop

.ret:           rts
;=============================================================================
SCORE_CONVERT:
;a,x,y,0,1
;input:  a = score_lo
;        y = score_hi
;output: 0 = deci 1
;        1 = deci 10
;        a = deci 100
;        x = deci 1000
;        y = deci 10000
                sty     1;score_hi
                call HEX_TO_DECI
                sta     0;score_00001
                tya
                add     1;score_hi
                stx     1;score_00010
;-----------------------------------------------------------------------------
HEX_TO_DECI:
;a,y,x,0
;input:  a = hex
;output: a = deci 1
;        x = deci 10
;        y = deci 100
                ldy!    $0
                cmp!    $c8
                bcc @s
                iny
                iny
                sbc!    $c8
                jmp .get_deci
              @ cmp!    $64
                bcc .get_deci
                iny
                sbc!    $64
.get_deci:      pha
                call DIV_10
                tax
                pla
                sub .sub_numbers+x

                rts

.sub_numbers: .db 0,10,20,30,40,50,60,70,80,90
;=============================================================================
DIV_10:         lsr
                sta     tmp_a
                lsr
                sec
                adc     tmp_a
                sta     tmp_a
rept 3        { lsr }
                adc     tmp_a
                adc     tmp_a
                ror
rept 3        { lsr }
                rts
;=============================================================================
ADD_SCORE:      add     score_lo
                sta     score_lo
                sub!    $64
                bcc @s
                sta     score_lo
                inc     score_hi

              @ rts
;=============================================================================
rgbhack:        and!    pad_tap, B_SELECT
                beq .skip
                xor!    song_number, 1
                sta     song_number
                call    INIT_BLASTER
              ;  lda     rgbmode
              ;  beq .rgb

              ;  xcopy   $140,INIT_PALETTE
              ;  mov     tintvalue, rgbmodeback
              ;  mov!    rgbmode, 0
              ;  beq     .skip

      ;   .rgb:  xcopy   $140,INIT_PALETTE_RGB
      ;          mov     rgbmodeback, tintvalue
      ;          mov!    tintvalue, 0
      ;          mov!    rgbmode, 1

         .skip: rts







;=============================================================================
MEATBALL_STATUS:ldx!    $0

.loop:          mov!    meatball_tile  +x, $d9
                ;mov!    meatball_atari +x, $00
                lda     meatball_timer +x
                beq .skip

                dec     meatball_timer +x
                bne @s

                mov!    meatball_y +x, $ef
                jnz .skip

              @ cmp!    meatball_timer +x, $06
                bcc @s
                xor.b!   meatball_y +x, $01
                xor.b!   meatball_x +x, $01
                mov!    meatball_tile  +x, $dd
                ;mov!    meatball_atari +x, $01
                jnz .skip

              @ xor.b!   meatball_x +x, $01
                xor.b!   meatball_x +x, $01
                mov!    meatball_tile  +x, $ed
                ;mov!    meatball_atari +x, $01

.skip:          xloop meatball_number
                rts


;=============================================================================
tbl_meatballspeed:
.db 1,2,2,3,2,2,1,2,2,3,2,2,1,2,2,3
.db 1,2,2,3,2,2,1,2,2,3,2,2,1,2,2,3
tbl_meatballmove:
.db 1,0,-1,0,0,1,-1,0,0,0,0,1,0,0,-1,0
.db 1,0,-1,0,0,1,-1,0,0,0,0,1,0,0,-1,0

MEATBALLMOVE:   lda     difficulty_level
                bne     .noslow
                lda     framecount
                lsr
                bcc .noslow
                rts
        .noslow:

                ldx!    $0

.loop:          lda     meatball_timer +x
                bne .skip
                add.b   meatball_x+x, tbl_meatballmove+x
                add.b   meatball_y+x, tbl_meatballspeed+x
                cmp!    $fe
                bcc .skip
                lda     random2
                sbc     random0
                ror
                sta     random2
                sta     meatball_x+x

.skip:          xloop meatball_number
                rts
;=============================================================================
PLAYERMOVE:
              ; and!    pad_tap, B_B
              ; beq .up
              ; jsr     SMARTBOMB








.up:            and!    pad_hold, B_UP
                beq .down
                ldx     player_y
                dex
                dex
                cpx!    LIMIT_UP
                bcs @s
                ldx!    LIMIT_UP
              @ stx     player_y

.down:          and!    pad_hold, B_DOWN
                beq .left
                ldx     player_y
                inx
                inx
                cpx!    LIMIT_DOWN
                bcc @s
                ldx!    LIMIT_DOWN
              @ stx     player_y

.left:          and!    pad_hold, B_LEFT
                beq .right
                cmp!    player_x, LIMIT_LEFT
                bit     scrolldisable
                bmi @f
                bcc .scroll_l
              @ dec     player_x
                dec     player_x
                jnz .right
.scroll_l:      bit     scrolldisable
                bmi @f
                call SCROLL.left
              @
.right:         and!    pad_hold, B_RIGHT
                beq .done
                cmp!    player_x, LIMIT_RIGHT
                bit     scrolldisable
                bmi @f
                bcs .scroll_r
             @  inc     player_x
                inc     player_x
                jnz .done
.scroll_r:      bit     scrolldisable
                bmi @f
                call SCROLL.right
              @
.done:          rts
;=============================================================================
JUPITER_SCROLL_SPEED = $20
.lohi EuropaScrollSpeed,\
$0000,$0220,$01A0,$0140,$00E0,$00A0,$0070,$0050,$0040

SCROLL:

.right:         add.b!   jupiter_scroll_lo, JUPITER_SCROLL_SPEED
                bcc .skip1
                inc     jupiter_scroll_hi
                bne .skip1
                xor.b!   z2000, $01

.skip1:         ldx!    $08
              @ add.lh   europa_scroll_0+x, EuropaScrollSpeed+x
                dexpl @l


                ldx!    $0
.declp:         dec     meatball_x +x
                dec     meatball_x +x
                xloop meatball_number, .declp

                dec     lazer0_x
                dec     lazer0_x
                dec     lazer1_x
                dec     lazer1_x
                dec     lazer2_x
                dec     lazer2_x

                rts

.left:          sub.b!   jupiter_scroll_lo, JUPITER_SCROLL_SPEED
                bcs .skip2
                ldx     jupiter_scroll_hi
                dex
                stx     jupiter_scroll_hi
                cpx!    $ff
                bne .skip2
                xor.b!   z2000, $01

.skip2:         ldx!    $08
              @ sub.lh   europa_scroll_0+x, EuropaScrollSpeed+x
                dexpl @l

                ldx!    $0
.incpl:         inc     meatball_x +x
                inc     meatball_x +x
                xloop meatball_number, .incpl

                inc     lazer0_x
                inc     lazer0_x
                inc     lazer1_x
                inc     lazer1_x
                inc     lazer2_x
                inc     lazer2_x

                rts

;=============================================================================
PLAYERSHOOT:    bit     pad_tap
                bpl .done
                ldx!    $00
                lda!    $ef
                cmp     lazer0_y+x
                beq .set_lazer
                inx
                cmp     lazer0_y+x
                beq .set_lazer
                inx
                cmp     lazer0_y+x
                bne .done

.set_lazer:     mov     lazer0_x+x, player_x
                dec     lazer0_x+x
                mov     lazer0_y+x, player_y
         ;      ldx!    32
         ;      mov     $778, lo_SOUND_DATA+x
         ;      mov     $779, hi_SOUND_DATA+x
                lda!    sfx_shoot
                ldx!    $a8
                jsr     SOUND_FX

.done:          rts
;=============================================================================
LAZERMOVE:      ldx!    $00
                call .move
                inx
                call .move
                inx
.move:          lda!    $ef
                cmp     lazer0_y+x
                bcc .stop_lazer
                beq .done
                lda     lazer0_y+x
                sub!    LAZER_SPEED
                ldy     difficulty_level
                bne @s
                add!    LAZER_SPEED-1
              @ cmp!    $f0
                bcc     .stop_lazer
                pha
                mov!    scoreadd, 0
                pla
.stop_lazer:    sta     lazer0_y+x
.done:          rts
;=============================================================================
Meatball_dot_Hit:
                lda     meatball_timer +x
                bne .done

                sec
                lda     meatball_y +x
                sbc     0;dot_x
                bcs .done
                adc!    $10
                bcc .done+1
                lda     meatball_x +x
                sbc!    $03
                sbc     1;dot_y
                bcs .done
                adc!    $16
                bcc .done+1
                rts

.done:          clc
                rts
;-----------------------------------------------------------------------------
LAZER_MEATBALL_HIT:
                ldx!    $0
                cmp!    lazer0_y+x, $ef
                bcs @s
                call .hit
              @ inx
                cmp!    lazer0_y+x, $ef
                bcs @s
                call .hit
              @ inx
                cmp!    lazer0_y+x, $ef
                bcs .ret

.hit:           stx     tmp_x
                lda     lazer0_y+x
                sta     0, 2
                mov     1, lazer0_x+x

                ldx! $ff
.loop:
xcount meatball_number
                call Meatball_dot_Hit
                bcc .loop

                txa
                pha
          ;     ldx!    33
          ;     mov     $768, lo_SOUND_DATA+x
          ;     mov     $769, hi_SOUND_DATA+x
                lda!    sfx_explode
                ldx!    $90
                jsr     SOUND_FX


                pla
                tax

                lda     scoreadd
                cmp!    $20
                bcs @f
                add!    1
                sta     scoreadd
              @ lda!    $02
                add     scoreadd
                call ADD_SCORE
                mov!    meatball_timer +x, MEATBALL_EXPLODE_TIME
                mov!    2, $ef
                jmp .loop

.done:          ldx     tmp_x
                mov     lazer0_y+x, 2
.ret:           rts
;-----------------------------------------------------------------------------
PLAYER_MEATBALL_HIT:
                lda     player_y;, $0c
                add!    3
                sta     0
                mov     1, player_x;, $04

                ldx! $ff
.loop:
xcount meatball_number
                call Meatball_dot_Hit
                bcc .loop

                txa
                pha
          ;     ldx!    33
          ;     mov     $768, lo_SOUND_DATA+x
          ;     mov     $769, hi_SOUND_DATA+x
                lda!    sfx_player_explode
                ldx!    $90
                jsr     SOUND_FX


                pla
                tax

                mov!    player_frame, $04
                mov!    timer1, $18
                or.b!    player_stat, $40
                mov!    meatball_timer +x, MEATBALL_EXPLODE_TIME
                mov!    2, $f8

.done:          rts
;=============================================================================
TBL_PLAYER_FRAMES:
.db PLAYER_FRAME_DATA.frame1 - PLAYER_FRAME_DATA
.db PLAYER_FRAME_DATA.frame2 - PLAYER_FRAME_DATA
.db PLAYER_FRAME_DATA.frame3 - PLAYER_FRAME_DATA
.db PLAYER_FRAME_DATA.frame4 - PLAYER_FRAME_DATA
.db PLAYER_FRAME_DATA.explosion1 - PLAYER_FRAME_DATA
.db PLAYER_FRAME_DATA.explosion2 - PLAYER_FRAME_DATA
.db PLAYER_FRAME_DATA.explosion3 - PLAYER_FRAME_DATA

PLAYER_FRAME_DATA:
.frame1: db -10,$D1,$02,-4,   -2,$D3,$02,-8,    -2,$D3,$42,0,   13,$A1,$01,-4
.frame2: db -10,$D1,$02,-4,   -2,$D3,$02,-8,    -2,$D3,$42,0,   13,$A3,$01,-4
.frame3: db -10,$D1,$02,-4,   -2,$D3,$02,-8,    -2,$D3,$42,0,   13,$A5,$01,-4
.frame4: db -10,$D1,$02,-4,   -2,$D3,$02,-8,    -2,$D3,$42,0,   13,$A7,$01,-4
.explosion1: db -8,$c1,$00,0,   8,$c1,$c0,0,    0,$c3,$00,-8,   0,$c3,$c0,8
.explosion2: db -10,$c5,$00,0,  10,$c5,$c0,0,   0,$c7,$00,-10,  0,$c7,$c0,10
.explosion3:


PLAYER_OBJ:     ldy     player_frame
                cpy!    $04
                bcs @s
                and!    framecount, $0c
                lsr
                lsr
                tay


              @ ldx     TBL_PLAYER_FRAMES+y
                ldy!    $0
.loop:          add.b    $204+y, PLAYER_FRAME_DATA+x, player_y
                inx
                iny
                mov     $204+y, PLAYER_FRAME_DATA+x
                inx
                iny
                mov     $204+y, PLAYER_FRAME_DATA+x
                inx
                iny
                add.b    $204+y, PLAYER_FRAME_DATA+x, player_x
                inx
                iny
                cpy!    $10
                bne .loop

                ret

SPRITES:
.Lazer:         mov     $214, lazer0_y
                mov     $217, lazer0_x
                mov     $218, lazer1_y
                mov     $21b, lazer1_x
                mov     $21c, lazer2_y
                mov     $21f, lazer2_x
                ret


.Meatball:      lda!    $02
                sta     1,3
                mov     0,oam_base1        ;left side
                mov     2,oam_base2        ;right side

                ldyx!   $0

.loop:          lda     meatball_y +x
                sta     (0)+y,(2)+y
                iny
                lda     meatball_tile +x
                sta     (0)+y
                add!    $02                ;load next 2 CHRs for right side
                sta     (2)+y
                iny
                lda     meatball_atari +x
                sta     (0)+y,(2)+y
                iny
                asl                        ;H-flip to carry
                asl
                lda     meatball_x +x
                bcc @s                     ;if H-flip set,
                sta     (2)+y              ; orginal X-cord to right side
                adc!    $07                ; X-cord + 8 to left side
                sec                        ; else the opposite
              @ sta     (0)+y
                bcs @s
                adc!    $08
                sta     (2)+y
              @ iny

                xloop meatball_number
                ret
;=============================================================================
align 256
EUROPA_SCROLL:
              @ bit     2002h
                bvs @l
              @ bit     2002h
                bvc @l

                ldx!    $08

.loop:          ldy     euro_scroll_delay+x;,TBL_SCROLL_DELAY +x
              @ nop
                deynz @l
                bit     2002h
                mov     2005h, hi_europa_scroll_0 +x
                mov!    2005h, $00
                dexpl .loop
                rts
align 1
;=============================================================================

tbl_lazer_pals:         .hex 30,31,24,27,29,2a,2b,3b
tbl_fire_pals1:         .hex 37,37,26,26,15,15,26,26
tbl_fire_pals2:         .hex 28,38,37,27,28,38,37,27
tbl_meatball_pals1:     .hex 25,26,27,27,28,27,26,26
tbl_meatball_pals2:     .hex 15,16,15,16,15,16,15,16
tbl_meatball_pals3:     .hex 3a,30,3a,30,3a,30,3a,30

COLOR_CYCLE:    ldx     pal_cycle_pointer
                mov     obj_pal0_1, tbl_meatball_pals1+x
                mov     obj_pal0_2, tbl_meatball_pals2+x
                mov     obj_pal0_3, tbl_meatball_pals3+x
                mov     obj_pal1_1, tbl_lazer_pals+x
                mov     obj_pal1_2, tbl_fire_pals1+x
                mov     obj_pal1_3, tbl_fire_pals2+x
                dex
                bpl @s
                ldx!    $07
              @ stx     pal_cycle_pointer
                rts

;=============================================================================
TBL_MEATBALL_NUMBER:
.db MEATBALL_NUMBER_EASY
.db MEATBALL_NUMBER_NORMAL
.db MEATBALL_NUMBER_HARD

TBL_DIFFICULTY:
.db TBL_DIFFICULTY_TEXT.easy - TBL_DIFFICULTY_TEXT
.db TBL_DIFFICULTY_TEXT.normal - TBL_DIFFICULTY_TEXT
.db TBL_DIFFICULTY_TEXT.hard - TBL_DIFFICULTY_TEXT

TBL_DIFFICULTY_TEXT:
.easy:   .hex     5d,5e,1d,0a,0c,13,1f,5d,5e
.normal: .hex     20,20,16,00,19,15,0a,14,20
.hard:   .hex     20,20,20,11,0a,19,0d,20,20

SET_DIFFICULTY_TEXT:
                ldx     difficulty_level
                lda     TBL_DIFFICULTY +x
                tax
                ldy!    $0
.loop:          mov     difficulty_text +y, TBL_DIFFICULTY_TEXT+x
                inx
                iny
                cpy!    $09
                bne .loop
                rts
;=============================================================================
TITLE_CONTROL:

                and!    pad_tap, B_LEFT
                beq .right
                ldx     difficulty_level
                beq .skip
                dex
                stx     difficulty_level
.right:         and!    pad_tap, B_RIGHT
                beq .skip
                cpx!    difficulty_level, $02
                beq .skip
                inx
                stx     difficulty_level
.skip:          call SET_DIFFICULTY_TEXT


                rts
;=============================================================================
JUPI_HIDE               = $a0
JUPI_FLICKER1           = $8C
JUPI_FLICKER2           = $78
JUPI_SHOW               = $64

LOGO_COLORS: .hex 12,08,1c, 00,2d,2b, 26,1a,3a

JUPITER_LOGO:
.db $28,$38,$38
.db $38,$38,$38
.db $38,$38,$38
.db $4A,$4A,$4A,$4A,$4A
.db $4A,$4A


OPERATION_EUROPA:
                lda     europa_logo_y
                bit     start_game_flag
                bvc @s
                cmp!    JUPI_HIDE
                bcs .sprites
                adc!    $03
                sta     europa_logo_y
                bcc .sprites

              @ bpl .sprites
                cmp!    JUPI_SHOW
                bcc .sprites
                sbc!    $03
                sta     europa_logo_y

.sprites:       call .jupiter_logo

                ldx     0
                ldy!    $02
              @ mov     obj_pal0_1+y ,LOGO_COLORS+x
                dex
                deypl @l

                ldy     europa_logo_y
                mov     1,europa_logo_x
                lda     europa_logo_atari

                ldx! $0
              @ sta     tmp_a
                tya
                sta     meatball_y +x
                lda     tmp_a
                sta     0, meatball_atari +x
                lda     1
                add!    $10
                sta     meatball_x +x, 1
                lda     0
                xloop meatball_number, @l

                rts
;--------------------------------------
.jupiter_logo:  cmp!    JUPI_HIDE
                bcc .skip1
                mov!    europa_logo_atari, $20
.hide:          ldx!    $0f
                ldy!    $0
              @ mov!    $220+y, $e0
                tya
                add!    $04
                tay
                dexpl @l
                rts

.skip1:         cmp!    JUPI_FLICKER1
                bcc .skip2
                mov!    europa_logo_atari, $20
                mov!    0, $02

.flicker:       lda     framecount
                lsr
                bcc .hide
                bcs .show

.skip2:         cmp!    JUPI_FLICKER2
                bcc .skip3
                mov!    europa_logo_atari, $00
                mov!    0, $05
                jnz .flicker

.skip3:         mov!    europa_logo_atari, $00
                mov!    0, $08

.show:          ldx!    $0
                ldy!    $0
              @ mov     $220+y, JUPITER_LOGO +x
                tya
                add!    $04
                tay
                inx
                cpx!    $10
                bne @l
                rts

;=============================================================================
if 0
SMARTBOMB:      lda!    sfx_explode
                ldx!    $90
                jsr     SOUND_FX

                ldx!    $0
.loop:          lda!    $05
                call ADD_SCORE
                mov     meatball_timer +x, MEATBALL_DELAY +x
                xloop meatball_number
                rts

end if

random_accu:    lda     random0
                asl
                bcs @s
                xor!    $cf
              @ sta     random0
                rts

include "blaster.asm"
include "apudata.asm"

;=============================================================================
.orgpad $FFFA,$00
.dw NMI,RST,IRQ
;=============================================================================
;       CHR-ROM
;=============================================================================
if nsf_file = 0
.org $0000
incbin "jupibg.chr"
incbin "jupiobj.chr"
.orgpad $2000,$00
end if



