;**********************************************************************
;                                                                     *
;    Filename: 16F628A.asm                                            *
;    Date: 09/22/2014                                                 *
;    File Version: 1.0                                                *
;                                                                     *
;    Author:  Ing. Matej Baran                                        *
;    Company: ELQET, s.r.o.                                           *
;                                                                     *
;                                                                     *
;**********************************************************************
;                                                                     *
;    Files required: P16F628A.INC                                     *
;                                                                     *
;**********************************************************************
;                                                                     *
;    Notes:                                                           *
;                                                                     *
;**********************************************************************

    list      p=16F628A           ; list directive to define processor
    #include <p16F628A.inc>       ; processor specific variable definitions

    errorlevel  -302              ; suppress message 302 from list file

    __CONFIG   _CP_ON & _DATA_CP_ON & _LVP_OFF & _BOREN_OFF & _MCLRE_ON & _WDT_OFF & _PWRTE_ON & _RC_OSC_NOCLKOUT 

;konstanty
PIS_MEDZ		EQU		0x02 ;urcuje medzeru medzi pismenami
TRV_RIADKU		EQU		0x32 ;0x32 ;50 vykresleni riadku
TRVANIE_FRAME	EQU		0x02 ;cas medzi vykreslenim

;portA
RA0_LED1		EQU		0x00
RA1_LED2		EQU		0x01
RA2_LED3		EQU		0x02
RA3_LED4		EQU		0x03
RA4_TLAC		EQU		0x04
RA5_MCLR		EQU		0x05
RA6_LED5		EQU		0x06
RA7_OSC			EQU		0x07


;portB
RB0_RX			EQU		0x00
RB1_COLOR		EQU		0x01
RB2_LED6		EQU		0x02
RB3_LED7		EQU		0x03
RB4_LED8		EQU		0x04
RB5_LED9		EQU		0x05
RB6_LED10		EQU		0x06
RB7_LED11		EQU		0x07

;stav
TMR0_TICK		EQU		0x00
NAHODA			EQU		0x01
INIT			EQU		0x02
SPRACUJ			EQU		0x03
PISMENO			EQU		0x04
MEDZERA			EQU		0x05
ZMEN_FARBU		EQU		0x06
FARBA			EQU		0x07

;rs232
KAL_OK			EQU		0x00
START_KAL		EQU		0x01
MERAM_KAL		EQU		0x02
DATA_GO			EQU		0x03
EE_WR_OK		EQU		0x04
WRITE_BUF		EQU		0x05
NEVYKRESLUJ		EQU		0x06
RAZ				EQU		0x07

;pohyb_priz
POHYB			EQU		0x00
ZMENA_SMERU		EQU		0x01
DALSI			EQU		0x02
VYMENA			EQU		0x03
MENU			EQU		0x04

;offsety znakov

;tabulka 1
OFFSET_medzernik   EQU   0x00  ;0
OFFSET_vykr   EQU   0x05  ;5 !
OFFSET_dvoj_apostrof    EQU   0x0A  ;10 "
OFFSET_#   EQU   0x0F  ;15
OFFSET_dolar   EQU   0x14  ;20 $
OFFSET_percento   EQU   0x19  ;25 %
OFFSET_and   EQU   0x1E  ;30 &
OFFSET_apostrof   EQU   0x23  ;35 '
OFFSET_lz   EQU   0x28  ;40 (
OFFSET_pz   EQU   0x2D  ;45 )
OFFSET_hviezda   EQU   0x32  ;50 *
OFFSET_plus   EQU   0x37  ;55 +
OFFSET_ciarka   EQU   0x3C  ;60 ,
OFFSET_minus   EQU   0x41  ;65 -
OFFSET_bodka   EQU   0x46  ;70 .
OFFSET_plomitko   EQU   0x4B  ;75 /
OFFSET_0   EQU   0x50  ;80
OFFSET_1   EQU   0x55  ;85
OFFSET_2   EQU   0x5A  ;90
OFFSET_3   EQU   0x5F  ;95
OFFSET_4   EQU   0x64  ;100
OFFSET_5   EQU   0x69  ;105
OFFSET_6   EQU   0x6E  ;110
OFFSET_7   EQU   0x73  ;115
OFFSET_8   EQU   0x78  ;120
OFFSET_9   EQU   0x7D  ;125
OFFSET_dvojbodka   EQU   0x82  ;130 :
OFFSET_bciarka   EQU   0x87  ;135 ;
OFFSET_mensi   EQU   0x8C  ;140 <
OFFSET_rovny   EQU   0x91  ;145 =
OFFSET_vacsi   EQU   0x96  ;150 >
OFFSET_?   EQU   0x9B  ;155
OFFSET_@   EQU   0xA0  ;160
OFFSET_A   EQU   0xA5  ;165
OFFSET_B   EQU   0xAA  ;170
OFFSET_C   EQU   0xAF  ;175
OFFSET_D   EQU   0xB4  ;180
OFFSET_E   EQU   0xB9  ;185
OFFSET_F   EQU   0xBE  ;190
OFFSET_G   EQU   0xC3  ;195
OFFSET_H   EQU   0xC8  ;200
OFFSET_I   EQU   0xCD  ;205
OFFSET_J   EQU   0xD2  ;210
OFFSET_K   EQU   0xD7  ;215
OFFSET_L   EQU   0xDC  ;220
OFFSET_M   EQU   0xE1  ;225
OFFSET_N   EQU   0xE6  ;230
OFFSET_O   EQU   0xEB  ;235
OFFSET_P   EQU   0xF0  ;240
OFFSET_Q   EQU   0xF5  ;245
OFFSET_R   EQU   0xFA  ;250

