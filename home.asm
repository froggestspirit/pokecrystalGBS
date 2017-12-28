NUM_SONGS			EQU 102
Options				EQU 0

INCLUDE "includes.asm"


SECTION "NULL", ROM0
NULL::

SECTION "Header", ROM0[$100]

Start::
	nop
	jp _StartGB

SECTION "GBOnly", ROM0[$150]

_StartGB:
	di
	ld e, a
	ld d, 00
	inc de
	ld hl, $C100
	ld bc, $1F00
	ld sp, $C0FE
	call ByteFill
	ld hl, $FF80
	ld bc, $0080
	call ByteFill
	call _PlayMusic
.startLoop
	ld hl, $FF44
	xor a
.delay
	cp [hl]
	jr nz, .delay
	call _UpdateSound
	;code can be added here to read input, and change song. e would be song number, then just jump to _StartGB
	jr .startLoop

SECTION "Home", ROM0[$2FEA] ;this spot just fits the data following in home bank. This is also in the MAKEFILE in the dd command
	db $47,$42,$53,01 ;version 1
	db NUM_SONGS
	db 1 ;starting song
	dw _Start ;load
	dw _Start ;init
	dw _UpdateSound ;play
	dw $C0FE ;stack pointer
	dw $0000 ;for timing
INCBIN "gbsinfo.bin", $0, $60 - $0

INCLUDE "home/init.asm"
INCLUDE "home/audio.asm"
INCLUDE "audio/engine.asm"
INCLUDE "audio/music/nothing.asm"
INCLUDE "audio/music_pointers.asm"
INCLUDE "audio.asm"
