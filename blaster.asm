;       NES APU driver v2 by nin-kuuku 2012
;=============================================================================
;       MEMMAP
DEFAULT_DMC_FRQ         = $0F
DEFAULT_DMC_VOL         = $40
DEFAULT_AUTOPORT        = $03
TRACKCOUNT              = 8
BlasterPage             = $700
BlasterZP               = $60

track_status    = BlasterZP+$00    ;00=disable track
                                   ;01=
                                   ;02=
                                   ;04=
                                   ;08=
                                   ;10=
                                   ;20=
                                   ;40=drum mode
                                   ;80=

effect_status   = BlasterZP+$01    ;0F:auto portamento value (0=off)
                                   ;30:vibrato table select (0=off)
                                   ;C0:tremolo table select (0=off)

track_tempo     = BlasterZP+$02    ;7F=framecounter
                                   ;80=stop track

track_tempodata = BlasterZP+$03
track_note      = BlasterZP+$04
track_sound     = BlasterZP+$05
lo_track_addr   = BlasterZP+$06
hi_track_addr   = BlasterZP+$07
lo_sound_addr   = BlasterZP+$08
hi_sound_addr   = BlasterZP+$09
pulse1_trans    = BlasterPage+$0A
track_loop      = BlasterPage+$0B
track_shortloop = BlasterPage+$0C
track_return    = BlasterPage+$0D
sound_return    = BlasterPage+$0E
noise_frq       = BlasterPage+$0F
shadow_sound    = BlasterPage+$10
sound_frame     = BlasterPage+$11  ;0F:counter
                                   ;F0:counter data

blaster_ram12   = BlasterPage+$12
triangle_trans  = BlasterPage+$13
limit_note      = BlasterPage+$14
track_volume    = BlasterPage+$15
tablecounter    = BlasterPage+$16
blaster_ram17   = BlasterPage+$17



z4000           = $40
z4004           = $41
z4002           = $42
z4003           = $43
z4007           = $44
z4006           = $45
z4008           = $46
z400a           = $47
z400b           = $48
z400c           = $49
z400e           = $4A
z400f           = $4B
z4010           = $4C
z4011           = $4D
z4012           = $4E
z4013           = $4F

pulse1_stat     = $50
pulse2_stat     = $51
triangle_stat   = $52
noise_stat      = $53
dmc_stat        = $54

pulse1_disreq   = $55
pulse2_disreq   = $56
triangle_disreq = $57

pulse1_retrig   = $59
pulse2_retrig   = $5a
dmc_retrig      = $5b

engine_stat     = $5c ;01 = pulse1 env
                      ;02 = pulse2 env


blaspage_offset = $5d
track_number    = $5e
song_number     = $5f

;=============================================================================
;       EQUS
SND             = SNDOc_Sound_Set
SND_FRQ         = SNDOc_Sound_Frq
SDW             = SNDOc_Shadow_Sound_Set
SND_SDW         = SNDOc_Shadow_Sound_Move
P1TR            = SNDOc_Pulse1_trans
TRTR            = SNDOc_Triangle_trans
NFRQ            = SNDOc_Noise_Frq
QNH             = SNDOc_Quick_Noisehit.white
QNHM            = SNDOc_Quick_Noisehit.metal
QN              = SNDOc_Quick_Noise.white
QNM             = SNDOc_Quick_Noise.metal
LQN             = SNDOc_LowQuick_Noise.white
LQNM            = SNDOc_LowQuick_Noise.metal
QP1             = SNDOc_Quick_Pulse1
QP2             = SNDOc_Quick_Pulse2
LQP1            = SNDOc_LowQuick_Pulse1
LQP2            = SNDOc_LowQuick_Pulse2
TEMPO           = SNDOc_Tempo_Set
DIS_RP1         = SNDOc_disable_remote_pulse1
DIS_RP2         = SNDOc_disable_remote_pulse2
RETRIG_RP1      = SNDOc_retrig_remote_pulse1
RETRIG_RP2      = SNDOc_retrig_remote_pulse2
CH_ON           = SNDOc_channel_enable
CH_OFF          = SNDOc_channel_disable
AP              = SNDOc_AutoPorta
AP0             = SNDOc_AutoPorta_OFF
VIB0            = SNDOc_Vibra0
VIB1            = SNDOc_Vibra1
VIB2            = SNDOc_Vibra2
VIB3            = SNDOc_Vibra3
TRE0            = SNDOc_Tremolo0
TRE1            = SNDOc_Tremolo1
TRE2            = SNDOc_Tremolo2
TRE3            = SNDOc_Tremolo3
RST_ON          = SNDOc_SoundReset_ON
RST_OFF         = SNDOc_SoundReset_OFF
ENV             = SNDOc_Env_set
VOL             = SNDOc_Volume_Set
DTY             = SNDOc_Duty_Set
LEN             = SNDOc_Len_Set
TRI             = SNDOc_Triangle_set
DMCNOTE         = SNDOc_dmc_note
DMCDRUM         = SNDOc_dmc_file
DMCLOAD         = SNDOc_dmc_load
LDAC            = SNDOc_Load_dac
ENDSOUND        = SNDOc_Jump_Snd000
ZEROVOL         = SNDOc_ZeroVol
AVOL            = SNDOc_AddVol
macro JUMP op1          {.dbw SNDOc_Track_Jump, op1}
macro LOOP op1,op2      {.db SNDOc_Track_loop, op1-1
                         .dw op2 }
macro LP op1,op2        {.db SNDOc_Track_shortloop,op1-1
                         .db $-op2}
macro FORCE op1,op2     {.db SNDOc_Force_Jump, op1 * 24
                         .dw op2}
