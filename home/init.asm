_Start:: ; 16e
	ld e, a
	ld d, 00
	inc de
	ld hl, $C100
	ld bc, $1F00
	;ld sp, $C0FE
	call ByteFill
	;ld hl, $FF80
	;ld bc, $0080
	;call ByteFill
	jp _PlayMusic
ByteFill:
	ld [hl], 0
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, ByteFill
	ret