;tabulka 2
OFFSET_S   EQU   0x00  ;0
OFFSET_T   EQU   0x05  ;5
OFFSET_U   EQU   0x0A  ;10
OFFSET_V   EQU   0x0F  ;15
OFFSET_W   EQU   0x14  ;20
OFFSET_X   EQU   0x19  ;25
OFFSET_Y   EQU   0x1E  ;30
OFFSET_Z   EQU   0x23  ;35
OFFSET_lhz   EQU   0x28  ;40 [
OFFSET_llomitko   EQU   0x2D  ;45 \
OFFSET_phz   EQU   0x32  ;50 ]
OFFSET_striezka   EQU   0x37  ;55 ^
OFFSET__   EQU   0x3C  ;60
OFFSET_opdl   EQU   0x41  ;65 `
OFFSET_a   EQU   0x46  ;70
OFFSET_b   EQU   0x4B  ;75
OFFSET_c   EQU   0x50  ;80
OFFSET_d   EQU   0x55  ;85
OFFSET_e   EQU   0x5A  ;90
OFFSET_f   EQU   0x5F  ;95
OFFSET_g   EQU   0x64  ;100
OFFSET_h   EQU   0x69  ;105
OFFSET_i   EQU   0x6E  ;110
OFFSET_j   EQU   0x73  ;115
OFFSET_k   EQU   0x78  ;120
OFFSET_l   EQU   0x7D  ;125
OFFSET_m   EQU   0x82  ;130
OFFSET_n   EQU   0x87  ;135
OFFSET_o   EQU   0x8C  ;140
OFFSET_p   EQU   0x91  ;145
OFFSET_q   EQU   0x96  ;150
OFFSET_r   EQU   0x9B  ;155
OFFSET_s   EQU   0xA0  ;160
OFFSET_t   EQU   0xA5  ;165
OFFSET_u   EQU   0xAA  ;170
OFFSET_v   EQU   0xAF  ;175
OFFSET_w   EQU   0xB4  ;180
OFFSET_x   EQU   0xB9  ;185
OFFSET_y   EQU   0xBE  ;190
OFFSET_z   EQU   0xC3  ;195
OFFSET_lzlz   EQU   0xC8  ;200 {
OFFSET_stlp   EQU   0xCD  ;205 |
OFFSET_pzlz   EQU   0xD2  ;210 }
OFFSET_ciarka2   EQU   0xD7  ;215 ,
OFFSET_bodka2   EQU   0xDC  ;220 .
OFFSET_dapostrof   EQU   0xE1  ;225 Ñ
OFFSET_m_S   EQU   0xE6  ;230 ä
OFFSET_m_T   EQU   0xEB  ;235 ç
OFFSET_m_Z   EQU   0xF0  ;240 é
OFFSET_m_s   EQU   0xF5  ;245 ö
OFFSET_m_t   EQU   0xFA  ;250 mù

;tabulka 3
OFFSET_m_z   EQU   0x00  ;0 û
OFFSET_makcen   EQU   0x05  ;5 °
OFFSET_paragraf   EQU   0x0A  ;10 ß
OFFSET_stupen   EQU   0x0F  ;15 ∞
OFFSET_m_L   EQU   0x14  ;20 º
OFFSET_m_l   EQU   0x19  ;25 æ
OFFSET_¿   EQU   0x1E  ;30
OFFSET_¡   EQU   0x23  ;35
OFFSET_ƒ   EQU   0x28  ;40
OFFSET_≈   EQU   0x2D  ;45
OFFSET_»   EQU   0x32  ;50
OFFSET_…   EQU   0x37  ;55
OFFSET_Ã   EQU   0x3C  ;60
OFFSET_Õ   EQU   0x41  ;65
OFFSET_œ   EQU   0x46  ;70
OFFSET_“   EQU   0x4B  ;75
OFFSET_”   EQU   0x50  ;80
OFFSET_‘   EQU   0x55  ;85
OFFSET_ÿ   EQU   0x5A  ;90
OFFSET_Ÿ   EQU   0x5F  ;95
OFFSET_⁄   EQU   0x64  ;100
OFFSET_›   EQU   0x69  ;105
OFFSET_‡   EQU   0x6E  ;110
OFFSET_·   EQU   0x73  ;115
OFFSET_‰   EQU   0x78  ;120
OFFSET_Â   EQU   0x7D  ;125
OFFSET_Ë   EQU   0x82  ;130
OFFSET_È   EQU   0x87  ;135
OFFSET_Ï   EQU   0x8C  ;140
OFFSET_Ì   EQU   0x91  ;145
OFFSET_Ô   EQU   0x96  ;150
OFFSET_Ú   EQU   0x9B  ;155
OFFSET_Û   EQU   0xA0  ;160
OFFSET_Ù   EQU   0xA5  ;165
OFFSET_˜   EQU   0xAA  ;170
OFFSET_¯   EQU   0xAF  ;175
OFFSET_˘   EQU   0xB4  ;180
OFFSET_˙   EQU   0xB9  ;185
OFFSET_˝   EQU   0xBE  ;190
OFFSET_koniec	EQU		0xFF ;najnovsi 255 ;novy 195, stary 175

OFFSET_medzera	EQU		0xFF




;***** VARIABLE DEFINITIONS (examples)

; example of using Shared Uninitialized Data Section
INT_VAR        UDATA_SHR     
w_temp         RES     1        ; variable used for context saving 
status_temp    RES     1        ; variable used for context saving

PREMENNE_BANK0	UDATA	0x20
stav			RES		1
vykresli		RES		2
znak			RES		1
eeadr_wr		RES		1
eedata_wr		RES		1
rs232			RES		1
cyklus_int		RES		1
maly_krok		RES		2
velky_krok		RES		2
prijaty_bajt	RES		1
rc_bajt			RES		1
rc_bajt2		RES		1
posun_bitov		RES		1
;ascii
tab_pom			RES		1
tabulka			RES		1
adress_offset	RES		1
offset			RES		1
;buffre
pocet_prij		RES		1
buf_adr			RES		1
buf_data		RES		1
cyklus			RES		1
;find_adr		RES		1
;samotne vykreslovanie
mody			RES		2
mody_zal		RES		2
mody_vyber		RES		2
mod_nahoda		RES		2
mod_nah			RES		1
pismeno			RES		1
pis_off			RES		1
seg_posuv		RES		1
segment			RES		1
trv_medz		RES		1
zalomenie		RES		1
trvanie_r		RES		1
trv_riad		RES		1
pohyb_priz		RES		1
pohyb_poz		RES		1
pohyb_stav		RES		1
port_A			RES		1
port_B			RES		1
random			RES		1
pociatocne		RES		1
;zamkni			RES		1

BUFF_BANK1		UDATA	0xA0
buffer1			RES		0x50

BUFF_BANK2		UDATA	0x120
buffer2			RES		0x30

;**********************************************************************
RESET_VECTOR    CODE   0x0000     ; processor reset vector
        GOTO    Start             ; go to beginning of program
    
INT_VECTOR    CODE    0x0004      ; interrupt vector location

INTERRUPT

        MOVWF   w_temp            ; save off current W register contents
        MOVF    STATUS,w          ; move status register into W register
        MOVWF   status_temp       ; save off contents of STATUS register

		BTFSC	PIR1, TMR1IF
		CALL	Prerusenie_TMR1

		BTFSS	INTCON, INTE
		GOTO	Preskoc_RB0_INT
		BTFSC	INTCON, INTF
		CALL	Prerusenie_RB0
Preskoc_RB0_INT

		BTFSC	PIR1, EEIF
		CALL	Prerusenie_EEPROM

		BTFSC	INTCON, T0IF
		CALL	Prerusenie_TMR0

        MOVF    status_temp,w     ; retrieve copy of STATUS register
        MOVWF   STATUS            ; restore pre-isr STATUS register contents
        SWAPF   w_temp,f
        SWAPF   w_temp,w          ; restore pre-isr W register contents
        RETFIE                    ; return from interrupt

MAIN_PROG     CODE

Start
		BANKSEL	PORTA
		CLRF	PORTA
		CLRF	PORTB
		
		MOVLW	0x07
		MOVWF	CMCON

		BANKSEL OPTION_REG
		MOVLW	0xC7
		MOVWF	OPTION_REG

		MOVLW	0xF0
		MOVWF	INTCON

		MOVLW	0xB0
		MOVWF	TRISA

		MOVLW	0x01
		MOVWF	TRISB
		
		MOVLW	0x81
		MOVWF	PIE1

		BANKSEL PIR1
		CLRF 	PIR1

		;CLRF	zamkni
		CLRF	vykresli
		CLRF	vykresli+1
		BSF		stav, FARBA

		CLRF	rs232
		CLRF	stav
		CLRF	pocet_prij
		CLRF	pohyb_priz

		MOVLW	0xB4
		MOVWF	random

		MOVLW	0x01
		MOVWF	pohyb_poz

		MOVLW	0x02
		MOVWF	zalomenie
		MOVWF	pismeno

		;MOVLW	TRV_RIADKU
		MOVLW	0x00
		CALL	Precitaj_znak_z_EEPROM	
		MOVF	znak, W	
		MOVWF	trvanie_r
		MOVWF	trv_riad

		MOVLW	0x01
		CALL	Precitaj_znak_z_EEPROM
		MOVF	znak, W
		MOVWF	pociatocne

		MOVLW	PIS_MEDZ
		MOVWF	trv_medz

		MOVLW	0x01
		MOVWF	mod_nah
		MOVWF	mody
		MOVWF	mod_nahoda
		MOVWF	mody_vyber
		CLRF	mody+1
		CLRF	mod_nahoda+1
		CLRF	mody_vyber+1

		MOVF	pociatocne, W
		XORLW	0x00
		BTFSC	STATUS, Z
		GOTO	Preskoc_pociatocne_nastavenie
Posuvaj_mod
		BCF		STATUS, C
		RLF		mody, F
		RLF		mody+1, F
		DECFSZ	pociatocne, F
		GOTO	Posuvaj_mod
Preskoc_pociatocne_nastavenie

		MOVLW	0x00
		MOVWF	T1CON
		CLRF	TMR1L
		CLRF	TMR1H

		;pre testovanie
		;MOVLW	0x01
		;MOVWF	vykresli
		;CALL	Vykresli_LED

Nekonecna_slucka
		;test na prekopirovanie dat 
		;z buffra do EEPROM
		BANKSEL rs232
		BTFSS	rs232, WRITE_BUF
		GOTO	Preskoc_prekopirovanie_buffra_do_EEPROM
		BANKSEL	EECON1
		BTFSC	EECON1, WR
		GOTO	Preskoc_prekopirovanie_buffra_do_EEPROM
		CALL	Prekopiruj_z_buffra_do_EEPROM
		MOVLW	0x01
		MOVWF	vykresli
		MOVLW	0x04
		MOVWF	vykresli+1
		BSF		stav, FARBA
		CALL	Vykresli_LED
		BCF		rs232, NEVYKRESLUJ
Cakaj_na_reset
		GOTO	Cakaj_na_reset
Preskoc_prekopirovanie_buffra_do_EEPROM

		BANKSEL stav
		BTFSS	stav, SPRACUJ
		GOTO	Preskoc_spracovanie_rx_bajtu
		MOVF	rc_bajt2, W
		CALL	Spracuj_prijaty_bajt
		BCF		stav, SPRACUJ
Preskoc_spracovanie_rx_bajtu

		BTFSS	rs232, RAZ
		GOTO	Preskoc_zhasnutie_LED
		BCF		rs232, RAZ
		CLRF	vykresli+1
		MOVLW	0x02
		MOVWF	vykresli
		BCF		stav, FARBA
		CALL	Vykresli_LED
Preskoc_zhasnutie_LED

		BTFSC	rs232, NEVYKRESLUJ
		GOTO	Preskoc_vykreslenie

		;tlacitko na zmenu modu 
		;tlacitko na uspanie
		;BANKSEL zamkni
		;BTFSC	zamkni, 0x00
		;GOTO	Preskoc_tlacitko
		BANKSEL PORTA
		BTFSC	PORTA, RA4_TLAC
		GOTO	Preskoc_tlacitko
		BTFSC	pohyb_priz, MENU
		GOTO	Preskoc_inicializaciu_menu
		MOVLW	0x01
		MOVWF	mody
		MOVWF	vykresli
		CLRF	mody+1
		CLRF	vykresli+1
		BSF		stav, FARBA
		CALL	Vykresli_LED
		GOTO	Cakanie_TMR0
Preskoc_inicializaciu_menu
		MOVF	mody, W
		MOVWF	vykresli
		MOVF	mody+1, W
		MOVWF	vykresli+1
		BCF		STATUS, C
		RLF		vykresli, F
		RLF		vykresli+1, F
		BTFSC	PORTB, RB1_COLOR
		BCF		stav, FARBA
		BTFSS	PORTB, RB1_COLOR
		BSF		stav, FARBA
		CALL	Vykresli_LED
Cakanie_TMR0
		MOVLW	0x50
		MOVWF	TMR0
		BCF		stav, TMR0_TICK
Cakaj_na_TMR0
		BTFSS	stav, TMR0_TICK
		GOTO	Cakaj_na_TMR0
Pockaj_na_pustenie_tlacitka
		;BTFSC	zamkni, 0x00
		;GOTO	Preskoc_tlacitko
		BTFSS	PORTA, RA4_TLAC
		GOTO	Pockaj_na_pustenie_tlacitka
		BTFSC	pohyb_priz, MENU
		GOTO	Preskoc_prvykrat
		BSF		pohyb_priz, MENU
		GOTO	Preskoc_tlacitko
Preskoc_prvykrat
		BCF		STATUS, C
		RLF		mody, F
		RLF		mody+1, F
		BTFSS	mody+1, 0x03
		GOTO	Preskoc_tlacitko
		CLRF	vykresli
		CLRF	vykresli+1
		BCF		stav, FARBA
		CALL	Vykresli_LED
		BANKSEL TRISB
		BSF		TRISB, RB1_COLOR
		BANKSEL stav
		SLEEP
Preskoc_tlacitko

		BTFSS	mody+1, 2
		GOTO	Preskoc_nahodu_pre_10		
Zamiesaj_mod
		BCF		STATUS, C
		RLF		mod_nahoda, F
		RLF		mod_nahoda+1, F
		BTFSS	mod_nahoda+1, 2
		GOTO	Preskoc_init_nahoda_mod
		MOVLW	0x01
		MOVWF	mod_nahoda
		CLRF	mod_nahoda+1
Preskoc_init_nahoda_mod
		DECFSZ	mod_nah, F
		GOTO	Zamiesaj_mod
		MOVLW	0x01
		MOVWF	mod_nah
		;test na prekrocenie mod_nahoda
		MOVF	mod_nahoda, W
		SUBLW	0x80 ;ak je vacsie ako 128
		BTFSC	STATUS, C
		GOTO	Preskoc_napravu_1
		MOVLW	0x01
		MOVWF	mod_nahoda
Preskoc_napravu_1
		;test na prekrocenie mod_nahoda+1
		MOVF	mod_nahoda+1, W
		SUBLW	0x03 ;ak je vacsie ako 3
		BTFSC	STATUS, C
		GOTO	Preskoc_napravu_2
		CLRF	mod_nahoda+1
Preskoc_napravu_2
Preskoc_nahodu_pre_10
		

		BTFSS	stav, TMR0_TICK
		GOTO	Preskoc_vykreslenie
		MOVLW	TRVANIE_FRAME
		MOVWF	TMR0
		COMF	TMR0, F
		BCF		stav, TMR0_TICK
		CALL	Nahraj_segment
		CALL	Vykresli_LED
Preskoc_vykreslenie
	
GOTO     Nekonecna_slucka  


Nahraj_segment
;zisti ci je nahodny vyber zapnuty
		BTFSS	mody+1, 2
		GOTO	Preskoc_nahodny_vyber_modu_init
		MOVF	mody, W
		MOVWF	mody_zal
		MOVF	mody+1, W
		MOVWF	mody_zal+1
		MOVF	mody_vyber, W
		MOVWF	mody
		MOVF	mody_vyber+1, W
		MOVWF	mody+1
		BSF		pohyb_priz, VYMENA
		BTFSS	pohyb_priz, DALSI
		GOTO	Preskoc_nahodny_vyber_modu_init
		BCF		pohyb_priz, DALSI
		MOVF	mod_nahoda, W
		SUBWF	mody_vyber, W
		BTFSC	STATUS, C
		MOVF	mod_nahoda+1, W
		BTFSS	STATUS, C
		INCF	mod_nahoda+1, W
		SUBWF	mody_vyber+1, W
		BTFSS	STATUS, Z
		GOTO	Preskoc_iny_vyber
		BCF		STATUS, C
		RRF		mod_nahoda+1, F
		RRF		mod_nahoda, F
		BTFSS	STATUS, C
		GOTO	Preskoc_iny_vyber
		MOVLW	0x02
		MOVWF	mod_nahoda
		CLRF	mod_nahoda+1
Preskoc_iny_vyber
		MOVF	mod_nahoda, W
		MOVWF	mody_vyber
		MOVF	mod_nahoda+1, W
		MOVWF	mody_vyber+1
Preskoc_nahodny_vyber_modu_init
;zisti ci nasleduje medzera medzi pismenami
		BTFSS	stav, MEDZERA
		GOTO	Preskoc_medzeru
		CLRF	vykresli
		CLRF	vykresli+1
		DECFSZ	trv_medz, F
		GOTO	Koniec_vyberu
		BCF		stav, MEDZERA
		BCF		stav, PISMENO
		GOTO	Koniec_vyberu
Preskoc_medzeru
;zisti ci bolo vybrane pismeno
		BTFSC	stav, PISMENO
		GOTO	Preskoc_vyber_pismena

		MOVF	pismeno, W
		CALL	Precitaj_znak_z_EEPROM

		MOVF	znak, W
		XORLW	0x20 ;32 - medzernik
		BTFSS	STATUS, Z
		GOTO	Preskoc_mod0_medzera
;mod 0 - zmen farbu ak narazis na medzeru - kazde slovo
		BTFSC	mody, 0
		BSF		stav, ZMEN_FARBU
;mod 9 - zmen farbu ak narazis na medzeru - kazde slovo
		BTFSC	mody+1, 1
		BSF		stav, ZMEN_FARBU
		GOTO	Preskoc_mod_6_pre_medzeru
Preskoc_mod0_medzera
;mod 6 - pohyb pismenok hore - dole
		BTFSC	mody, 6
		BSF		pohyb_priz, POHYB
;mod 0 - pohyb pismenok hore - dole
		BTFSC	mody, 0
		BSF		pohyb_priz, POHYB
;mod 8 - zapne nahodny vyber farby pre kazde pismeno
		BTFSC	mody+1, 0
		BSF		stav, NAHODA
;mod 1 - zmen farbu kazde pismeno
		BTFSC	mody, 1
		BSF		stav, ZMEN_FARBU
Preskoc_mod_6_pre_medzeru

		MOVF	znak, W
		XORLW	0xFF
		BTFSS	STATUS, Z
		GOTO	Preskoc_riesenie_FF_znaku
		DECFSZ	trvanie_r, F
		GOTO	Preskoc_skok_na_dalsi_riadok_FF
		MOVF	trv_riad, W	
		MOVWF	trvanie_r
		MOVLW	0x02
		MOVWF	zalomenie
;povoli nahodne vybranie modu
		BSF		pohyb_priz, DALSI
;mod 5 - zmen farbu ak skocis na zaciatok
		BTFSC	mody, 5
		BSF		stav, ZMEN_FARBU
;mod 6 - zmen farbu ak skocis na zaciatok
		BTFSC	mody, 6
		BSF		stav, ZMEN_FARBU
Preskoc_skok_na_dalsi_riadok_FF
		MOVF	zalomenie, W
		MOVWF	pismeno
;mod 0 - zmen farbu ak skocis na zaciatok
		BTFSC	mody, 0	
		BSF		stav, ZMEN_FARBU
;mod 9 - zmen farbu ak skocis na zaciatok
		BTFSC	mody+1, 1
		BSF		stav, ZMEN_FARBU
		GOTO	Preskoc_priratavanie
Preskoc_riesenie_FF_znaku

		MOVF	znak, W
		XORLW	0x0D ;13
		BTFSS	STATUS, Z
		GOTO	Preskoc_riesenie_0D_znaku
		DECFSZ	trvanie_r, F
		GOTO	Preskoc_skok_na_dalsi_riadok_0D
		MOVF	trv_riad, W	
		MOVWF	trvanie_r
		INCF	pismeno, W
		MOVWF	zalomenie
;povoli nahodne vybranie modu
		BSF		pohyb_priz, DALSI
;mod 5 - zmen farbu kazdy novy riadok
		BTFSC	mody, 5
		BSF		stav, ZMEN_FARBU
;mod 6 - zmen farbu kazdy novy riadok
		BTFSC	mody, 6
		BSF		stav, ZMEN_FARBU
Preskoc_skok_na_dalsi_riadok_0D
		MOVF	zalomenie, W
		MOVWF	pismeno
;mod 0 - zmen farbu kazdy novy riadok
		BTFSC	mody, 0	
		BSF		stav, ZMEN_FARBU
;mod 9 - zmen farbu kazdy novy riadok
		BTFSC	mody+1, 1
		BSF		stav, ZMEN_FARBU
		GOTO	Preskoc_priratavanie
Preskoc_riesenie_0D_znaku

		INCF	pismeno, F
		MOVF	pismeno, W
		XORLW	0x80 ;128
		BTFSS	STATUS, Z
		GOTO	Preskoc_priratavanie
		MOVF	zalomenie, W
		MOVWF	pismeno
Preskoc_priratavanie

		MOVF	znak, W
		CALL	Prevod_ASCII_offset
		MOVWF	pis_off
		BSF		stav, PISMENO
		CLRF	seg_posuv
Preskoc_vyber_pismena

		MOVF	seg_posuv, W
		ADDWF	pis_off, W		
		CALL	Vyber_z_tabulky_segment
		MOVWF	segment
		INCF	seg_posuv, F
		MOVF	seg_posuv, W
		XORLW	0x05
		BTFSS	STATUS, Z
		GOTO	Preskoc_priznak_medzera
		BSF		stav, MEDZERA
		MOVLW	PIS_MEDZ
		MOVWF	trv_medz
		CLRF	seg_posuv
Preskoc_priznak_medzera
;mod 2 - zmen farbu kazdy segment
		BTFSC	mody, 2
		BSF		stav, ZMEN_FARBU

;priznak zmeny farby
		BTFSS	stav, ZMEN_FARBU
		GOTO	Preskoc_zmenu_farby
		BCF		stav, ZMEN_FARBU
		BTFSC	stav, FARBA
		GOTO	Zmen_na_cervenu
Zmen_na_zelenu_mod1
		BSF		stav, FARBA ;zelena
		GOTO	Preskoc_zmenu_farby
Zmen_na_cervenu
		BCF		stav, FARBA ;cervena		
Preskoc_zmenu_farby

;mod 3 - zmen farbu iba na cervenu
		BTFSC	mody, 3
		BCF		stav, FARBA ;cervena

;mod 4 - zmen farbu iba na zelenu
		BTFSC	mody, 4
		BSF		stav, FARBA ;zelena

;mod 7 - zapne nahodny vyber farby pre segment
		BTFSC	mody, 7
		BSF		stav, NAHODA

		BTFSS	stav, NAHODA
		GOTO	Preskoc_random_farba
		BCF		stav, NAHODA
        BCF		STATUS, C
        RLF     random, 1
        SWAPF   random, 0
        ANDLW   0xE0
        RRF     random, 1
        ADDWF   random, 0
        ADDWF   random, 0
        ADDWF   random, 0
        SUBLW   0x35
        MOVWF   random
		BTFSC	random, 3
		BSF		stav, FARBA
		BTFSS	random, 3
		BCF		stav, FARBA
Preskoc_random_farba

		MOVF	segment, W
		MOVWF	vykresli
		CLRF	vykresli+1

;presun segmentu na vykreslenie
;mod 0 - aktivuj pohyb hore - dole
		BTFSC	mody, 0
		GOTO	Pohyb_mod_0
;mod 6 - aktivuj pohyb hore - dole
		BTFSS	mody, 6
		GOTO	Preskoc_pohyb

Pohyb_mod_0

		BTFSS	pohyb_priz, POHYB
		GOTO	Preskoc_prepnutie_smeru_C
		BCF		pohyb_priz, POHYB

		BTFSC	pohyb_priz, ZMENA_SMERU
		GOTO	Zmen_smer_posuvu
		BCF		STATUS, C
		RLF		pohyb_poz, F
		BTFSS	pohyb_poz, 4
		GOTO	Preskoc_prepnutie_smeru_4
		MOVLW	0x04
		MOVWF	pohyb_poz
		BSF		pohyb_priz, ZMENA_SMERU
Preskoc_prepnutie_smeru_4
		GOTO	Preskoc_prepnutie_smeru_C
Zmen_smer_posuvu
		BCF		STATUS, C
		RRF		pohyb_poz, F
		BTFSS	STATUS, C
		GOTO	Preskoc_prepnutie_smeru_C
		MOVLW	0x02
		MOVWF	pohyb_poz
		BCF		pohyb_priz, ZMENA_SMERU
Preskoc_prepnutie_smeru_C

		BTFSC	pohyb_poz, 0
		GOTO	Preskoc_pohyb
		BTFSC	pohyb_poz, 1
		MOVLW	0x01
		BTFSC	pohyb_poz, 2
		MOVLW	0x02
		BTFSC	pohyb_poz, 3
		MOVLW	0x03
		MOVWF	pohyb_stav

Posun_dolava_xkrat
		BCF		STATUS, C
		RLF		vykresli, F
		RLF		vykresli+1, F
		DECFSZ	pohyb_stav, F
		GOTO	Posun_dolava_xkrat
Preskoc_pohyb
Koniec_vyberu

		BTFSS	mody+1, 1
		GOTO	Preskoc_mod_9
		BCF		STATUS, C
		RLF		vykresli, F
		RLF		vykresli+1, F
		COMF	vykresli, F
		COMF	vykresli+1, F
Preskoc_mod_9

;zisti ci je nahodny vyber zapnuty
		BTFSS	pohyb_priz, VYMENA
		GOTO	Preskoc_nahodny_vyber_modu_end
		BCF		pohyb_priz, VYMENA
		MOVF	mody_zal, W
		MOVWF	mody
		MOVF	mody_zal+1, W
		MOVWF	mody+1
Preskoc_nahodny_vyber_modu_end
					
RETURN


Spracuj_prijaty_bajt
		MOVWF	prijaty_bajt
		XORLW	0xFE
		BTFSS	STATUS, Z
		GOTO	Preskoc_inicializaciu_bajtu
		BSF		stav, INIT
		BCF		rs232, WRITE_BUF
		CLRF	pocet_prij
		GOTO	Inicializacia_ok
Preskoc_inicializaciu_bajtu
		BTFSS	stav, INIT
		GOTO	Zahod_bajt
		MOVF	prijaty_bajt, W
		XORLW	0xFF
		BTFSS	STATUS, Z
		GOTO	Preskoc_ukoncenie_prijmu
		BCF		stav, INIT
		BSF		rs232, WRITE_BUF
		CALL	Zapis_do_buffra
		GOTO	Koniec_obsluhy_prijmu
Preskoc_ukoncenie_prijmu
		CALL	Zapis_do_buffra
		INCF	pocet_prij, F
		MOVF	pocet_prij, W
		XORLW	0x80 ;128
		BTFSS	STATUS, Z
		GOTO	Koniec_obsluhy_prijmu
		BCF		stav, INIT
		BSF		rs232, WRITE_BUF
Inicializacia_ok
Zahod_bajt	
Koniec_obsluhy_prijmu	
RETURN


Zapis_do_buffra
		BANKSEL	pocet_prij
		MOVF	pocet_prij, W
		SUBLW	0x4F ;79
		BTFSS	STATUS, C
		GOTO	Zapis_do_buffera2
		BANKSEL buffer1
		MOVLW	buffer1
		BANKSEL pocet_prij
		ADDWF	pocet_prij, W
		MOVWF	FSR
		MOVF	prijaty_bajt, W
		BANKSEL buffer1
		MOVWF	INDF
		GOTO	Koniec_zapisu_do_buffera
Zapis_do_buffera2
		BANKSEL pocet_prij
		MOVLW	0x50
		SUBWF	pocet_prij, W
		BSF		STATUS, IRP ;banky 2 - 3
		BANKSEL buffer2
		ADDLW	buffer2
		MOVWF	FSR
		BCF		STATUS, IRP ;banky 0 - 1
		BANKSEL prijaty_bajt
		MOVF	prijaty_bajt, W
		BSF		STATUS, IRP ;banky 2 - 3
		BANKSEL buffer2
		MOVWF	INDF
Koniec_zapisu_do_buffera
		BCF		STATUS, IRP ;banky 0 - 1
		BANKSEL prijaty_bajt
RETURN


Prekopiruj_z_buffra_do_EEPROM
		BANKSEL	rs232
		BSF		rs232, EE_WR_OK
		CLRF	buf_adr
Kopirujem_data
		MOVF	buf_adr, W
		SUBLW	0x4F ;79
		BTFSS	STATUS, C
		GOTO	Citaj_z_buffera2
		BANKSEL buffer1
		MOVLW	buffer1
		BANKSEL buf_adr
		ADDWF	buf_adr, W
		MOVWF	FSR
		BANKSEL buffer1
		MOVF	INDF, W
		BANKSEL buf_data
		MOVWF	buf_data
		GOTO	Koniec_citania_z_buffera
Citaj_z_buffera2
		BANKSEL buf_adr
		MOVLW	0x50
		SUBWF	buf_adr, W
		BSF		STATUS, IRP ;banky 2 - 3
		BANKSEL buffer2
		ADDLW	buffer2
		MOVWF	FSR
		MOVF	INDF, W
		BCF		STATUS, IRP ;banky 0 - 1
		BANKSEL buf_data
		MOVWF	buf_data
Koniec_citania_z_buffera

		MOVF	buf_adr, W
		MOVWF	eeadr_wr
		MOVF	buf_data, W
		MOVWF	eedata_wr
Cakam_na_povolenie
		CLRWDT
		BTFSS	rs232, EE_WR_OK
		GOTO	Cakam_na_povolenie
		CALL	Zapis_znak_do_EEPROM

		BANKSEL	rs232
		BCF		rs232, EE_WR_OK

		INCF	buf_adr, F

		MOVF	buf_adr, W
		XORLW	0x80 ;128
		BTFSC	STATUS, Z
		GOTO	Ukonci_kopirovanie

		MOVF	buf_data, W
		XORLW	0xFF
		BTFSS	STATUS, Z
		GOTO	Kopirujem_data
Ukonci_kopirovanie
		BANKSEL rs232
		BCF		rs232, WRITE_BUF
Cakam_na_povolenie2
		CLRWDT
		BTFSS	rs232, EE_WR_OK
		GOTO	Cakam_na_povolenie2

		;CALL	Najdi_ukoncenie	
RETURN


;Najdi_ukoncenie
;		MOVLW	0x80
;		MOVWF	cyklus
;		CLRF	find_adr
;		BCF		stav, UKONC
;Hladam_ukoncovaci_znak
;		MOVF	find_adr, W
;		CALL	Precitaj_znak_z_EEPROM
;		MOVF	znak, W
;		XORLW	0xFF
;		BTFSS	STATUS, Z
;		GOTO	Testuj_dalsi_znak
;		BSF		stav, UKONC
;		GOTO	Koniec_hladania_ukoncenia
;Testuj_dalsi_znak
;		INCF	find_adr	
;		DECFSZ	cyklus, F
;		GOTO	Hladam_ukoncovaci_znak
;Koniec_hladania_ukoncenia
;RETURN


Vykresli_LED
		MOVF	PORTA, W
		MOVWF	port_A
		MOVF	PORTB, W
		MOVWF	port_B
		BANKSEL TRISB
		MOVLW	0xFF
		MOVWF	TRISB
		MOVLW	0x7F
		MOVWF	TRISA		
		BANKSEL stav

		BTFSC	stav, FARBA
		BSF		port_B, RB1_COLOR
		BTFSS	stav, FARBA
		BCF		port_B, RB1_COLOR

		BTFSC	stav, FARBA
		GOTO	Zelena_farba
Cervena_farba
		MOVLW	0xB0
		ANDWF	port_A, F
		MOVLW	0x03
		ANDWF	port_B, F
		BTFSC	vykresli, 0
		BSF		port_A, RA2_LED3 ;ok    ;RA0_LED1
		BTFSC	vykresli, 1
		BSF		port_A, RA3_LED4 ;ok	;RA1_LED2
		BTFSC	vykresli, 2
		BSF		port_A, RA1_LED2 ;ok
		BTFSC	vykresli, 3
		BSF		port_A, RA0_LED1 ;ok 
		BTFSC	vykresli, 4
		BSF		port_A, RA6_LED5 ;ok
		BTFSC	vykresli, 5
		BSF		port_B, RB7_LED11;ok	;RB2_LED6
		BTFSC	vykresli, 6
		BSF		port_B, RB6_LED10 ;ok	;RB3_LED7
		BTFSC	vykresli, 7
		BSF		port_B, RB5_LED9 ;ok	;RB4_LED8
		BTFSC	vykresli+1, 0
		BSF		port_B, RB4_LED8 ;ok    ;RB5_LED9
		BTFSC	vykresli+1, 1
		BSF		port_B, RB2_LED6 ;ok
		BTFSC	vykresli+1, 2
		BSF		port_B, RB3_LED7 ;ok
		BANKSEL TRISA
		MOVLW	0xB0
		MOVWF	TRISA
		MOVLW	0x01
		MOVWF	TRISB
		BANKSEL PORTB
		MOVLW	0x01
		ANDWF	PORTB, F
		MOVF	port_B, W
		IORWF	PORTB, F
		MOVLW	0xB0
		ANDWF	PORTA, F
		MOVF	port_A, W
		IORWF	PORTA, F
		GOTO	Koniec_vykreslovania
Zelena_farba
		MOVLW	0x4F
		IORWF	port_A, F
		MOVLW	0xFC
		IORWF	port_B, F
		BTFSC	vykresli, 0
		BCF		port_A, RA2_LED3 ;ok    ;RA0_LED1
		BTFSC	vykresli, 1
		BCF		port_A, RA3_LED4 ;ok	;RA1_LED2
		BTFSC	vykresli, 2
		BCF		port_A, RA1_LED2 ;ok
		BTFSC	vykresli, 3
		BCF		port_A, RA0_LED1 ;ok 
		BTFSC	vykresli, 4
		BCF		port_A, RA6_LED5 ;ok
		BTFSC	vykresli, 5
		BCF		port_B, RB7_LED11;ok	;RB2_LED6
		BTFSC	vykresli, 6
		BCF		port_B, RB6_LED10 ;ok	;RB3_LED7
		BTFSC	vykresli, 7
		BCF		port_B, RB5_LED9 ;ok	;RB4_LED8
		BTFSC	vykresli+1, 0
		BCF		port_B, RB4_LED8 ;ok    ;RB5_LED9
		BTFSC	vykresli+1, 1
		BCF		port_B, RB2_LED6 ;ok
		BTFSC	vykresli+1, 2
		BCF		port_B, RB3_LED7 ;ok
		BANKSEL TRISA
		MOVLW	0xB0
		MOVWF	TRISA
		MOVLW	0x01
		MOVWF	TRISB
		BANKSEL PORTB
		MOVLW	0xFE
		IORWF	PORTB, F
		MOVF	port_B, W
		ANDWF	PORTB, F
		MOVLW	0x4F
		IORWF	PORTA, F	
		MOVF	port_A, W
		ANDWF	PORTA, F
Koniec_vykreslovania
		BTFSC	PORTB, RB1_COLOR
		MOVLW	0x02
		BTFSS	PORTB, RB1_COLOR
		MOVLW	0x01
		BTFSC	vykresli, 2
		ADDLW	0x02
		MOVWF	mod_nah
RETURN


Precitaj_znak_z_EEPROM
		BANKSEL EEADR
		MOVWF	EEADR
		BSF		EECON1, RD
		MOVF	EEDATA, W
		BANKSEL	znak
		MOVWF	znak
RETURN


Zapis_znak_do_EEPROM
		BANKSEL eeadr_wr
		MOVF	eeadr_wr, W
		BANKSEL	EEADR
		MOVWF	EEADR
		BANKSEL eedata_wr
		MOVF	eedata_wr, W
		BANKSEL EEDATA
		MOVWF	EEDATA
		BANKSEL EECON1
		BSF		EECON1, WREN
		BCF		INTCON, GIE
		BTFSC	INTCON, GIE
		GOTO	$-2
		MOVLW	0x55
		MOVWF	EECON2
		MOVLW	0xAA
		MOVWF	EECON2
		BSF		EECON1, WR
		BSF		INTCON, GIE
		BCF		EECON1, WREN
		BANKSEL	eeadr_wr
RETURN


;##############################################################
;####################### PRERUSENIA ###########################
;##############################################################

Prerusenie_RB0
		BCF		INTCON, INTF

		;BANKSEL PORTA
		;BTFSC	PORTA, RA4_TLAC
		;GOTO	Koniec_rc

		;BANKSEL zamkni
		;BSF		zamkni, 0x00

		BANKSEL rs232
		BTFSC	rs232, DATA_GO
		GOTO	Koniec_rc

		BTFSS	rs232, KAL_OK
		GOTO	Preskoc_kal_ok
		MOVF	maly_krok, W
		MOVWF	TMR1L
		MOVF	maly_krok+1, W
		MOVWF	TMR1H
		MOVLW	0x08
		MOVWF	posun_bitov
		BSF		rs232, DATA_GO
		BCF		INTCON, INTE
		BCF		PIR1, TMR1IF
		BSF		T1CON, TMR1ON
		GOTO	Koniec_rc
Preskoc_kal_ok

		BTFSC	rs232, START_KAL
		GOTO	Preskoc_kalibraciu
		BTFSS	PORTB, RB0_RX
		GOTO	Koniec_rc
		CLRF	TMR1L
		CLRF	TMR1H
		BSF		T1CON, TMR1ON
		;CLRF	pocet_prij
		BSF		rs232, NEVYKRESLUJ
		BSF		rs232, RAZ
		BANKSEL OPTION_REG
		BCF		OPTION_REG, INTEDG
		BANKSEL	rs232
		BSF		rs232, START_KAL
		GOTO	Koniec_rc
Preskoc_kalibraciu	

		BTFSC	rs232, MERAM_KAL
		GOTO	Preskoc_vypocet_kroku
		BTFSS	PORTB, RB0_RX
		GOTO	Preskoc_chybu
		CLRF	vykresli+1
		MOVLW	0x01
		MOVWF	vykresli
		BCF		stav, FARBA
		CALL	Vykresli_LED
Koniec_chyba_0x01	
		GOTO	Koniec_chyba_0x01
Preskoc_chybu
		BANKSEL OPTION_REG
		BSF		OPTION_REG, INTEDG
		BANKSEL	T1CON
		BCF		T1CON, TMR1ON
		MOVF	TMR1L, W
		MOVWF	velky_krok
		MOVF	TMR1H, W
		MOVWF	velky_krok+1
		MOVLW	0x03
		MOVWF	cyklus_int
Delenie_8
		BCF		STATUS, C
		RRF		velky_krok+1, F
		RRF		velky_krok, F
		DECFSZ	cyklus_int, F
		GOTO	Delenie_8

		BCF		STATUS, C
		RRF		velky_krok+1, W
		MOVWF	maly_krok+1
		RRF		velky_krok, W
		MOVWF	maly_krok

		MOVLW	0x1B ;27 taktov
		SUBWF	velky_krok, F
		BTFSC	STATUS, C
		MOVLW	0x00
		BTFSS	STATUS, C
		MOVLW	0x01
		SUBWF	velky_krok+1, F

		MOVF	velky_krok, W
		ADDWF	maly_krok, F
		BTFSC	STATUS, C
		INCF	velky_krok+1, W
		BTFSS	STATUS, C
		MOVF	velky_krok+1, W
		ADDWF	maly_krok+1, F

		COMF	maly_krok, F
		COMF	maly_krok+1, F

		COMF	velky_krok, F
		COMF	velky_krok+1, F
		
		BSF		rs232, KAL_OK
		BSF		rs232, MERAM_KAL
		GOTO	Koniec_rc		
Preskoc_vypocet_kroku
		
Koniec_rc
RETURN


Prerusenie_EEPROM
		BCF		PIR1, EEIF
		BANKSEL	rs232
		BSF		rs232, EE_WR_OK
RETURN


Prerusenie_TMR0
		BCF		INTCON, T0IF
		BSF		stav, TMR0_TICK
RETURN


Prerusenie_TMR1
;		BSF		stav, TMR1_TICK
		BTFSS	rs232, DATA_GO
		GOTO	TMR1_end
		BCF		STATUS, C
		BTFSS	PORTB, RB0_RX
		BSF		STATUS, C
		RRF		rc_bajt, F
		MOVF	velky_krok, W
		MOVWF	TMR1L
		MOVF	velky_krok+1, W
		MOVWF	TMR1H
		DECFSZ	posun_bitov, F
		GOTO	TMR1_end
		BCF		T1CON, TMR1ON
		MOVF	rc_bajt, W
		MOVWF	rc_bajt2
		;MOVWF	vykresli
		;CALL	Vykresli_LED
		BSF		stav, SPRACUJ
		;BCF		rs232, DATA_GO
		;CLRF	rs232
		BCF		rs232, DATA_GO
		BCF		INTCON, INTF
		BSF		INTCON, INTE
TMR1_end
		BCF		PIR1, TMR1IF
RETURN

;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TABULKY ASCII %%%%%%%%%%%%%%%%%%%%%%%%
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Prevod_ASCII_offset ORG 0x03C4
		MOVWF tab_pom
		CLRF  tabulka
		XORLW 0xFF
		BTFSS STATUS, Z
		GOTO  Preskoc_znak_255
		GOTO  Ofset_medzera
Preskoc_znak_255

		MOVF	tab_pom, W
		XORLW 0x0D
		BTFSS STATUS, Z
		GOTO  Preskoc_znak_13
		GOTO  Ofset_medzera
Preskoc_znak_13	

		MOVLW 0x1F ;31
		SUBWF tab_pom, W
		MOVWF adress_offset ;uloz W do adress_offset
		MOVLW LOW TabulkaText ;W = low 8 bitov z adresy
		ADDWF adress_offset,F
		MOVLW HIGH TabulkaText ;W = high 8 bitov z adresy
		BTFSC STATUS,C ;PAGE CROSSED?
		ADDLW 0x01 ;ak ano tak W = W + 1
		MOVWF PCLATH ;nahraj high adress to latch
		MOVF  adress_offset, W
		CALL  TabulkaText
		MOVWF offset ;zisteny offset

;test pre 3 tabulku
		MOVF  tab_pom, W
		SUBLW 0x9D ;157   - koniec 2. tabulky
;k - W => W		157 - W -> W
		BTFSC STATUS, C ;ak je kladne - preskoc 3. tabulku
		GOTO  Preskoc_3tab
		MOVF  offset, W
		SUBLW OFFSET_medzera ;zisti ci offset je medzera
		BTFSC STATUS, Z
		GOTO  Ofset_medzera	;ak je medzera
		BSF   tabulka, 0x02 ;tabulka 3
		GOTO  Koniec_testu
Preskoc_3tab

;test pre 2 tabulku
		MOVF  tab_pom,W
		SUBLW 0x52 ;82   - koniec 1. tabulky
;k - W => W		82 - W -> W
		BTFSC STATUS, C ;ak je kladne - preskoc 2. tabulku
		GOTO  Preskoc_2tab
		MOVF  offset, W
		SUBLW OFFSET_medzera ;zisti ci offset je medzera
		BTFSC STATUS, Z
		GOTO  Ofset_medzera	;ak je medzera
		BSF   tabulka, 0x01 ;tabulka 2
		GOTO  Koniec_testu
Preskoc_2tab
		BSF   tabulka, 0x00 ;1. tabulka
		GOTO  Koniec_testu

Ofset_medzera
		MOVLW OFFSET_medzernik
		MOVWF offset
		BSF   tabulka, 0x00 ;medzera je v 1. tabulke
Koniec_testu
		MOVF  offset, W		
		RETURN


TabulkaText ORG 0x0401
		;ADDWF PCL, F
		MOVWF PCL
		RETLW OFFSET_medzernik	;32

		RETLW OFFSET_vykr	;33
		RETLW OFFSET_dvoj_apostrof	;34
		RETLW OFFSET_#	;35
		RETLW OFFSET_dolar	;36
		RETLW OFFSET_percento	;37
		RETLW OFFSET_and	;38
		RETLW OFFSET_apostrof	;39

		RETLW OFFSET_lz	;40
		RETLW OFFSET_pz	;41
		RETLW OFFSET_hviezda	;42
		RETLW OFFSET_plus	;43
		RETLW OFFSET_ciarka	;44
		RETLW OFFSET_minus	;45
		RETLW OFFSET_bodka	;46
		RETLW OFFSET_plomitko	;47
		RETLW OFFSET_0	;48
		RETLW OFFSET_1	;49

		RETLW OFFSET_2	;50
		RETLW OFFSET_3	;51
		RETLW OFFSET_4	;52
		RETLW OFFSET_5	;53
		RETLW OFFSET_6	;54
		RETLW OFFSET_7	;55
		RETLW OFFSET_8	;56
		RETLW OFFSET_9	;57
		RETLW OFFSET_dvojbodka	;58 
		RETLW OFFSET_bciarka	;59

		RETLW OFFSET_mensi	;60
		RETLW OFFSET_rovny	;61
		RETLW OFFSET_vacsi	;62
		RETLW OFFSET_?	;63
		RETLW OFFSET_@	;64
		RETLW OFFSET_A	;65
		RETLW OFFSET_B	;66
		RETLW OFFSET_C	;67
		RETLW OFFSET_D	;68
		RETLW OFFSET_E	;69

		RETLW OFFSET_F	;70
		RETLW OFFSET_G	;71
		RETLW OFFSET_H	;72
		RETLW OFFSET_I	;73
		RETLW OFFSET_J	;74
		RETLW OFFSET_K	;75
		RETLW OFFSET_L	;76
		RETLW OFFSET_M	;77
		RETLW OFFSET_N	;78
		RETLW OFFSET_O	;79

		RETLW OFFSET_P	;80
		RETLW OFFSET_Q	;81
		RETLW OFFSET_R	;82
		RETLW OFFSET_S	;83
		RETLW OFFSET_T	;84
		RETLW OFFSET_U	;85
		RETLW OFFSET_V	;86
		RETLW OFFSET_W	;87
		RETLW OFFSET_X	;88
		RETLW OFFSET_Y	;89

		RETLW OFFSET_Z	;90
		RETLW OFFSET_lhz	;91
		RETLW OFFSET_llomitko	;92
		RETLW OFFSET_phz	;93
		RETLW OFFSET_striezka	;94
		RETLW OFFSET__	;95
		RETLW OFFSET_opdl	;96
		RETLW OFFSET_a	;97 
		RETLW OFFSET_b	;98
		RETLW OFFSET_c	;99

		RETLW OFFSET_d	;100
		RETLW OFFSET_e	;101
		RETLW OFFSET_f	;102
		RETLW OFFSET_g	;103
		RETLW OFFSET_h	;104
		RETLW OFFSET_i	;105
		RETLW OFFSET_j	;106
		RETLW OFFSET_k	;107
		RETLW OFFSET_l	;108
		RETLW OFFSET_m	;109

		RETLW OFFSET_n	;110
		RETLW OFFSET_o	;111
		RETLW OFFSET_p	;112
		RETLW OFFSET_q	;113
		RETLW OFFSET_r	;114
		RETLW OFFSET_s	;115
		RETLW OFFSET_t	;116
		RETLW OFFSET_u	;117
		RETLW OFFSET_v	;118
		RETLW OFFSET_w	;119

		RETLW OFFSET_x	;120
		RETLW OFFSET_y	;121
		RETLW OFFSET_z	;122
		RETLW OFFSET_lzlz	;123
		RETLW OFFSET_stlp	;124
		RETLW OFFSET_pzlz	;125
		RETLW OFFSET_koniec	;126 ;povodne OFFSET_koniec
		RETLW OFFSET_medzera	;127
		RETLW OFFSET_medzera	;128
		RETLW OFFSET_medzera	;129

		RETLW OFFSET_ciarka2	;130
		RETLW OFFSET_bodka2		;131
		RETLW OFFSET_dapostrof	;132
		RETLW OFFSET_medzera	;133
		RETLW OFFSET_medzera	;134
		RETLW OFFSET_medzera	;135
		RETLW OFFSET_medzera	;136
		RETLW OFFSET_medzera	;137
		RETLW OFFSET_m_S	;138
		RETLW OFFSET_medzera	;139

		RETLW OFFSET_medzera	;140
		RETLW OFFSET_m_T	;141
		RETLW OFFSET_m_Z	;142
		RETLW OFFSET_medzera	;143
		RETLW OFFSET_medzera	;144
		RETLW OFFSET_medzera	;145
		RETLW OFFSET_medzera	;146
		RETLW OFFSET_medzera	;147
		RETLW OFFSET_medzera	;148
		RETLW OFFSET_medzera	;149

		RETLW OFFSET_medzera	;150
		RETLW OFFSET_medzera	;151
		RETLW OFFSET_medzera	;152
		RETLW OFFSET_medzera	;153
		RETLW OFFSET_m_s	;154
		RETLW OFFSET_medzera	;155
		RETLW OFFSET_medzera	;156
		RETLW OFFSET_m_t	;157
		RETLW OFFSET_m_z	;158
		RETLW OFFSET_medzera	;159

		RETLW OFFSET_medzera	;160
		RETLW OFFSET_makcen	;161
		RETLW OFFSET_medzera	;162
		RETLW OFFSET_medzera	;163
		RETLW OFFSET_medzera	;164
		RETLW OFFSET_medzera	;165
		RETLW OFFSET_medzera	;166
		RETLW OFFSET_paragraf	;167
		RETLW OFFSET_medzera	;168
		RETLW OFFSET_medzera	;169

		RETLW OFFSET_medzera	;170
		RETLW OFFSET_medzera	;171
		RETLW OFFSET_medzera	;172
		RETLW OFFSET_medzera	;173
		RETLW OFFSET_medzera	;174
		RETLW OFFSET_medzera	;175
		RETLW OFFSET_stupen		;176
		RETLW OFFSET_medzera	;177
		RETLW OFFSET_medzera	;178
		RETLW OFFSET_medzera	;179

		RETLW OFFSET_medzera	;180
		RETLW OFFSET_medzera	;181
		RETLW OFFSET_medzera	;182
		RETLW OFFSET_medzera	;183
		RETLW OFFSET_medzera	;184
		RETLW OFFSET_medzera	;185
		RETLW OFFSET_medzera	;186
		RETLW OFFSET_medzera	;187
		RETLW OFFSET_m_L		;188
		RETLW OFFSET_medzera	;189

		RETLW OFFSET_m_l		;190
		RETLW OFFSET_medzera	;191
		RETLW OFFSET_¿			;192
		RETLW OFFSET_¡			;193
		RETLW OFFSET_medzera	;194
		RETLW OFFSET_medzera	;195
		RETLW OFFSET_ƒ			;196
		RETLW OFFSET_≈			;197
		RETLW OFFSET_medzera	;198
		RETLW OFFSET_medzera	;199

		RETLW OFFSET_»	;200
		RETLW OFFSET_…	;201
		RETLW OFFSET_medzera	;202
		RETLW OFFSET_medzera	;203
		RETLW OFFSET_Ã	;204
		RETLW OFFSET_Õ	;205
		RETLW OFFSET_medzera	;206
		RETLW OFFSET_œ	;207
		RETLW OFFSET_medzera	;208
		RETLW OFFSET_medzera	;209

		RETLW OFFSET_“	;210
		RETLW OFFSET_”	;211
		RETLW OFFSET_‘	;212
		RETLW OFFSET_medzera	;213
		RETLW OFFSET_medzera	;214
		RETLW OFFSET_medzera	;215
		RETLW OFFSET_ÿ	;216
		RETLW OFFSET_Ÿ	;217
		RETLW OFFSET_⁄	;218
		RETLW OFFSET_medzera	;219

		RETLW OFFSET_medzera	;220
        RETLW OFFSET_›	;221
        RETLW OFFSET_medzera	;222
        RETLW OFFSET_medzera	;223
        RETLW OFFSET_‡	;224
        RETLW OFFSET_·	;225
        RETLW OFFSET_medzera	;226
        RETLW OFFSET_medzera	;227
        RETLW OFFSET_‰	;228
        RETLW OFFSET_Â	;229

        RETLW OFFSET_medzera	;230
        RETLW OFFSET_medzera	;231
        RETLW OFFSET_Ë	;232
        RETLW OFFSET_È	;233
        RETLW OFFSET_medzera	;234
        RETLW OFFSET_medzera	;235
        RETLW OFFSET_Ï	;236
        RETLW OFFSET_Ì	;237
        RETLW OFFSET_medzera	;238
        RETLW OFFSET_Ô	;239

        RETLW OFFSET_medzera	;240
        RETLW OFFSET_medzera	;241
        RETLW OFFSET_Ú	;242
        RETLW OFFSET_Û	;243
        RETLW OFFSET_Ù	;244
        RETLW OFFSET_medzera	;245
        RETLW OFFSET_medzera	;246
        RETLW OFFSET_˜	;247
        RETLW OFFSET_¯	;248
        RETLW OFFSET_˘	;249

        RETLW OFFSET_˙	;250
        RETLW OFFSET_medzera	;251
        RETLW OFFSET_medzera	;252
        RETLW OFFSET_˝	;253
        RETLW OFFSET_medzera	;254
        ;RETLW 0x00	;255

		
;koniec tabulky	

;obsluha z ktorej tabulky a aky segment vybrat
Vyber_z_tabulky_segment ORG 0x04E1
		BTFSC tabulka, 0x00
		CALL Vyber_z_tabulky1
		BTFSC tabulka, 0x01
		CALL Vyber_z_tabulky2 
		BTFSC tabulka, 0x02
		CALL Vyber_z_tabulky3	
RETURN

Vyber_z_tabulky1 ORG 0x04F3
		ADDLW 0x01
		MOVWF adress_offset ;uloz W do adress_offset
		MOVLW LOW Tabulka1 ;W = low 8 bitov z adresy
		ADDWF adress_offset,F
		MOVLW HIGH Tabulka1 ;W = high 8 bitov z adresy
		BTFSC STATUS,C ;PAGE CROSSED?
		ADDLW 0x01 ;ak ano tak W = W + 1
		MOVWF PCLATH ;nahraj high adress to latch
		MOVF  adress_offset, W
		CALL  Tabulka1								

		RETURN

Tabulka1 ORG 0x0500;4FA
;vstupna adresa je vo W registre
		;ADDWF PCL,F
		MOVWF PCL
 ;znak medzera   offset = 0
        RETLW 0x00  ;0  0000 0000
        RETLW 0x00  ;1  0000 0000
        RETLW 0x00  ;2  0000 0000
        RETLW 0x00  ;3  0000 0000
        RETLW 0x00  ;4  0000 0000
 
 ;znak !   offset = 5
        RETLW 0x00  ;5  0000 0000
        RETLW 0xBE  ;6  1011 1110
        RETLW 0x00  ;7  0000 0000
        RETLW 0x00  ;8  0000 0000
        RETLW 0x00  ;9  0000 0000
 
 ;znak "   offset = 10
        RETLW 0x00  ;10  0000 0000
        RETLW 0x06  ;11  0000 0110
        RETLW 0x00  ;12  0000 0000
        RETLW 0x06  ;13  0000 0110
        RETLW 0x00  ;14  0000 0000
 
 ;znak #   offset = 15
        RETLW 0x28  ;15  0010 1000
        RETLW 0x7C  ;16  0111 1100
        RETLW 0x28  ;17  0010 1000
        RETLW 0x7C  ;18  0111 1100
        RETLW 0x28  ;19  0010 1000
 
 ;znak $   offset = 20
        RETLW 0x24  ;20  0010 0100
        RETLW 0x4A  ;21  0100 1010
        RETLW 0xFF  ;22  1111 1111
        RETLW 0x4A  ;23  0100 1010
        RETLW 0x30  ;24  0011 0000
 
 ;znak %   offset = 25
        RETLW 0x40  ;25  0100 0000
        RETLW 0x24  ;26  0010 0100
        RETLW 0x10  ;27  0001 0000
        RETLW 0x48  ;28  0100 1000
        RETLW 0x04  ;29  0000 0100
 
 ;znak &   offset = 30
        RETLW 0x40  ;30  0100 0000
        RETLW 0xA4  ;31  1010 0100
        RETLW 0x9A  ;32  1001 1010
        RETLW 0x64  ;33  0110 0100
        RETLW 0x90  ;34  1001 0000
 
 ;znak '   offset = 35
        RETLW 0x00  ;35  0000 0000
        RETLW 0x06  ;36  0000 0110
        RETLW 0x00  ;37  0000 0000
        RETLW 0x00  ;38  0000 0000
        RETLW 0x00  ;39  0000 0000
 
 ;znak (   offset = 40
        RETLW 0x00  ;40  0000 0000
        RETLW 0x3C  ;41  0011 1100
        RETLW 0x42  ;42  0100 0010
        RETLW 0x81  ;43  1000 0001
        RETLW 0x00  ;44  0000 0000
 
 ;znak )   offset = 45
        RETLW 0x00  ;45  0000 0000
        RETLW 0x81  ;46  1000 0001
        RETLW 0x42  ;47  0100 0010
        RETLW 0x3C  ;48  0011 1100
        RETLW 0x00  ;49  0000 0000
 
 ;znak *   offset = 50
        RETLW 0x00  ;50  0000 0000
        RETLW 0x28  ;51  0010 1000
        RETLW 0x10  ;52  0001 0000
        RETLW 0x28  ;53  0010 1000
        RETLW 0x00  ;54  0000 0000
 
 ;znak +   offset = 55
        RETLW 0x00  ;55  0000 0000
        RETLW 0x10  ;56  0001 0000
        RETLW 0x38  ;57  0011 1000
        RETLW 0x10  ;58  0001 0000
        RETLW 0x00  ;59  0000 0000
 
 ;znak ,   offset = 60
        RETLW 0x80  ;60  1000 0000
        RETLW 0x60  ;61  0110 0000
        RETLW 0x00  ;62  0000 0000
        RETLW 0x00  ;63  0000 0000
        RETLW 0x00  ;64  0000 0000
 
 ;znak -   offset = 65
        RETLW 0x00  ;65  0000 0000
        RETLW 0x10  ;66  0001 0000
        RETLW 0x10  ;67  0001 0000
        RETLW 0x10  ;68  0001 0000
        RETLW 0x00  ;69  0000 0000
 
 ;znak .   offset = 70
        RETLW 0x00  ;70  0000 0000
        RETLW 0x40  ;71  0100 0000
        RETLW 0x00  ;72  0000 0000
        RETLW 0x00  ;73  0000 0000
        RETLW 0x00  ;74  0000 0000
 
 ;znak /   offset = 75
        RETLW 0x40  ;75  0100 0000
        RETLW 0x20  ;76  0010 0000
        RETLW 0x10  ;77  0001 0000
        RETLW 0x08  ;78  0000 1000
        RETLW 0x04  ;79  0000 0100
 
 ;znak 0   offset = 80
        RETLW 0x7C  ;80  0111 1100
        RETLW 0xA2  ;81  1010 0010
        RETLW 0x92  ;82  1001 0010
        RETLW 0x8A  ;83  1000 1010
        RETLW 0x7C  ;84  0111 1100
 
 ;znak 1   offset = 85
        RETLW 0x00  ;85  0000 0000
        RETLW 0x84  ;86  1000 0100
        RETLW 0xFE  ;87  1111 1110
        RETLW 0x80  ;88  1000 0000
        RETLW 0x00  ;89  0000 0000
 
 ;znak 2   offset = 90
        RETLW 0x84  ;90  1000 0100
        RETLW 0xC2  ;91  1100 0010
        RETLW 0xA2  ;92  1010 0010
        RETLW 0x92  ;93  1001 0010
        RETLW 0x8C  ;94  1000 1100
 
 ;znak 3   offset = 95
        RETLW 0x42  ;95  0100 0010
        RETLW 0x82  ;96  1000 0010
        RETLW 0x8A  ;97  1000 1010
        RETLW 0x96  ;98  1001 0110
        RETLW 0x62  ;99  0110 0010
 
 ;znak 4   offset = 100
        RETLW 0x30  ;100  0011 0000
        RETLW 0x28  ;101  0010 1000
        RETLW 0x24  ;102  0010 0100
        RETLW 0xFE  ;103  1111 1110
        RETLW 0x20  ;104  0010 0000
 
 ;znak 5   offset = 105
        RETLW 0x4E  ;105  0100 1110
        RETLW 0x8A  ;106  1000 1010
        RETLW 0x8A  ;107  1000 1010
        RETLW 0x8A  ;108  1000 1010
        RETLW 0x72  ;109  0111 0010
 
 ;znak 6   offset = 110
        RETLW 0x78  ;110  0111 1000
        RETLW 0x94  ;111  1001 0100
        RETLW 0x92  ;112  1001 0010
        RETLW 0x92  ;113  1001 0010
        RETLW 0x60  ;114  0110 0000
 
 ;znak 7   offset = 115
        RETLW 0x02  ;115  0000 0010
        RETLW 0xE2  ;116  1110 0010
        RETLW 0x12  ;117  0001 0010
        RETLW 0x0A  ;118  0000 1010
        RETLW 0x06  ;119  0000 0110
 
 ;znak 8   offset = 120
        RETLW 0x6C  ;120  0110 1100
        RETLW 0x92  ;121  1001 0010
        RETLW 0x92  ;122  1001 0010
        RETLW 0x92  ;123  1001 0010
        RETLW 0x6C  ;124  0110 1100
 
 ;znak 9   offset = 125
        RETLW 0x0C  ;125  0000 1100
        RETLW 0x92  ;126  1001 0010
        RETLW 0x92  ;127  1001 0010
        RETLW 0x52  ;128  0101 0010
        RETLW 0x3C  ;129  0011 1100
 
 ;znak :   offset = 130
        RETLW 0x00  ;130  0000 0000
        RETLW 0x24  ;131  0010 0100
        RETLW 0x00  ;132  0000 0000
        RETLW 0x00  ;133  0000 0000
        RETLW 0x00  ;134  0000 0000
 
 ;znak ;   offset = 135
        RETLW 0x80  ;135  1000 0000
        RETLW 0x64  ;136  0110 0100
        RETLW 0x00  ;137  0000 0000
        RETLW 0x00  ;138  0000 0000
        RETLW 0x00  ;139  0000 0000
 
 ;znak <   offset = 140
        RETLW 0x10  ;140  0001 0000
        RETLW 0x28  ;141  0010 1000
        RETLW 0x44  ;142  0100 0100
        RETLW 0x82  ;143  1000 0010
        RETLW 0x00  ;144  0000 0000
 
 ;znak =   offset = 145
        RETLW 0x00  ;145  0000 0000
        RETLW 0x28  ;146  0010 1000
        RETLW 0x28  ;147  0010 1000
        RETLW 0x28  ;148  0010 1000
        RETLW 0x00  ;149  0000 0000
 
 ;znak >   offset = 150
        RETLW 0x00  ;150  0000 0000
        RETLW 0x82  ;151  1000 0010
        RETLW 0x44  ;152  0100 0100
        RETLW 0x28  ;153  0010 1000
        RETLW 0x10  ;154  0001 0000
 
 ;znak ?   offset = 155
        RETLW 0x04  ;155  0000 0100
        RETLW 0xA2  ;156  1010 0010
        RETLW 0x12  ;157  0001 0010
        RETLW 0x0C  ;158  0000 1100
        RETLW 0x00  ;159  0000 0000
 
 ;znak @   offset = 160
        RETLW 0x64  ;160  0110 0100
        RETLW 0x92  ;161  1001 0010
        RETLW 0xF2  ;162  1111 0010
        RETLW 0x82  ;163  1000 0010
        RETLW 0x7C  ;164  0111 1100
 
 ;znak A   offset = 165
        RETLW 0xFC  ;165  1111 1100
        RETLW 0x22  ;166  0010 0010
        RETLW 0x22  ;167  0010 0010
        RETLW 0x22  ;168  0010 0010
        RETLW 0xFC  ;169  1111 1100
 
 ;znak B   offset = 170
        RETLW 0xFE  ;170  1111 1110
        RETLW 0x92  ;171  1001 0010
        RETLW 0x92  ;172  1001 0010
        RETLW 0x92  ;173  1001 0010
        RETLW 0x6C  ;174  0110 1100
 
 ;znak C   offset = 175
        RETLW 0x7C  ;175  0111 1100
        RETLW 0x82  ;176  1000 0010
        RETLW 0x82  ;177  1000 0010
        RETLW 0x82  ;178  1000 0010
        RETLW 0x44  ;179  0100 0100
 
 ;znak D   offset = 180
        RETLW 0xFE  ;180  1111 1110
        RETLW 0x82  ;181  1000 0010
        RETLW 0x82  ;182  1000 0010
        RETLW 0x44  ;183  0100 0100
        RETLW 0x38  ;184  0011 1000
 
 ;znak E   offset = 185
        RETLW 0xFE  ;185  1111 1110
        RETLW 0x92  ;186  1001 0010
        RETLW 0x92  ;187  1001 0010
        RETLW 0x92  ;188  1001 0010
        RETLW 0x82  ;189  1000 0010
 
 ;znak F   offset = 190
        RETLW 0xFE  ;190  1111 1110
        RETLW 0x12  ;191  0001 0010
        RETLW 0x12  ;192  0001 0010
        RETLW 0x12  ;193  0001 0010
        RETLW 0x02  ;194  0000 0010
 
 ;znak G   offset = 195
        RETLW 0x7C  ;195  0111 1100
        RETLW 0x82  ;196  1000 0010
        RETLW 0x92  ;197  1001 0010
        RETLW 0x92  ;198  1001 0010
        RETLW 0xF4  ;199  1111 0100
 
 ;znak H   offset = 200
        RETLW 0xFE  ;200  1111 1110
        RETLW 0x10  ;201  0001 0000
        RETLW 0x10  ;202  0001 0000
        RETLW 0x10  ;203  0001 0000
        RETLW 0xFE  ;204  1111 1110
 
 ;znak I   offset = 205
        RETLW 0x00  ;205  0000 0000
        RETLW 0x82  ;206  1000 0010
        RETLW 0xFE  ;207  1111 1110
        RETLW 0x82  ;208  1000 0010
        RETLW 0x00  ;209  0000 0000
 
 ;znak J   offset = 210
        RETLW 0x40  ;210  0100 0000
        RETLW 0x80  ;211  1000 0000
        RETLW 0x82  ;212  1000 0010
        RETLW 0x7E  ;213  0111 1110
        RETLW 0x02  ;214  0000 0010
 
 ;znak K   offset = 215
        RETLW 0xFE  ;215  1111 1110
        RETLW 0x10  ;216  0001 0000
        RETLW 0x28  ;217  0010 1000
        RETLW 0x44  ;218  0100 0100
        RETLW 0x82  ;219  1000 0010
 
 ;znak L   offset = 220
        RETLW 0xFE  ;220  1111 1110
        RETLW 0x80  ;221  1000 0000
        RETLW 0x80  ;222  1000 0000
        RETLW 0x80  ;223  1000 0000
        RETLW 0x80  ;224  1000 0000
 
 ;znak M   offset = 225
        RETLW 0xFE  ;225  1111 1110
        RETLW 0x04  ;226  0000 0100
        RETLW 0x18  ;227  0001 1000
        RETLW 0x04  ;228  0000 0100
        RETLW 0xFE  ;229  1111 1110
 
 ;znak N   offset = 230
        RETLW 0xFE  ;230  1111 1110
        RETLW 0x08  ;231  0000 1000
        RETLW 0x10  ;232  0001 0000
        RETLW 0x20  ;233  0010 0000
        RETLW 0xFE  ;234  1111 1110
 
 ;znak O   offset = 235
        RETLW 0x7C  ;235  0111 1100
        RETLW 0x82  ;236  1000 0010
        RETLW 0x82  ;237  1000 0010
        RETLW 0x82  ;238  1000 0010
        RETLW 0x7C  ;239  0111 1100
 
 ;znak P   offset = 240
        RETLW 0xFE  ;240  1111 1110
        RETLW 0x12  ;241  0001 0010
        RETLW 0x12  ;242  0001 0010
        RETLW 0x12  ;243  0001 0010
        RETLW 0x0C  ;244  0000 1100
 
 ;znak Q   offset = 245
        RETLW 0x7C  ;245  0111 1100
        RETLW 0x82  ;246  1000 0010
        RETLW 0xA2  ;247  1010 0010
        RETLW 0x42  ;248  0100 0010
        RETLW 0xBC  ;249  1011 1100
 
 ;znak R   offset = 250
        RETLW 0xFE  ;250  1111 1110
        RETLW 0x12  ;251  0001 0010
        RETLW 0x32  ;252  0011 0010
        RETLW 0x52  ;253  0101 0010
        RETLW 0x8C  ;254  1000 1100
 

Vyber_z_tabulky2 ORG 0x04E8;0x03BD
		ADDLW 0x01
		MOVWF adress_offset ;uloz W do adress_offset
		MOVLW LOW Tabulka2 ;W = low 8 bitov z adresy
		ADDWF adress_offset,F
		MOVLW HIGH Tabulka2 ;W = high 8 bitov z adresy
		BTFSC STATUS,C ;PAGE CROSSED?
		ADDLW 0x01 ;ak ano tak W = W + 1
		MOVWF PCLATH ;nahraj high adress to latch
		MOVF  adress_offset, W
		CALL  Tabulka2								

		RETURN

Tabulka2 ORG 0x0600
;vstupna adresa je vo W registre
		;ADDWF PCL,F
		MOVWF PCL
 ;znak S   offset = 0
        RETLW 0x8C  ;0  1000 1100
        RETLW 0x92  ;1  1001 0010
        RETLW 0x92  ;2  1001 0010
        RETLW 0x92  ;3  1001 0010
        RETLW 0x62  ;4  0110 0010
 
 ;znak T   offset = 5
        RETLW 0x02  ;5  0000 0010
        RETLW 0x02  ;6  0000 0010
        RETLW 0xFE  ;7  1111 1110
        RETLW 0x02  ;8  0000 0010
        RETLW 0x02  ;9  0000 0010
 
 ;znak U   offset = 10
        RETLW 0x7E  ;10  0111 1110
        RETLW 0x80  ;11  1000 0000
        RETLW 0x80  ;12  1000 0000
        RETLW 0x80  ;13  1000 0000
        RETLW 0x7E  ;14  0111 1110
 
 ;znak V   offset = 15
        RETLW 0x3E  ;15  0011 1110
        RETLW 0x40  ;16  0100 0000
        RETLW 0x80  ;17  1000 0000
        RETLW 0x40  ;18  0100 0000
        RETLW 0x3E  ;19  0011 1110
 
 ;znak W   offset = 20
        RETLW 0x7E  ;20  0111 1110
        RETLW 0x80  ;21  1000 0000
        RETLW 0x70  ;22  0111 0000
        RETLW 0x80  ;23  1000 0000
        RETLW 0x7E  ;24  0111 1110
 
 ;znak X   offset = 25
        RETLW 0xC6  ;25  1100 0110
        RETLW 0x28  ;26  0010 1000
        RETLW 0x10  ;27  0001 0000
        RETLW 0x28  ;28  0010 1000
        RETLW 0xC6  ;29  1100 0110
 
 ;znak Y   offset = 30
        RETLW 0x0E  ;30  0000 1110
        RETLW 0x10  ;31  0001 0000
        RETLW 0xE0  ;32  1110 0000
        RETLW 0x10  ;33  0001 0000
        RETLW 0x0E  ;34  0000 1110
 
 ;znak Z   offset = 35
        RETLW 0xC2  ;35  1100 0010
        RETLW 0xA2  ;36  1010 0010
        RETLW 0x92  ;37  1001 0010
        RETLW 0x8A  ;38  1000 1010
        RETLW 0x86  ;39  1000 0110
 
 ;znak [   offset = 40
        RETLW 0x00  ;40  0000 0000
        RETLW 0xFE  ;41  1111 1110
        RETLW 0x82  ;42  1000 0010
        RETLW 0x82  ;43  1000 0010
        RETLW 0x00  ;44  0000 0000
 
 ;znak \   offset = 45
        RETLW 0x04  ;45  0000 0100
        RETLW 0x08  ;46  0000 1000
        RETLW 0x10  ;47  0001 0000
        RETLW 0x20  ;48  0010 0000
        RETLW 0x40  ;49  0100 0000
 
 ;znak ]   offset = 50
        RETLW 0x00  ;50  0000 0000
        RETLW 0x82  ;51  1000 0010
        RETLW 0x82  ;52  1000 0010
        RETLW 0xFE  ;53  1111 1110
        RETLW 0x00  ;54  0000 0000
 
 ;znak ^   offset = 55
        RETLW 0x08  ;55  0000 1000
        RETLW 0x04  ;56  0000 0100
        RETLW 0x02  ;57  0000 0010
        RETLW 0x04  ;58  0000 0100
        RETLW 0x08  ;59  0000 1000
 
 ;znak _   offset = 60
        RETLW 0x80  ;60  1000 0000
        RETLW 0x80  ;61  1000 0000
        RETLW 0x80  ;62  1000 0000
        RETLW 0x80  ;63  1000 0000
        RETLW 0x80  ;64  1000 0000
 
 ;znak `   offset = 65
        RETLW 0x00  ;65  0000 0000
        RETLW 0x02  ;66  0000 0010
        RETLW 0x04  ;67  0000 0100
        RETLW 0x08  ;68  0000 1000
        RETLW 0x00  ;69  0000 0000
 
 ;znak a   offset = 70
        RETLW 0x40  ;70  0100 0000
        RETLW 0xA8  ;71  1010 1000
        RETLW 0xA8  ;72  1010 1000
        RETLW 0xA8  ;73  1010 1000
        RETLW 0xF0  ;74  1111 0000
 
 ;znak b   offset = 75
        RETLW 0xFE  ;75  1111 1110
        RETLW 0x90  ;76  1001 0000
        RETLW 0x88  ;77  1000 1000
        RETLW 0x88  ;78  1000 1000
        RETLW 0x70  ;79  0111 0000
 
 ;znak c   offset = 80
        RETLW 0x70  ;80  0111 0000
        RETLW 0x88  ;81  1000 1000
        RETLW 0x88  ;82  1000 1000
        RETLW 0x88  ;83  1000 1000
        RETLW 0x40  ;84  0100 0000
 
 ;znak d   offset = 85
        RETLW 0x70  ;85  0111 0000
        RETLW 0x88  ;86  1000 1000
        RETLW 0x88  ;87  1000 1000
        RETLW 0x90  ;88  1001 0000
        RETLW 0xFE  ;89  1111 1110
 
 ;znak e   offset = 90
        RETLW 0x70  ;90  0111 0000
        RETLW 0xA8  ;91  1010 1000
        RETLW 0xA8  ;92  1010 1000
        RETLW 0xA8  ;93  1010 1000
        RETLW 0x30  ;94  0011 0000
 
 ;znak f   offset = 95
        RETLW 0x10  ;95  0001 0000
        RETLW 0xFC  ;96  1111 1100
        RETLW 0x12  ;97  0001 0010
        RETLW 0x02  ;98  0000 0010
        RETLW 0x04  ;99  0000 0100
 
 ;znak g   offset = 100
        RETLW 0x18  ;100  0001 1000
        RETLW 0xA4  ;101  1010 0100
        RETLW 0xA4  ;102  1010 0100
        RETLW 0xA4  ;103  1010 0100
        RETLW 0x7C  ;104  0111 1100
 
 ;znak h   offset = 105
        RETLW 0xFE  ;105  1111 1110
        RETLW 0x10  ;106  0001 0000
        RETLW 0x08  ;107  0000 1000
        RETLW 0x08  ;108  0000 1000
        RETLW 0xF0  ;109  1111 0000
 
 ;znak i   offset = 110
        RETLW 0x00  ;110  0000 0000
        RETLW 0x88  ;111  1000 1000
        RETLW 0xFA  ;112  1111 1010
        RETLW 0x80  ;113  1000 0000
        RETLW 0x00  ;114  0000 0000
 
 ;znak j   offset = 115
        RETLW 0x40  ;115  0100 0000
        RETLW 0x80  ;116  1000 0000
        RETLW 0x88  ;117  1000 1000
        RETLW 0x7A  ;118  0111 1010
        RETLW 0x00  ;119  0000 0000
 
 ;znak k   offset = 120
        RETLW 0xFE  ;120  1111 1110
        RETLW 0x20  ;121  0010 0000
        RETLW 0x50  ;122  0101 0000
        RETLW 0x88  ;123  1000 1000
        RETLW 0x00  ;124  0000 0000
 
 ;znak l   offset = 125
        RETLW 0x00  ;125  0000 0000
        RETLW 0x82  ;126  1000 0010
        RETLW 0xFE  ;127  1111 1110
        RETLW 0x80  ;128  1000 0000
        RETLW 0x00  ;129  0000 0000
 
 ;znak m   offset = 130
        RETLW 0xF8  ;130  1111 1000
        RETLW 0x08  ;131  0000 1000
        RETLW 0x30  ;132  0011 0000
        RETLW 0x08  ;133  0000 1000
        RETLW 0xF0  ;134  1111 0000
 
 ;znak n   offset = 135
        RETLW 0xF8  ;135  1111 1000
        RETLW 0x10  ;136  0001 0000
        RETLW 0x08  ;137  0000 1000
        RETLW 0x08  ;138  0000 1000
        RETLW 0xF0  ;139  1111 0000
 
 ;znak o   offset = 140
        RETLW 0x70  ;140  0111 0000
        RETLW 0x88  ;141  1000 1000
        RETLW 0x88  ;142  1000 1000
        RETLW 0x88  ;143  1000 1000
        RETLW 0x70  ;144  0111 0000
 
 ;znak p   offset = 145
        RETLW 0xF8  ;145  1111 1000
        RETLW 0x28  ;146  0010 1000
        RETLW 0x28  ;147  0010 1000
        RETLW 0x28  ;148  0010 1000
        RETLW 0x10  ;149  0001 0000
 
 ;znak q   offset = 150
        RETLW 0x10  ;150  0001 0000
        RETLW 0x28  ;151  0010 1000
        RETLW 0x28  ;152  0010 1000
        RETLW 0x30  ;153  0011 0000
        RETLW 0xF8  ;154  1111 1000
 
 ;znak r   offset = 155
        RETLW 0xF8  ;155  1111 1000
        RETLW 0x10  ;156  0001 0000
        RETLW 0x08  ;157  0000 1000
        RETLW 0x08  ;158  0000 1000
        RETLW 0x10  ;159  0001 0000
 
 ;znak s   offset = 160
        RETLW 0x90  ;160  1001 0000
        RETLW 0xA8  ;161  1010 1000
        RETLW 0xA8  ;162  1010 1000
        RETLW 0xA8  ;163  1010 1000
        RETLW 0x40  ;164  0100 0000
 
 ;znak t   offset = 165
        RETLW 0x08  ;165  0000 1000
        RETLW 0x7E  ;166  0111 1110
        RETLW 0x88  ;167  1000 1000
        RETLW 0x80  ;168  1000 0000
        RETLW 0x40  ;169  0100 0000
 
 ;znak u   offset = 170
        RETLW 0x78  ;170  0111 1000
        RETLW 0x80  ;171  1000 0000
        RETLW 0x80  ;172  1000 0000
        RETLW 0x40  ;173  0100 0000
        RETLW 0xF8  ;174  1111 1000
 
 ;znak v   offset = 175
        RETLW 0x38  ;175  0011 1000
        RETLW 0x40  ;176  0100 0000
        RETLW 0x80  ;177  1000 0000
        RETLW 0x40  ;178  0100 0000
        RETLW 0x38  ;179  0011 1000
 
 ;znak w   offset = 180
        RETLW 0x78  ;180  0111 1000
        RETLW 0x80  ;181  1000 0000
        RETLW 0x60  ;182  0110 0000
        RETLW 0x80  ;183  1000 0000
        RETLW 0x78  ;184  0111 1000
 
 ;znak x   offset = 185
        RETLW 0x88  ;185  1000 1000
        RETLW 0x50  ;186  0101 0000
        RETLW 0x20  ;187  0010 0000
        RETLW 0x50  ;188  0101 0000
        RETLW 0x88  ;189  1000 1000
 
 ;znak y   offset = 190
        RETLW 0x18  ;190  0001 1000
        RETLW 0xA0  ;191  1010 0000
        RETLW 0xA0  ;192  1010 0000
        RETLW 0xA0  ;193  1010 0000
        RETLW 0x78  ;194  0111 1000
 
 ;znak z   offset = 195
        RETLW 0x88  ;195  1000 1000
        RETLW 0xC8  ;196  1100 1000
        RETLW 0xA8  ;197  1010 1000
        RETLW 0x98  ;198  1001 1000
        RETLW 0x88  ;199  1000 1000
 
 ;znak {   offset = 200
        RETLW 0x00  ;200  0000 0000
        RETLW 0x10  ;201  0001 0000
        RETLW 0x6C  ;202  0110 1100
        RETLW 0x82  ;203  1000 0010
        RETLW 0x00  ;204  0000 0000
 
 ;znak |   offset = 205
        RETLW 0x00  ;205  0000 0000
        RETLW 0x00  ;206  0000 0000
        RETLW 0xFE  ;207  1111 1110
        RETLW 0x00  ;208  0000 0000
        RETLW 0x00  ;209  0000 0000
 
 ;znak }   offset = 210
        RETLW 0x00  ;210  0000 0000
        RETLW 0x82  ;211  1000 0010
        RETLW 0x6C  ;212  0110 1100
        RETLW 0x10  ;213  0001 0000
        RETLW 0x00  ;214  0000 0000
 
 ;znak ,   offset = 215
        RETLW 0x80  ;215  1000 0000
        RETLW 0x60  ;216  0110 0000
        RETLW 0x00  ;217  0000 0000
        RETLW 0x00  ;218  0000 0000
        RETLW 0x00  ;219  0000 0000
 
 ;znak .   offset = 220
        RETLW 0x00  ;220  0000 0000
        RETLW 0x80  ;221  1000 0000
        RETLW 0x00  ;222  0000 0000
        RETLW 0x00  ;223  0000 0000
        RETLW 0x00  ;224  0000 0000
 
 ;znak Ñ   offset = 225
        RETLW 0x80  ;225  1000 0000
        RETLW 0x60  ;226  0110 0000
        RETLW 0x00  ;227  0000 0000
        RETLW 0x80  ;228  1000 0000
        RETLW 0x60  ;229  0110 0000
 
 ;znak ä   offset = 230
        RETLW 0x48  ;230  0100 1000
        RETLW 0x95  ;231  1001 0101
        RETLW 0x96  ;232  1001 0110
        RETLW 0x95  ;233  1001 0101
        RETLW 0x60  ;234  0110 0000
 
 ;znak ç   offset = 235
        RETLW 0x04  ;235  0000 0100
        RETLW 0x05  ;236  0000 0101
        RETLW 0xFE  ;237  1111 1110
        RETLW 0x05  ;238  0000 0101
        RETLW 0x04  ;239  0000 0100
 
 ;znak é   offset = 240
        RETLW 0x88  ;240  1000 1000
        RETLW 0xC9  ;241  1100 1001
        RETLW 0xAA  ;242  1010 1010
        RETLW 0x99  ;243  1001 1001
        RETLW 0x88  ;244  1000 1000
 
 ;znak ö   offset = 245
        RETLW 0x10  ;245  0001 0000
        RETLW 0xAA  ;246  1010 1010
        RETLW 0xAC  ;247  1010 1100
        RETLW 0xAA  ;248  1010 1010
        RETLW 0x40  ;249  0100 0000
 
 ;znak ù   offset = 250
        RETLW 0x08  ;250  0000 1000
        RETLW 0x7E  ;251  0111 1110
        RETLW 0x89  ;252  1000 1001
        RETLW 0x82  ;253  1000 0010
        RETLW 0x41  ;254  0100 0001
 