macro CALL op1           {.dbw SNDOc_TrackCall, op1 }
macro RTS               {.db SNDOc_TrackRTS}

;macro GOSUB op1,op2     {.db SNDOc_TrackGosub, sub#op1, sub#op2}
;macro RETURN            {.db SNDOc_TrackReturn}
;-----------------------------------------------------------------------------
macro DISABLE           {db $80,ESNDOc_DisableTrack}
macro MODE op1*         {db $80,ESNDOc_Mode_Set,op1}
macro T_VOL op1*        {db $80,ESNDOc_Track_Volume,op1}

;=============================================================================
BaseNote        = 12
                                   
A0  = BaseNote+$01
AX0 = BaseNote+$03                 
B0  = BaseNote+$05
C1  = BaseNote+$07
CX1 = BaseNote+$09                 
D1  = BaseNote+$0B
DX1 = BaseNote+$0D                 
E1  = BaseNote+$0F
F1  = BaseNote+$11
FX1 = BaseNote+$13                 
G1  = BaseNote+$15
GX1 = BaseNote+$17                 
A1  = BaseNote+$19
AX1 = BaseNote+$1B                 
B1  = BaseNote+$1D
C2  = BaseNote+$1F
CX2 = BaseNote+$21                 
D2  = BaseNote+$23
DX2 = BaseNote+$25                 
E2  = BaseNote+$27
F2  = BaseNote+$29
FX2 = BaseNote+$2B                 
G2  = BaseNote+$2D
GX2 = BaseNote+$2F                 
A2  = BaseNote+$31
AX2 = BaseNote+$33                 
B2  = BaseNote+$35
C3  = BaseNote+$37
CX3 = BaseNote+$39                 
D3  = BaseNote+$3B
DX3 = BaseNote+$3D                 
E3  = BaseNote+$3F
F3  = BaseNote+$41
FX3 = BaseNote+$43                 
G3  = BaseNote+$45
GX3 = BaseNote+$47                 
A3  = BaseNote+$49
AX3 = BaseNote+$4B                 
B3  = BaseNote+$4D
C4  = BaseNote+$4F
CX4 = BaseNote+$51                 
D4  = BaseNote+$53
DX4 = BaseNote+$55                 
E4  = BaseNote+$57
F4  = BaseNote+$59
FX4 = BaseNote+$5B                 
G4  = BaseNote+$5D
GX4 = BaseNote+$5F                 
A4  = BaseNote+$61
AX4 = BaseNote+$63                 
B4  = BaseNote+$65
C5  = BaseNote+$67
CX5 = BaseNote+$69                 
D5  = BaseNote+$6B
DX5 = BaseNote+$6D                 
E5  = BaseNote+$6F
F5  = BaseNote+$71
FX5 = BaseNote+$73                 
G5  = BaseNote+$75
GX5 = BaseNote+$77                 
A5  = BaseNote+$79
AX5 = BaseNote+$7B                 
B5  = BaseNote+$7D
C6  = BaseNote+$7F
                                   
N_F = 01000000b                    
N_E = 01000100b                    
N_D = 01001000b                    
N_C = 01001100b                    
N_B = 01010000b                    
N_A = 01010100b                    
N_9 = 01011000b                    
N_8 = 01011100b                    
N_7 = 01100000b                    
N_6 = 01100100b                    
N_5 = 01101000b                    
N_4 = 01101100b                    
N_3 = 01110000b                    
N_2 = 01110100b                    
N_1 = 01111000b                    
N_0 = 01111100b                    
NXF = 01000001b                    
NXE = 01000101b                    
NXD = 01001001b                    
NXC = 01001101b                    
NXB = 01010001b                    
NXA = 01010101b                    
NX9 = 01011001b                    
NX8 = 01011101b                    
NX7 = 01100001b                    
NX6 = 01100101b                    
NX5 = 01101001b                    
NX4 = 01101101b                    
NX3 = 01110001b                    
NX2 = 01110101b                    
NX1 = 01111001b                    
NX0 = 01111101b                    
                                   
HIT = $40                          




;=============================================================================
TBL_DMCFILES:
.dmcfile_table drumkit,\
kick;, snare, tomhi;, tomlo, bonghi, bonglo, sb1, sb2, sb3, sb4, sb5
;=============================================================================
;.orgpad $e000
TBL_DMCNOTE_ADR:
TBL_DMCNOTE_LEN:
TBL_DMCNOTE_FRQ:
;=============================================================================
.lohi TBL_FREQUENCY,                      $0000,\
$0ff1,$0fb7,$0f7f,$0f48,$0f13,$0edf,$0ead,$0e7d,\
$0e4d,$0e1f,$0df3,$0dc7,$0d9d,$0d74,$0d4c,$0d26,\
$0d00,$0cdc,$0cb8,$0c96,$0c74,$0c54,$0c34,$0c16,\
$0bf8,$0bdb,$0bbf,$0ba4,$0b89,$0b6f,$0b56,$0b3e,\
$0b26,$0b0f,$0af9,$0ae3,$0ace,$0aba,$0aa6,$0a92,\
$0a80,$0a6d,$0a5c,$0a4a,$0a3a,$0a29,$0a1a,$0a0a,\
$09fb,$09ed,$09df,$09d1,$09c4,$09b7,$09ab,$099e,\
$0993,$0987,$097c,$0971,$0967,$095c,$0952,$0949,\
$093f,$0936,$092d,$0925,$091c,$0914,$090c,$0905,\
$08fd,$08f6,$08ef,$08e8,$08e1,$08db,$08d5,$08cf,\
$08c9,$08c3,$08bd,$08b8,$08b3,$08ae,$08a9,$08a4,\
$089f,$089b,$0896,$0892,$088e,$088a,$0886,$0882,\
$087e,$087a,$0877,$0874,$0870,$086d,$086a,$0867,\
$0864,$0861,$085e,$085c,$0859,$0856,$0854,$0851,\
$084f,$084d,$084b,$0848,$0846,$0844,$0842,$0840,\
$083f,$083d,$083b,$0839,$0838,$0836,$0834
;=============================================================================
TBL_AUTO_VIBRA:   db 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
                  db 0, 0, 1, 0, 0, 0,-1, 0, 0, 0, 1, 0, 0, 0,-1, 0
                  db 0, 0, 1, 1, 0, 0,-1,-1, 0, 0, 1, 1, 0, 0,-1,-1
                  db 0, 1, 2, 1, 0,-1,-2,-1, 0, 1, 2, 1, 0,-1,-2,-1

TBL_AUTO_TREMOLO: db 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
                  db 0,1,2,1, 0,1,1,1, 0,1,2,1, 0,1,1,1
                  db 0,2,3,1, 0,2,3,2, 0,1,3,2, 0,2,3,2
                  db 0,1,3,5, 6,5,3,1, 0,1,3,5, 6,5,3,1




;=============================================================================
;=============================================================================
.rts_table TBL_BLASTER_OC,SND,$80,NoOperation,$80, Oc_Extra_Opcode,\
Oc_dmc_load,                            \; 5 byte commands
Oc_Track_loop, Oc_Force_Jump,           \; 4 byte commands
Oc_Track_Jump, Oc_Track_shortloop,      \; 3 byte commands
Oc_dmc_file,                            \
Oc_TrackGosub, Oc_SoundGosub,           \
Oc_TrackGosub_Random,                   \
\; 2 byte commands
Oc_Tempo_Set, Oc_Sound_Set, Oc_Pulse1_trans, Oc_Noise_Frq,              \
Oc_Triangle_set, Oc_Len_Set, Oc_Env_set, Oc_Duty_Set, Oc_Volume_Set,    \
Oc_channel_enable, Oc_channel_disable,                                  \
Oc_Quick_Noisehit.white, Oc_Quick_Noisehit.metal,                       \
Oc_Quick_Noise.white, Oc_Quick_Noise.metal,                             \
Oc_Quick_Pulse1, Oc_Quick_Pulse2,                                       \
Oc_Shadow_Sound_Set, Oc_dmc_note, Oc_Load_dac,                          \
Oc_LowQuick_Pulse1, Oc_LowQuick_Pulse2, Oc_Triangle_trans,              \
Oc_AutoPorta, Oc_Sound_Frq,                                             \
Oc_disable_remote_pulse1, Oc_retrig_remote_pulse2,                      \
Oc_disable_remote_pulse2, Oc_retrig_remote_pulse1,                      \
Oc_LowQuick_Noise.white, Oc_LowQuick_Noise.metal,                       \
Oc_TrackCall, Oc_AddVol,                                                \
\; 1 byte commands
Oc_Jump_Snd000, Oc_TrackReturn, Oc_SoundReturn, Oc_TrackRTS,            \
Oc_Shadow_Sound_Move, Oc_SoundReset_ON, Oc_SoundReset_OFF,              \
Oc_AutoPorta_OFF, Oc_ZeroVol,                                           \
Oc_Vibra0, Oc_Vibra1, Oc_Vibra2, Oc_Vibra3,                             \
Oc_Tremolo0, Oc_Tremolo1, Oc_Tremolo2, Oc_Tremolo3

;-----------------------------------------------------------------------------
.rts_table TBL_EXTRA_OC,ESND,$00,NoOperation,$80,                       \
Oc_DisableTrack, Oc_Mode_Set, Oc_Track_Volume
;-----------------------------------------------------------------------------
BLASTER_OC:     asl
                bmi Quick_Sound               ; C0-FF = 1byte soundselect
                beq Oc_Extra_Opcode
                tax
                lda     1+TBL_BLASTER_OC+x
                pha
                lda     TBL_BLASTER_OC+x
                pha
NoOperation:    ret;db 62h;ret
;-----------------------------------------------------------------------------
Oc_Extra_Opcode:lda     (0)+y
                asl
                tax
                lda     1+TBL_EXTRA_OC+x
                pha
                lda     TBL_EXTRA_OC+x
                pha
                ret;db 62h;ret
;-----------------------------------------------------------------------------
Quick_Sound:    and!    $7f                   ; sound 00-3F
                lsr
                tax
                sta     track_sound
                movlh   sound_addr, SOUND_DATA+x
                dey
                ret
;-----------------------------------------------------------------------------
ExitSoundReader:
                pla
                pla
                jmp     UPDATE_SOUND.skip_note
;-----------------------------------------------------------------------------
ExitTrackReader:
                iny
                add_wy  0
                pla
                pla
                ret
;-----------------------------------------------------------------------------
              @ iny
                tax
                mov     $00+x, (0)+y
                iny
Oc_Sound_Load:  lda     (0)+y
                bpl @l
                ret
;-----------------------------------------------------------------------------
Oc_Shadow_Sound_Set:
                ldx     blaspage_offset
                mov     shadow_sound+x, (0)+y
                ret
Oc_Shadow_Sound_Move:
                ldx     blaspage_offset
                mov     track_sound, shadow_sound+x
                dey
                ret
;-----------------------------------------------------------------------------
Oc_Force_Jump:  lax     (0)+y
                iny
                lda     (0)+y
                pha
                iny
                lda     (0)+y
                sta     BlasterPage+(hi_track_addr-BlasterZP)+x
                pla
                sta     BlasterPage+(lo_track_addr-BlasterZP)+x

                stx     tmp_x
                ldx     track_tempodata

                cpx!    $10
                bcc .s1
                lda     TBL_TEMPO+x
                bpl @s
                tax
           .s1: lda     TBL_TEMPO+x
              @ ldx     tmp_x
                cpx     blaspage_offset
                bcc @s
                adc!    $00
              @ sta     BlasterPage+(track_tempo-BlasterZP)+x
                ret
;-----------------------------------------------------------------------------
Oc_TrackGosub_Random:
                and.b!  2, (0)+y,$0f
                and.b!  3, (0)+y,$f0
                and     random0, 2
                or      3
                jmp @s
;--------------------------------------
Oc_TrackGosub:  lda     (0)+y
              @ sta     tmp_y
                iny
                ldx     blaspage_offset
                mov     track_return+x,(0)+y

                ldy     tmp_y
.jump:          movlh   0, TBL_SUB_TRACKS+y
                ldy!    $ff
                ret

Oc_TrackReturn: ldx     blaspage_offset
                ldy     track_return+x
                jmp Oc_TrackGosub.jump
;-----------------------------------------------------------------------------
Oc_TrackCall:   pha     (0)+y
                iny
                pha     (0)+y
                ldx     blaspage_offset
                iny
                tya
                add     0
                sta     track_return+x
                bcc @s
                inc     1
              @ mov     sound_return+x, 1
                pla     1
                pla     0
                ldy!    $ff
                ret

;-----------------------------------------------------------------------------
Oc_TrackRTS:    ldx     blaspage_offset
                mov     0, track_return+x
                mov     1, sound_return+x
                ldy!    $ff
                ret
;-----------------------------------------------------------------------------
Oc_SoundGosub:  ldx     blaspage_offset
                lda     (0)+y
                sta     tmp_y
                iny
                mov     sound_return+x,(0)+y
                ldy     tmp_y

.jump:          movlh   0, SOUND_DATA+y
                ldy!    $ff
                ret

Oc_SoundReturn: ldx     blaspage_offset
                ldy     sound_return+x
                jmp Oc_SoundGosub.jump
;-----------------------------------------------------------------------------
Oc_Track_shortloop:
                ldx     blaspage_offset
                dec     track_shortloop+x
                bne .not_done
                iny
                ret

.not_done:      bmi .new_loop
                bpl .old_loop
.new_loop:      mov     track_shortloop+x, (0)+y
.old_loop:      iny
                sty     tmp_y
                lda     0
                sub     (0)+y
                bcs @s
                dec     1
              @ add     tmp_y
                sta     0
                bcc @s
                inc     1
              @ ldy!    $FF
                ret
;-----------------------------------------------------------------------------
Oc_Track_loop:  ldx     blaspage_offset
                dec     track_loop+x
                bne .not_done
                iny
                iny
                ret

.not_done:      bmi .new_loop
                bpl .old_loop
.new_loop:      mov     track_loop+x, (0)+y
.old_loop:      iny
;--------------------------------------
Oc_Track_Jump:  lax     (0)+y
                iny
                lda     (0)+y
                sta     1
                stx     0
                ldy!    $FF
                ret
;-----------------------------------------------------------------------------
Oc_Jump_Snd000: movw!   0, Snd000
                pla
                pla
                ret
;-----------------------------------------------------------------------------
Oc_Tempo_Set:   mov     track_tempodata, (0)+y
                ret
;-----------------------------------------------------------------------------
Oc_Sound_Set:   lax     (0)+y
                sta     track_sound
                movlh   sound_addr, SOUND_DATA+x
                ret
;-----------------------------------------------------------------------------
Oc_SoundReset_OFF:
                dey
                or.b!   track_status, $02
                ret
;-----------------------------------------------------------------------------
Oc_SoundReset_ON:
                dey
                and.b!  track_status, $FD
                ret
;-----------------------------------------------------------------------------
Oc_AutoPorta:   and!    effect_status, $F0
                ora     (0)+y
                sta     effect_status
                ret
;--------------------------------------
Oc_AutoPorta_OFF:
                dey
                and.b!  effect_status, $F0
                ret
;-----------------------------------------------------------------------------
Oc_AddVol:      mov     tmp_a, (0)+y
                ldx     blaspage_offset
                and.b!  tmp_x, track_volume+x, $f0
                and!    track_volume+x, $0f
                add     tmp_a
                and!    $0f
                ora     tmp_x
                sta     track_volume+x
                ret
;-----------------------------------------------------------------------------
Oc_Vibra0:      lda!    $00
                jz      Oc_Vibra_set
;--------------------------------------
Oc_Vibra1:      lda!    $10
                jnz     Oc_Vibra_set
;--------------------------------------
Oc_Vibra2:      lda!    $20
                jnz     Oc_Vibra_set
;--------------------------------------
Oc_Vibra3:      lda!    $30
                jnz     Oc_Vibra_set
;--------------------------------------
Oc_Vibra_set:   sta     tmp_a
                and!    effect_status, $CF
                or      tmp_a
                sta     effect_status
                dey
                ret
;-----------------------------------------------------------------------------
Oc_Tremolo0:    lda!    $00
                jz      Oc_Tremolo_set
;--------------------------------------
Oc_Tremolo1:    lda!    $40
                jnz     Oc_Tremolo_set
;--------------------------------------
Oc_Tremolo2:    lda!    $80
                jnz     Oc_Tremolo_set
;--------------------------------------
Oc_Tremolo3:    lda!    $C0
                jnz     Oc_Tremolo_set
;--------------------------------------
Oc_Tremolo_set: sta     tmp_a
                and!    effect_status, $3F
                or      tmp_a
                sta     effect_status
                dey
                ret
;-----------------------------------------------------------------------------
Oc_Sound_Frq:   ldx     blaspage_offset
                mov     sound_frame+x, (0)+y
                ret

;=============================================================================
;       EXTRA OPCODES
;=============================================================================
Oc_DisableTrack:mov!    track_status, $00
                jmp ExitTrackReader
;-----------------------------------------------------------------------------
Oc_Mode_Set:    iny
                mov     track_status, (0)+y
                ret
;-----------------------------------------------------------------------------
Oc_Track_Volume:iny
                ldx     blaspage_offset
                mov     track_volume+x, (0)+y
                ret
;=============================================================================
;       CHANNELS
;=============================================================================
Oc_ZeroVol:     dey
                lda     track_number
.pulse1:        bit     pulse1_stat
                beq .pulse2
                ldx!    $01
                jsr .set_vol

                lda     track_number
.pulse2:        bit     pulse2_stat
                beq .done
                ldx!    $02
                jsr .set_vol

.done:          jmp ExitSoundReader
;----------------------------------
.set_vol:       stx     tmp_x
                and.b!  tmp_a,  z4000-1+x, $f0
                and     engine_stat, tmp_x
                beq .zero
                lda     z4000-1+x
                lsr
                and!    $07
.zero:          ora     tmp_a
                sta     z4000-1+x
                ret

;-----------------------------------------------------------------------------
Oc_channel_enable:
                lax     (0)+y
                or.b     pulse1_stat+x,track_number
                ret
;-----------------------------------------------------------------------------
Oc_channel_disable:
                lax     (0)+y
                xor!    track_number,$ff
                and     pulse1_stat+x
                sta     pulse1_stat+x
                ret
;-----------------------------------------------------------------------------
Oc_Len_Set:     lax     (0)+y
                lda     track_number
.pulse1:        bit     pulse1_stat;, track_number
                beq .pulse2
                stx     z4003
.pulse2:        bit     pulse2_stat;, track_number
                beq .noise
                stx     z4007
.noise:         bit     noise_stat;, track_number
                beq .done
                stx     z400f
.done:          ret
;-----------------------------------------------------------------------------
Oc_Env_set:     mov     tmp_a,(0)+y
                lda     track_number
.pulse1:        bit     pulse1_stat
                beq .pulse2
                ldx!    $00
                or.b!   engine_stat, $01
                jsr .duty_check

                lda     track_number
.pulse2:        bit     pulse2_stat
                beq .done
                ldx!    $01
                or.b!   engine_stat, $02

.duty_check:    and!    tmp_a,$30
                beq .norm
                cmp!    $10
                bne .rand
                lda     z4000+x
                jmp @s
.rand:          lda     random0
              @ and!    $c0
                sta     tmp_x
                and!    tmp_a, $0f
                ora     tmp_x
                jmp @s
.norm:          lda     tmp_a
              @ ora!    $30
                sta     z4000+x

.done:          ret

;-----------------------------------------------------------------------------
Oc_Volume_Set:  and.b!   tmp_a, (0)+y,$3f
                lax     track_number
.pulse1:        bit     pulse1_stat;, track_number
                beq .pulse2

                lda     z4000
                and!    $c0
                or      tmp_a
                sta     z4000
                or.b!   engine_stat, $01
                txa     ;track_number
.pulse2:        bit     pulse2_stat;, track_number
                beq .noise

                lda     z4004
                and!    $c0
                or      tmp_a
                sta     z4004
                or.b!   engine_stat, $02
                txa     ;track_number
.noise:         bit     noise_stat;, track_number
                beq .done

                lda     z400c
                and!    $c0
                or      tmp_a
                sta     z400c

.done:          lda     (0)+y
                bpl .exit

                jmp ExitSoundReader

.exit:          ret
;-----------------------------------------------------------------------------
Oc_Duty_Set:    lda     (0)+y
                asl
                sta     tmp_a

                lax     track_number
.pulse1:        bit     pulse1_stat;, track_number
                beq .pulse2

                lda     z4000
                and!    $3f
                or      tmp_a
                sta     z4000
                txa     ;track_number
.pulse2:        bit     pulse2_stat;, track_number
                beq .done

                lda     z4004
                and!    $3f
                or      tmp_a
                sta     z4004

.done:          lda     (0)+y
                bpl .exit
                jmp ExitSoundReader

.exit:          ret



;=============================================================================
;       PULSE
;=============================================================================
Oc_LowQuick_Pulse1:
                and!    engine_stat, $01
                beq     Oc_Quick_Pulse1
              @ ret

Oc_LowQuick_Pulse2:
                and!    engine_stat, $02
                bne @l

Oc_Quick_Pulse2:ldx!    $01
                jnz @s

Oc_Quick_Pulse1:ldx!    $00
              @ mov     tmp_a, (0)+y
                and!    $20
                bne     .const

                mov!    z4003+x, $10
                jnz     .len

.const:         and!    tmp_a, $10
                beq     .no_trig

                mov!    z4003+x, $00
                jz      .len

.no_trig:       and.b!  z4003+x, $8f

.len:           or.b!   z4000+x, tmp_a,$10
                or.b    pulse1_stat+x, track_number
                lda     track_number
                xor!    $ff
                and     pulse1_disreq+x
                sta     pulse1_disreq+x

                ret
;-----------------------------------------------------------------------------
Oc_Pulse1_trans:ldx     blaspage_offset
                mov     pulse1_trans+x, (0)+y
                ret
;-----------------------------------------------------------------------------
Oc_disable_remote_pulse1:
                ldx!    $00
                jz @s
Oc_disable_remote_pulse2:
                ldx!    $01
              @ and.b   pulse1_stat+x, (0)+y,pulse1_stat+x
                ret
Oc_retrig_remote_pulse1:
                ldx!    $00
                jz @s
Oc_retrig_remote_pulse2:
                ldx!    $01
              @ lda     (0)+y
                pha
                and     pulse1_retrig+x
                sta     pulse1_retrig+x
                pla
                xor!    $ff
                ora     pulse1_stat+x
                sta     pulse1_stat+x
                ret


;=============================================================================
;       TRIANGLE
;=============================================================================
Oc_Triangle_set:and.b!  tmp_a, (0)+y,$BF

                and     triangle_stat, track_number
                beq     .done

                mov     z4008,tmp_a

.done:          lda     (0)+y
                bvc .exit

                jmp ExitSoundReader

.exit:          ret
;-----------------------------------------------------------------------------
Oc_Triangle_trans:
                ldx     blaspage_offset
                mov     triangle_trans+x, (0)+y
                ret

;=============================================================================
;       NOISE
;=============================================================================
Oc_Noise_Frq:   ldx     blaspage_offset
                mov     noise_frq+x, (0)+y
              @ ret
;-----------------------------------------------------------------------------
Oc_LowQuick_Noise:
.metal:         mov!    tmp_a, $80
                jnz @s
.white:         mov!    tmp_a, $00
              @ and!    engine_stat, $08
                beq Oc_Quick_Noise.set_frq_vol
                ret
Oc_Quick_Noise:
.metal:         mov!    tmp_a, $80
                jnz .set_frq_vol
.white:         mov!    tmp_a, $00
.set_frq_vol:   and!    (0)+y, $0f
                or!     $30
                sta     z400c
                lda     (0)+y
       rept 4 { lsr }
                or      tmp_a
                ldx     blaspage_offset
                sta     noise_frq+x
                or.b!   engine_stat, $08
                ret

Oc_Quick_Noisehit:
.metal:         mov!    tmp_a, $80
                jnz @s
.white:         mov!    tmp_a, $00
              @ call    Oc_Quick_Noise.set_frq_vol
                pla
                pla
                lda!    $40
                jmp     UPDATE_SOUND.hit_note

;=============================================================================
;       DMC / DAC
;=============================================================================
Oc_dmc_file:    and     dmc_stat, track_number
                beq .skip
                mov     z4010, (0)+y
                iny
                lda     (0)+y
                asl
                tax
                mov     z4012, TBL_DMCFILES+x
                mov     z4013, 1+TBL_DMCFILES+x
                mov!    z4011, DEFAULT_DMC_VOL
.skip:          ret
;-----------------------------------------------------------------------------
Oc_dmc_load:    and     dmc_stat, track_number
                beq .skip
                mov     z4010, (0)+y
                iny
                mov     z4011, (0)+y
                iny
                mov     z4012, (0)+y
                iny
                mov     z4013, (0)+y
.skip:          ret
;-----------------------------------------------------------------------------
Oc_dmc_note:    and     dmc_stat, track_number
                beq .done
                lda     (0)+y
                asl
                asl
                sta     tmp_a
                lda     track_note
                lsr
                tax
                add.b   z4012, TBL_DMCNOTE_ADR+x, (0)+y
                sub.b   z4013, TBL_DMCNOTE_LEN+x, tmp_a
                mov     z4010, TBL_DMCNOTE_FRQ+x
                mov!    z4011, DEFAULT_DMC_VOL

.done:          rts
;-----------------------------------------------------------------------------
Oc_Load_dac:    mov     4011h,(0)+y
                ret

;=============================================================================
SOUND_BLASTER:
if nsf_file = 1
                inc     framecount
                call    RANDOMIZER
end if

                mov!    track_number, $01
                trx!    $00, blaspage_offset, engine_stat

.loop:          lda     BlasterPage+x
                bne .active_track
                jmp .next_track

.active_track:  mov     0+ BlasterZP, 0+ BlasterPage+x
                mov     1+ BlasterZP, 1+ BlasterPage+x
                mov     2+ BlasterZP, 2+ BlasterPage+x
                mov     3+ BlasterZP, 3+ BlasterPage+x
                mov     4+ BlasterZP, 4+ BlasterPage+x
                mov     5+ BlasterZP, 5+ BlasterPage+x
                mov     8+ BlasterZP, 8+ BlasterPage+x
                mov     9+ BlasterZP, 9+ BlasterPage+x

                mov     0, 6+ BlasterPage+x;lo_track_addr
                mov     1, 7+ BlasterPage+x;hi_track_addr
                call    UPDATE_TRACK

                ldx     blaspage_offset
                mov     6+ BlasterPage+x, 0
                mov     7+ BlasterPage+x, 1

                movlh   0, sound_addr
                call    UPDATE_SOUND

                ldx     blaspage_offset
                mov     8+ BlasterPage+x, 0
                mov     9+ BlasterPage+x, 1

                mov     0+ BlasterPage+x, 0+ BlasterZP
                mov     1+ BlasterPage+x, 1+ BlasterZP
                mov     2+ BlasterPage+x, 2+ BlasterZP
                mov     3+ BlasterPage+x, 3+ BlasterZP
                mov     4+ BlasterPage+x, 4+ BlasterZP
                mov     5+ BlasterPage+x, 5+ BlasterZP

.next_track:    txa
                add!    $18
                tax
                sta     blaspage_offset
                asl     track_number
                bcs Update_Apu
                jmp .loop
;-----------------------------------------------------------------------------
Update_Apu:     ;jmp     .done
                mov     4000h,z4000
                mov     4002h,z4002
                mov     4004h,z4004
                mov     4006h,z4006
                mov     4008h,z4008
                mov     400ch,z400c
                mov     400eh,z400e

.pulse1:        lda     z4003
                bmi .pulse2
                sta     4003h
                ora!    $80
                sta     z4003

.pulse2:        lda     z4007
                bmi .triangle
                sta     4007h
                ora!    $80
                sta     z4007

.triangle:      lda     z400b
                bmi .skip
                and!    $07
                bne @s
                ldy!    $ff
                lda     z400b
                ldx     z400a
                sty     400bh
                stx     400ah
              @ sta     400bh
                ora!    $80
                sta     z400b
.skip:          mov     400ah,z400a

.noise:         lda     z400f
                bmi .dmc
                sta     400fh
                ora!    $80
                sta     z400f

.dmc:           lda     z4011
                bmi .done
                sta     4011h
                ora!    $80
                sta     z4011
                mov     4010h,z4010
                mov     4012h,z4012
                mov     4013h,z4013
                mov!    4015h,$0F
                mov!    4015h,$1F

.done:          ret

;=============================================================================
;       INIT BLASTER
;=============================================================================
if nsf_file = 1
INIT_NSF:       sta     song_number
                sec
                lda!    $00
                tax
.load_bits:     inx
                rol
                sta     mask01-1  +x
                bpl .load_bits

                dex
                lda!    $a9
              @ rol
                sta     random0+x
                dex @l

                mov!    mask03, $03
                mov!    mask07, $07
                mov!    mask0f, $0f
end if


INIT_BLASTER:   ldx     song_number
                movlh   0, TBL_SONGDATA+x
;Set BlasterPage
                lda!    $00
                ldx!    $bf
              @ sta     BlasterPage+x
                dex
                bpl @l

                mov!    2, TRACKCOUNT

                ldx!    $00
                ldy!    $00
.loop:          lda     (0)+y
                iny
                sta     BlasterPage+(lo_track_addr-BlasterZP)+x
                lda     (0)+y
                iny
                sta     BlasterPage+(hi_track_addr-BlasterZP)+x

                lda     (0)+y
                iny
                sta     BlasterPage+(track_status-BlasterZP)+x

                ldal    Snd000
                sta     BlasterPage+(lo_sound_addr-BlasterZP)+x
                ldah    Snd000
                sta     BlasterPage+(hi_sound_addr-BlasterZP)+x
                txa
                add!    $18
                tax
                dec     2
                bne .loop
                                          
                lda!    $FF
                sta     pulse1_retrig, pulse2_retrig
                sta     pulse1_disreq, pulse2_disreq, triangle_disreq

                tra!    $08, 4001h,4005h
                tra!    $80, z4003,z4007,z400b,z400f,z4011
                tra!    $0F, 4015h
                ret

;=============================================================================
;       OPCODE READER
;=============================================================================
DRUM_MODE:
.opcode:        iny
                jsr BLASTER_OC
                iny
.get_code:      lda     (0)+y
                bmi .opcode
                beq UPDATE_TRACK.exit_track

                sta     track_sound
                tax
                mov!    track_note, $40
                jnz UPDATE_TRACK.reset_sound
;=============================================================================
UPDATE_TRACK:   ldx     track_tempo
                beq .update
                bmi .stop
                dex
                stx     track_tempo
.stop:          ret

.update:        ldy!    $00
                bit     track_status
                bvs DRUM_MODE.get_code
                bvc .get_code

.opcode:        iny
                jsr BLASTER_OC

                iny
.get_code:      lda     (0)+y
                bmi .opcode
                beq .exit_track

                sta     track_note

                and!    track_status, $02
                bne .exit_track

                ldx     track_sound
.reset_sound:   movlh   sound_addr, SOUND_DATA+x

.exit_track:    iny
                add_wy  0

                cpx!    track_tempodata, $10
                bcs @s
                lda     TBL_TEMPO+x
                sta     track_tempo
                bcc     .tempo_done

              @ lda     TBL_TEMPO+x
                bpl @s
                and!    $7f
                tax
                lda     TBL_TEMPO+x
              @ sta     track_tempo
                inx
                stx     track_tempodata

.tempo_done:    and!    effect_status, $0F
                beq .skip_search

.note_search:   movw    2,0
                ldx     blaspage_offset
                ldy!    $fe
.searchloop:    iny
                iny
                lda     (0)+y
                beq .base_note
                bpl .next_note
                cmp!    SNDOc_Jump_Snd000 ;1 byte command
                bcs .searchloop+1
                cmp!    SNDOc_Tempo_Set ;2 byte command
                bcs .searchloop
.base_note:     lda     track_note
.next_note:     sta     limit_note+x
                movw    0,2
.skip_search:

.done:          ret

;=============================================================================
UPDATE_SOUND:   ldx     blaspage_offset
                and!    sound_frame+x, $0f
                beq .update
                sub!    $01
                sta     tmp_a
                and!    sound_frame+x, $f0
                or      tmp_a
                sta     sound_frame+x
                ret

.update:        ldy!    $00
                jz  .get_code

.opcode:        iny
                jsr BLASTER_OC

                iny
.get_code:      lda     (0)+y
                bmi .opcode
                bne .hit_note
                jmp .skip_note
.hit_note:      sty     tmp_y
;-------------------------------------
                tay
                ldx     blaspage_offset

                lda     tablecounter+x
                add!    $01
                and!    $0f
                sta     tablecounter+x

                mov     3, tablecounter+x
                and!    effect_status, $0F
                beq .skip_porta
                sta     tmp_a ;autoporta
                cmp     track_note, limit_note+x
                beq .skip_porta
                bcs .decrease
                adc     tmp_a ;autoporta
                cmp     limit_note+x
                bcc .slide_note
                bcs .target_note
.decrease:      sbc     tmp_a ;autoporta
                cmp     limit_note+x
                bcs .slide_note
.target_note:   lda     limit_note+x
.slide_note:    sta     track_note

.skip_porta:    and!    effect_status, $C0
                beq .skip_tremolo
                lsr
                lsr
                adc     3  ;tablecounter
                tax
                lda     TBL_AUTO_TREMOLO+x
                bne @s

.skip_tremolo:  lda!    $00
              @ sta     2 ;trmolo_vol

                and!    effect_status, $30
                beq .skip_vibra
                add     3 ;tablecounter
                tax
                tya
                add     TBL_AUTO_VIBRA+x
                and!    $7f
                bne @s
.skip_vibra:    tya
;-------------------------------------
              @ xor!    $c0
                add     track_note
                and!    $7f
                tax
                stx     tmp_x

                ldy     track_number
                tya     ;track_number
.pulse1:        bit     pulse1_stat;, track_number
                beq .pulse2

                bit     pulse1_disreq
                bne @s
                or      pulse1_disreq
                sta     pulse1_disreq
                tya     ;track_number
                xor!    $ff
                and     pulse1_stat
                sta     pulse1_stat

                tya     ;track_number
             @  bit     pulse1_retrig
                bne @s
                ora     pulse1_retrig
                sta     pulse1_retrig
                mov!    z4003,$00
             @
             ;  stx     tmp_x
                txa
                ldx     blaspage_offset
                add     pulse1_trans+x
                and!    $7f
                tax

                mov     z4002, lo_TBL_FREQUENCY+x
                lda     z4003
                and!    $7f
                cmp     hi_TBL_FREQUENCY+x
                beq .skip_p1

                and!    $70
                ora     hi_TBL_FREQUENCY+x
                sta     z4003

.skip_p1:
                ldx     blaspage_offset
                and!    z4000, $0f
                sub     track_volume+x
                bmi .zero1
                sub     2 ;trmolo_vol
                bpl @s
.zero1:         lda!    $00
              @ sta     tmp_a
                and!    z4000, $f0
                or      tmp_a
                sta     z4000

                ldx     tmp_x
                tya     ;track_number
.pulse2:        bit     pulse2_stat;, track_number
                beq .triangle

                bit     pulse2_disreq
                bne @s
                or      pulse2_disreq
                sta     pulse2_disreq
                tya     ;track_number
                xor!    $ff
                and     pulse2_stat
                sta     pulse2_stat

                tya     ;track_number
             @  bit     pulse2_retrig
                bne @s
                ora     pulse2_retrig
                sta     pulse2_retrig
                mov!    z4007,$00
             @

                mov     z4006, lo_TBL_FREQUENCY+x
                lda     z4007
                and!    $7f
                cmp     hi_TBL_FREQUENCY+x
                beq .skip_p2

                and!    $70
                ora     hi_TBL_FREQUENCY+x
                sta     z4007
.skip_p2:
                ldx     blaspage_offset
                and!    z4004, $0f
                sub     track_volume+x
                bmi .zero2
                sub     2 ;trmolo_vol
                bpl @s
.zero2:         lda!    $00
              @ sta     tmp_a
                and!    z4004, $f0
                or      tmp_a
                sta     z4004

                ldx     tmp_x
                tya     ;track_number
.triangle:      bit     triangle_stat;, track_number
                beq .noise

                bit     triangle_disreq
                bne @s
                or      triangle_disreq
                sta     triangle_disreq
                tya     ;track_number
                xor!    $ff
                and     triangle_disreq
                sta     triangle_disreq
              @

           ;    stx     tmp_x
                txa
                ldx     blaspage_offset
                add     triangle_trans+x
                and!    $7f
                tax

                mov     z400a, lo_TBL_FREQUENCY+x
                mov     z400b, hi_TBL_FREQUENCY+x

                ldx     tmp_x
                tya
.noise:         bit     noise_stat;, track_number
                beq .done

           ;    stx     tmp_x
                txa
                ldx     blaspage_offset
                mov     z400e, noise_frq+x

                and.b!  z400f, $7F

                and!    z400c, $0f
                sub     track_volume+x
                bmi .zero3
                sub     2 ;trmolo_vol
                bpl @s
.zero3:         lda!    $00
              @ sta     tmp_a
                and!    z400c, $f0
                or      tmp_a
                sta     z400c

                ldx     tmp_x
                tya
.dmc:           bit     dmc_stat;, track_number
                jmp .done

                txa
                lsr
                tax
                mov     z4012, TBL_DMCNOTE_ADR+x
                mov     z4013, TBL_DMCNOTE_LEN+x
                mov     z4010, TBL_DMCNOTE_FRQ+x
                mov!    z4011, DEFAULT_DMC_VOL

.done:          ldy     tmp_y
.skip_note:     iny
                add_wy  0

                ldx     blaspage_offset
                lda     sound_frame+x
                lsr
                lsr
                lsr
                lsr
                or      sound_frame+x
                sta     sound_frame+x

                ret


;=============================================================================
;a = sound number
;x = track number
SOUND_FX:       sta     $705 +x
                tay
                mov     $708 +x, lo_SOUND_DATA+y
                mov     $709 +x, hi_SOUND_DATA+y
                ret

;=============================================================================
RANDOMIZER:     lda     random3
                ror
                xor     random6
                ror
                ror     random7
                rol     random6
                ror     random5
                ror
                xor     random0
                ror
                rol     random4
                ror     random3
                rol     random2
                ror     random1
                ror     random0
                ret





















