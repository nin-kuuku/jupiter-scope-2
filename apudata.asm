macro GOSUB op1,op2     {.db SNDOc_SoundGosub, sub#op1, sub#op2}
macro RETURN            {.db SNDOc_SoundReturn}
;=============================================================================
;SOUND_DATA:
.lohi_table SOUND_DATA,sub,$00,Snd000,$100,                    Snd000,  \
Snd001,Snd002,Snd003,Snd004,Snd005,Snd006,Snd007,Snd008,Snd009,Snd010,  \
Snd011,Snd012,Snd013,Snd014,Snd015,Snd016,Snd017,Snd018,Snd019,Snd020,  \
Snd021,Snd022,Snd023,Snd024,Snd025,Snd026,Snd027,Snd028,Snd029,Snd030,  \
Snd031,Snd032,Snd033,Snd034,Snd035,Snd036,Snd037,Snd038,Snd039,Snd040,  \
Snd041,Snd042,Snd043,Snd044,Snd045,Snd046,Snd047,Snd048,Snd049,Snd050,  \
Snd051,Snd052,Snd053,Snd054,Snd055,Snd056,Snd057,Snd058,Snd059,Snd060,  \
Snd061,Snd062,Snd063,Snd064,Snd065,Snd066,Snd067,Snd068,Snd069,Snd070,  \
Snd071,Snd072,Snd073,Snd074,Snd075,Snd076,Snd077,Snd078,Snd079,Snd080,  \
Snd081,Snd082,Snd083,Snd084,Snd085,Snd086,Snd087,Snd088,Snd089,Snd090,  \
Snd091,Snd092,Snd093,Snd094,Snd095,Snd096,Snd097,Snd098,Snd099,Snd100,  \
Snd101,Snd102,Snd103,Snd104,Snd105,Snd106,Snd107,Snd108,Snd109,Snd110,  \
Snd111,Snd112,Snd113,Snd114,Snd115,Snd116,Snd117,Snd118,Snd119,Snd120,  \
Snd121,Snd122,Snd123,Snd124,Snd125,Snd126,Snd127,                       \
SndSnare1,SndSnare2,SndSnare3,SndQSnare1,Snd005.end


;=============================================================================
Snd000: db ENDSOUND

ki = 1
TB = A3-2
Snd001: db CH_ON,4,DMCDRUM,$f,dmc_kick, ENDSOUND
        db CH_ON,2,QN,$88,TRI,$03,TB
        db LQN,$00,TRI,$03, TB-13
        db TRI,$03, TB-22
        db CH_OFF,2
        db ENDSOUND
PB = A2-3
sn = 2
Snd002: GOSUB SndSnare1,SndSnare2

sn2 = 3
Snd003: GOSUB SndSnare1,Snd002

qsn = 4
Snd004: GOSUB SndQSnare1,SndSnare3

qsn2 = 5
Snd005: GOSUB SndSnare1,Snd005.end
.end:   GOSUB SndQSnare1,SndSnare2


SndQSnare1: db CH_ON,3,QN,$c8,QP2,$b9,PB
            db QN,$57,QP2,$b8,PB-12
            RETURN

SndSnare1: db CH_ON,3,QN,$de,QP2,$bD,PB
           db QN,$59,QP2,$b9,PB-13
           RETURN
SndSnare2: db QN,$46,QP2,$b4,PB-1
SndSnare3: db LQP2,$00, QNH,$34
           db QNH,$43
           db QNH,$32
           db QNH,$21
           db QN,$0, ENDSOUND







hc = 6
Snd006: db CH_ON,3,QNH,$36,QNHM,$23,QNH,$21,QNH,$00,ENDSOUND



ho = 7
Snd007: db CH_ON,3,QNH,$56,QNH,$45,QNHM,$35,QNH,$44,QNH,$34,QNH,$25,QNH,$33,QNH,$23,QNH,$32,QNH,$21,QNH,$00,ENDSOUND

cr = 8
Snd008: db CH_ON,3,QNH,$59
        db QNHM,$48
        db QNH, $57
        db QNH, $47
        db QNH, $57
        db QNH, $46
        db QNHM,$56
        db QNH, $46
        db QNH, $55
        db QNH, $45
        db QNH, $55
        db QNHM,$44
        db QNH, $54
        db QNH, $44
        db QNH, $53
        db QNH, $43
        db QNHM,$53
        db QNH, $42
        db QNH, $52
        db QNH, $41
        db QNH, $51
        db QNH, $00,ENDSOUND









Snd009:
Snd010:
Snd011:
Snd012:
Snd013:
Snd014:
Snd015:
Snd016:
Snd017:
Snd018:
Snd019:
Snd020:
Snd021:
Snd022:
Snd023:
Snd024:
Snd025:
Snd026:
Snd027:
Snd028:
Snd029:
Snd030:
Snd031:
;-----------------------------------------------------------------------------
Snd032:
Snd033:
Snd034:
Snd035:
Snd036:
Snd037:
Snd038:
Snd039:
Snd040:
Snd041:
Snd042:
Snd043:
Snd044:
Snd045:
Snd046:
Snd047:
Snd048:
Snd049:
Snd050:
Snd051:
Snd052:
Snd053:
Snd054:
Snd055:
Snd056:
Snd057:
Snd058:
Snd059:
Snd060:

WT = 61 or $c0
Snd061:  db SND_SDW,ENV,$31,HIT
         db ENV,$33,HIT
         db ENV,$32,HIT
         db ENV,$32,HIT
         db ENV,$31,HIT
       @ db ENV,$31,HIT+1
         db ENV,$32,HIT
         db ENV,$32,HIT-1
         db ENV,$31,HIT
         JUMP @l

TT = 62 or $c0
Snd062:  db CH_ON,1,ENV,$80,LEN,$08,TRTR,0,TRI,$0f,HIT, TRTR,0,CH_OFF,1
        ;db TRI,$03,HIT-1
        ;db TRI,$02,HIT+1
      ;  db ENV,$BF
        db TRI,$0F,HIT
      ;  db ENV,$BE
        db TRI,$0F,HIT
      ;  db ENV,$BD
        db TRI,$0F,HIT
      ;  db ENV,$BC
        db TRI,$0F,HIT
      ;  db ENV,$B0
        db TRI,$0F,HIT
        db TRI,$0F,HIT,TRI,$0F,HIT,TRI,$0F,HIT,TRI,$0F,HIT,TRI,$0F,HIT
        db TRI,$01,HIT
        db ENDSOUND

TS = 63 or $c0
Snd063: db SND_SDW,CH_ON,2, TRI,$0, HIT
        db ENDSOUND


Snd064:
        db ENV,$37,HIT
        db ENV,$37,HIT
        db ENV,$37,HIT
        db ENV,$37,HIT
        db ENV,$37,HIT
      @ db ENV,$37,HIT,0
        db ENV,$37,HIT;,0,0
        JUMP @l

Snd065: db ENV,$3F,HIT
        db ENV,$3D,HIT
        db ENV,$3A,HIT
        db ENV,$3A,HIT
        db ENDSOUND




Snd066:
Snd067:
Snd068:
Snd069:
Snd070:
Snd071:
Snd072:
Snd073:
Snd074:
Snd075:
Snd076:
Snd077:
Snd078:
Snd079:
Snd080:
Snd081:
Snd082:
Snd083:
Snd084:
Snd085:
Snd086:
Snd087:
Snd088:
Snd089:
Snd090:
Snd091:
Snd092:
Snd093:
Snd094:
Snd095:
Snd096:
Snd097:
Snd098:
Snd099:

sfx_dummy = 100
Snd100: db ENDSOUND


Snd101:
sfx_shoot = 101
TB = C5
        db CH_ON,2
        db TRI,$01,TB-10
        db TRI,$02,TB-20
        db TRI,$02,TB-30
        db TRI,$03,TB-40
        db CH_OFF,2, ENDSOUND



Snd102:
sfx_explode = 102
        db CH_ON,3
        db QNH,$8A
        db QNH,$FF,0


        db QNH,$CB


        db QNH,$C9

        db QNH,$85
        db QNH,$F5,0
        db QNH,$A5,0

        db QNH,$C5,0

        db QNH,$D4,0

        db QNH,$D4
        db LQN,$00,HIT
        db CH_OFF,3
        db ENDSOUND


Snd103:
sfx_player_explode = 103
        db CH_ON,3
        db QNH,$FF,0
        db QNH,$DF
        db QNH,$AF
        db QNH,$EF,0
        db QNH,$FD
        db QNH,$ED
        db QNH,$CF,0
        db QNH,$FF
        db QNH,$DB
        db QNH,$EF,0
        db QNH,$EF
        db QNH,$FA,0,0,0
        db QNH,$F8,0
        db QNH,$D8
        db QNH,$A8
        db QNH,$E8,0
        db QNH,$F6
        db QNH,$E6
        db QNH,$C8,0
        db QNH,$F8
        db QNH,$D5
        db QNH,$E8,0
        db QNH,$E8
        db QNH,$F5,0,0,0
        db QNH,$C6,0
        db QNH,$F6
        db QNH,$D5
        db QNH,$E5,0
        db QNH,$E5
        db QNH,$F5,0,0,0
        db LQN,$00,HIT
        db CH_OFF,3
        db ENDSOUND
Snd104:
Snd105:
Snd106:
Snd107:
Snd108:
Snd109:
Snd110:
Snd111:
Snd112:
Snd113:
Snd114:
Snd115:
Snd116:
Snd117:
Snd118:
Snd119:
Snd120:
Snd121:
Snd122:
Snd123:
Snd124:
Snd125:
Snd126:
Snd127:

macro GOSUB op1,op2     {.db SNDOc_TrackGosub, sub#op1, sub#op2}
macro RETURN            {.db SNDOc_TrackReturn}
macro RANDOM_GOSUB op1,op2     {.db SNDOc_TrackGosub_Random, op1, sub#op2}

;=============================================================================
TBL_TEMPO:
.db 8,5,23,3,1,1,1,1,  1,1,1,1,1,1,1,1

.db 7,5,6,4,$90, 7,6,6,5,6,6,$95
;=============================================================================
.lohi_table TBL_SUB_TRACKS,sub,$00,TesTrack,$100,\
TesTrack, 0, Track_5.loop, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
DrmFil_1,DrmFil_2,DrmFil_3,DrmFil_4,  \
DrmFil_1,DrmFil_1,DrmFil_1,DrmFil_1,  \
DrmFil_1,DrmFil_1,DrmFil_1,DrmFil_1,  \
DrmFil_1,DrmFil_1,DrmFil_1,DrmFil_1
;=============================================================================
.lohi TBL_SONGDATA,\
TBL_SONG0,TBL_SONG1

TBL_SONG0:.dwb Track_0,$40, Track_0,$40, Track_0,$40, Track_0,$40
          .dwb Track_0,$40, Track_0,$40, Track_6,$40, Track_7,$40

TBL_SONG1: .dwb Track_0,0, Track_1,1, Track_2,1, Track_3,1
           .dwb Track_4,$40, Track_5,$40, Track_6,$40, Track_7,$40

TesTrack:
Track_0:
;Track_1:
;Track_2:
;Track_3:
;Track_4:
;Track_5:
T_VOL 15
         db CH_ON,3,TEMPO,$0
         db hc;,0

DISABLE

Track_6:
Track_7: db sfx_dummy
.loop db 0
JUMP .loop

;-----------------------------------------------------------------------------
;DRUMS
Track_4: T_VOL 0
         db CH_ON,3,TEMPO,$00
         db cr,0,0, hc,hc,hc, hc,hc ,ho, hc,hc,hc
       @ db hc,hc,hc, hc,hc,hc, hc,ho,hc, hc,ho,hc
         db hc,hc,hc, hc,hc,hc, hc,ho,hc, hc,ho,hc
         LP 3, @l
         db cr,0,0, 0,0,0, cr,0,0, 0,0,0
         JUMP Track_4


Track_5: T_VOL 0
         db CH_ON,3,CH_ON,2,TEMPO,$0
.loop    db ki,0,0,ki,0,0, ki,0,0,ki,0,qsn
         db ki,0,0,ki,0,0, ki,0,ki,sn,0,qsn
         db ki,0,0,ki,0,0, ki,0,0,ki,0,qsn
         db ki,0,0,ki,0,0, ki,0,ki,sn,0,qsn
         db ki,0,0,ki,0,0, ki,0,0,ki,0,qsn
         db ki,0,0,ki,0,0, ki,0,ki,sn,0,qsn
         db ki,0,0,ki,0,0, ki,0,0,ki,0,qsn


         RANDOM_GOSUB $13, Track_5.loop
         JUMP Track_5

DrmFil_1: db sn2,qsn,ki, sn,ki,sn2, ki,ki,qsn, qsn2,qsn,qsn
RETURN

DrmFil_2: db sn,qsn,ki, sn,sn2,ki, ki,sn,qsn2, qsn,qsn2,sn
RETURN

DrmFil_3: db sn,ki,sn2, ki,qsn2,sn, qsn2,qsn,sn2, ki,sn2,qsn
RETURN

DrmFil_4: db ki,ki,qsn2, ki,sn,qsn, ki,qsn2,sn, qsn,ki,ki
RETURN

;-----------------------------------------------------------------------------
;BASS
Track_3: db CH_ON,2,CH_ON,1,TEMPO,$00,SND,62,SDW,62,SND_FRQ,$00,AP,6
     ;  @ db F1,G1,G2,F1, G1,0,DX2,F1, G1,D2,AX1,G1, 0,G1,C2,G1
     ;    db F1,G1,0,F1, 0,F2,DX2,F1;, G1,D2,AX1,G1, G1,G1,C2,G1
     ;    JUMP @l
       @ db A1,B1,B2,A1, B1,0,FX2,A1, B1,FX2,D2,B1, 0,B1,E2,B1
         db A1,B1,0,A1, 0,A2,FX2,A1;, G1,D2,AX1,G1, G1,G1,C2,G1
         JUMP @l


;-----------------------------------------------------------------------------
;SYNTH
Track_1: db TEMPO,$0,SND_FRQ,$00,TRE1,AP,1, SND,64
         T_VOL 4
         db CH_ON,0
         db 0,0,0
         JUMP Track_2.start

Track_2: db TEMPO,$0,SND_FRQ,$00, RST_ON, TRE1, VIB1, AP,1,CH_ON,1, SND,64
         T_VOL 3
.start:  db CH_ON,1, SND,64
.loop:   db B2,0,0, 0,0,0,RST_OFF, 0,B3,0, 0,0,0,VIB3
         db 0,0,0,0,RST_ON, 0,VIB1,G3,0,0,0     ,FX3,0,0,RST_OFF
         db 0,0,0,0,0,B2,0,0,0, 0,0,0,VIB2
         db 0,0,0,RST_ON, 0,VIB1,0,C3,0,0,0, 0,0,0
         db 0,B2,0, 0,0,0,RST_OFF, 0,B3,0, 0,0,0,VIB3
         db 0,0,0,0,RST_ON, 0,VIB1,G3,0,0,0     ,FX3,0,0,RST_OFF
         db VIB3,0,0,0,0,0,0,0,0,0, 0,0,0
         db 0,0,0,RST_ON, 0,VIB1,0,0,0,0, A3,0,0,0

         JUMP .loop