Vyber_z_tabulky3 ORG 0x03F6
		ADDLW 0x01
		MOVWF adress_offset ;uloz W do adress_offset
		MOVLW LOW Tabulka3 ;W = low 8 bitov z adresy
		ADDWF adress_offset,F
		MOVLW HIGH Tabulka3 ;W = high 8 bitov z adresy
		BTFSC STATUS,C ;PAGE CROSSED?
		ADDLW 0x01 ;ak ano tak W = W + 1
		MOVWF PCLATH ;nahraj high adress to latch
		MOVF  adress_offset, W
		CALL  Tabulka3								

		RETURN

Tabulka3 ORG 0x0700
;vstupna adresa je vo W registre
		;ADDWF PCL,F
		MOVWF PCL
 ;znak û   offset = 0
        RETLW 0x90  ;0  1001 0000
        RETLW 0xD2  ;1  1101 0010
        RETLW 0xB4  ;2  1011 0100
        RETLW 0x92  ;3  1001 0010
        RETLW 0x80  ;4  1000 0000
 
 ;znak °   offset = 5
        RETLW 0x00  ;5  0000 0000
        RETLW 0x02  ;6  0000 0010
        RETLW 0x04  ;7  0000 0100
        RETLW 0x02  ;8  0000 0010
        RETLW 0x00  ;9  0000 0000
 
 ;znak ß   offset = 10
        RETLW 0x4C  ;10  0100 1100
        RETLW 0x96  ;11  1001 0110
        RETLW 0xAA  ;12  1010 1010
        RETLW 0xD2  ;13  1101 0010
        RETLW 0x64  ;14  0110 0100
 
 ;znak ∞   offset = 15
        RETLW 0x00  ;15  0000 0000
        RETLW 0x04  ;16  0000 0100
        RETLW 0x0A  ;17  0000 1010
        RETLW 0x04  ;18  0000 0100
        RETLW 0x00  ;19  0000 0000
 
 ;znak º   offset = 20
        RETLW 0xFE  ;20  1111 1110
        RETLW 0x80  ;21  1000 0000
        RETLW 0x82  ;22  1000 0010
        RETLW 0x84  ;23  1000 0100
        RETLW 0x82  ;24  1000 0010
 
 ;znak æ   offset = 25
        RETLW 0x84  ;25  1000 0100
        RETLW 0xFC  ;26  1111 1100
        RETLW 0x82  ;27  1000 0010
        RETLW 0x04  ;28  0000 0100
        RETLW 0x02  ;29  0000 0010
 
 ;znak ¿   offset = 30
        RETLW 0xFC  ;30  1111 1100
        RETLW 0x14  ;31  0001 0100
        RETLW 0x34  ;32  0011 0100
        RETLW 0x56  ;33  0101 0110
        RETLW 0x89  ;34  1000 1001
 
 ;znak ¡   offset = 35
        RETLW 0xF0  ;35  1111 0000
        RETLW 0x28  ;36  0010 1000
        RETLW 0x28  ;37  0010 1000
        RETLW 0x2A  ;38  0010 1010
        RETLW 0xF1  ;39  1111 0001
 
 ;znak ƒ   offset = 40
        RETLW 0xF0  ;40  1111 0000
        RETLW 0x29  ;41  0010 1001
        RETLW 0x24  ;42  0010 0100
        RETLW 0x29  ;43  0010 1001
        RETLW 0xF0  ;44  1111 0000
 
 ;znak ≈   offset = 45
        RETLW 0xFE  ;45  1111 1110
        RETLW 0x80  ;46  1000 0000
        RETLW 0x82  ;47  1000 0010
        RETLW 0x81  ;48  1000 0001
        RETLW 0x80  ;49  1000 0000
 
 ;znak »   offset = 50
        RETLW 0x78  ;50  0111 1000
        RETLW 0x85  ;51  1000 0101
        RETLW 0x86  ;52  1000 0110
        RETLW 0x85  ;53  1000 0101
        RETLW 0x48  ;54  0100 1000
 
 ;znak …   offset = 55
        RETLW 0xF8  ;55  1111 1000
        RETLW 0xA8  ;56  1010 1000
        RETLW 0xAA  ;57  1010 1010
        RETLW 0x89  ;58  1000 1001
        RETLW 0x88  ;59  1000 1000
 
 ;znak Ã   offset = 60
        RETLW 0xF8  ;60  1111 1000
        RETLW 0xA9  ;61  1010 1001
        RETLW 0xAA  ;62  1010 1010
        RETLW 0x89  ;63  1000 1001
        RETLW 0x88  ;64  1000 1000
 
 ;znak Õ   offset = 65
        RETLW 0x00  ;65  0000 0000
        RETLW 0x88  ;66  1000 1000
        RETLW 0xF8  ;67  1111 1000
        RETLW 0x8A  ;68  1000 1010
        RETLW 0x01  ;69  0000 0001
 
 ;znak œ   offset = 70
        RETLW 0xFD  ;70  1111 1101
        RETLW 0x86  ;71  1000 0110
        RETLW 0x85  ;72  1000 0101
        RETLW 0x48  ;73  0100 1000
        RETLW 0x30  ;74  0011 0000
 
 ;znak “   offset = 75
        RETLW 0xFD  ;75  1111 1101
        RETLW 0x0A  ;76  0000 1010
        RETLW 0x11  ;77  0001 0001
        RETLW 0x20  ;78  0010 0000
        RETLW 0xFC  ;79  1111 1100
 
 ;znak ”   offset = 80
        RETLW 0x78  ;80  0111 1000
        RETLW 0x84  ;81  1000 0100
        RETLW 0x86  ;82  1000 0110
        RETLW 0x85  ;83  1000 0101
        RETLW 0x78  ;84  0111 1000
 
 ;znak ‘   offset = 85
        RETLW 0x78  ;85  0111 1000
        RETLW 0x86  ;86  1000 0110
        RETLW 0x85  ;87  1000 0101
        RETLW 0x86  ;88  1000 0110
        RETLW 0x78  ;89  0111 1000
 
 ;znak ÿ   offset = 90
        RETLW 0xFC  ;90  1111 1100
        RETLW 0x15  ;91  0001 0101
        RETLW 0x36  ;92  0011 0110
        RETLW 0x55  ;93  0101 0101
        RETLW 0x88  ;94  1000 1000
 
 ;znak Ÿ   offset = 95
        RETLW 0x7C  ;95  0111 1100
        RETLW 0x82  ;96  1000 0010
        RETLW 0x85  ;97  1000 0101
        RETLW 0x82  ;98  1000 0010
        RETLW 0x7C  ;99  0111 1100
 
 ;znak ⁄   offset = 100
        RETLW 0x7C  ;100  0111 1100
        RETLW 0x80  ;101  1000 0000
        RETLW 0x82  ;102  1000 0010
        RETLW 0x81  ;103  1000 0001
        RETLW 0x7C  ;104  0111 1100
 
 ;znak ›   offset = 105
        RETLW 0x0C  ;105  0000 1100
        RETLW 0x10  ;106  0001 0000
        RETLW 0xE2  ;107  1110 0010
        RETLW 0x11  ;108  0001 0001
        RETLW 0x0C  ;109  0000 1100
 
 ;znak ‡   offset = 110
        RETLW 0xF8  ;110  1111 1000
        RETLW 0x10  ;111  0001 0000
        RETLW 0x0A  ;112  0000 1010
        RETLW 0x09  ;113  0000 1001
        RETLW 0x10  ;114  0001 0000
 
 ;znak ·   offset = 115
        RETLW 0x40  ;115  0100 0000
        RETLW 0xA8  ;116  1010 1000
        RETLW 0xAA  ;117  1010 1010
        RETLW 0xA9  ;118  1010 1001
        RETLW 0xF0  ;119  1111 0000
 
 ;znak ‰   offset = 120
        RETLW 0x40  ;120  0100 0000
        RETLW 0xAA  ;121  1010 1010
        RETLW 0xA8  ;122  1010 1000
        RETLW 0xAA  ;123  1010 1010
        RETLW 0xF0  ;124  1111 0000
 
 ;znak Â   offset = 125
        RETLW 0x00  ;125  0000 0000
        RETLW 0x88  ;126  1000 1000
        RETLW 0xFA  ;127  1111 1010
        RETLW 0x81  ;128  1000 0001
        RETLW 0x00  ;129  0000 0000
 
 ;znak Ë   offset = 130
        RETLW 0x70  ;130  0111 0000
        RETLW 0x89  ;131  1000 1001
        RETLW 0x8A  ;132  1000 1010
        RETLW 0x89  ;133  1000 1001
        RETLW 0x40  ;134  0100 0000
 
 ;znak È   offset = 135
        RETLW 0x70  ;135  0111 0000
        RETLW 0xA8  ;136  1010 1000
        RETLW 0xAA  ;137  1010 1010
        RETLW 0xA9  ;138  1010 1001
        RETLW 0x30  ;139  0011 0000
 
 ;znak Ï   offset = 140
        RETLW 0x70  ;140  0111 0000
        RETLW 0xA9  ;141  1010 1001
        RETLW 0xAA  ;142  1010 1010
        RETLW 0xA9  ;143  1010 1001
        RETLW 0x30  ;144  0011 0000
 
 ;znak Ì   offset = 145
        RETLW 0x00  ;145  0000 0000
        RETLW 0x90  ;146  1001 0000
        RETLW 0xF4  ;147  1111 0100
        RETLW 0x82  ;148  1000 0010
        RETLW 0x00  ;149  0000 0000
 
 ;znak Ô   offset = 150
        RETLW 0x70  ;150  0111 0000
        RETLW 0x89  ;151  1000 1001
        RETLW 0x8A  ;152  1000 1010
        RETLW 0x91  ;153  1001 0001
        RETLW 0xFE  ;154  1111 1110
 
 ;znak Ú   offset = 155
        RETLW 0xF8  ;155  1111 1000
        RETLW 0x11  ;156  0001 0001
        RETLW 0x0A  ;157  0000 1010
        RETLW 0x09  ;158  0000 1001
        RETLW 0xF0  ;159  1111 0000
 
 ;znak Û   offset = 160
        RETLW 0x70  ;160  0111 0000
        RETLW 0x88  ;161  1000 1000
        RETLW 0x8A  ;162  1000 1010
        RETLW 0x89  ;163  1000 1001
        RETLW 0x70  ;164  0111 0000
 
 ;znak Ù   offset = 165
        RETLW 0x70  ;165  0111 0000
        RETLW 0x8A  ;166  1000 1010
        RETLW 0x89  ;167  1000 1001
        RETLW 0x8A  ;168  1000 1010
        RETLW 0x70  ;169  0111 0000
 
 ;znak ˜   offset = 170
        RETLW 0x10  ;170  0001 0000
        RETLW 0x10  ;171  0001 0000
        RETLW 0x54  ;172  0101 0100
        RETLW 0x10  ;173  0001 0000
        RETLW 0x10  ;174  0001 0000
 
 ;znak ¯   offset = 175
        RETLW 0xF8  ;175  1111 1000
        RETLW 0x11  ;176  0001 0001
        RETLW 0x0A  ;177  0000 1010
        RETLW 0x09  ;178  0000 1001
        RETLW 0x10  ;179  0001 0000
 
 ;znak ˘   offset = 180
        RETLW 0x78  ;180  0111 1000
        RETLW 0x82  ;181  1000 0010
        RETLW 0x85  ;182  1000 0101
        RETLW 0x42  ;183  0100 0010
        RETLW 0xF8  ;184  1111 1000
 
 ;znak ˙   offset = 185
        RETLW 0x78  ;185  0111 1000
        RETLW 0x80  ;186  1000 0000
        RETLW 0x82  ;187  1000 0010
        RETLW 0x41  ;188  0100 0001
        RETLW 0xF8  ;189  1111 1000
 
 ;znak ˝   offset = 190
        RETLW 0x18  ;190  0001 1000
        RETLW 0xA0  ;191  1010 0000
        RETLW 0xA2  ;192  1010 0010
        RETLW 0xA1  ;193  1010 0001
        RETLW 0x78  ;194  0111 1000
 

;znak koniec offset = 195 ;stary 175
		RETLW 0x00	;195 0000 0000





; initialize eeprom locations

EE        CODE    0x2100
        DE    0x32, 0x0A, 
		DE	  'A','h','o','j',0x0D, 
		DE	  'S','V','E','T',0x0D, 
		DE	  ':',')',0xFF,0xFF
		DE	  0xFF, 0xFF

        END                       ; directive 'end of program'

