INCLUDE "includes.asm"
INCLUDE "macros/wram.asm"
INCLUDE "vram.asm"


SECTION "Stack", WRAM0

wRAM0Start::
StackBottom::
	ds $100 - 1
Stack::
StackTop::
	ds 1


SECTION "Audio RAM", WRAM0

wMusic::

; nonzero if playing
MusicPlaying:: db ; c100

Channels::
Channel1:: channel_struct Channel1 ; c101
Channel2:: channel_struct Channel2 ; c133
Channel3:: channel_struct Channel3 ; c165
Channel4:: channel_struct Channel4 ; c197

SFXChannels::
Channel5:: channel_struct Channel5 ; c1c9
Channel6:: channel_struct Channel6 ; c1fb
Channel7:: channel_struct Channel7 ; c22d
Channel8:: channel_struct Channel8 ; c25f

	ds 1 ; c291

wCurTrackDuty:: db
wCurTrackIntensity:: db
wCurTrackFrequency:: dw
wc296:: db ; BCD value, dummied out
wCurNoteDuration:: db ; used in MusicE0 and LoadNote

CurMusicByte:: db ; c298
CurChannel:: db ; c299
Volume:: ; c29a
; corresponds to $ff24
; Channel control / ON-OFF / Volume (R/W)
;   bit 7 - Vin->SO2 ON/OFF
;   bit 6-4 - SO2 output level (volume) (# 0-7)
;   bit 3 - Vin->SO1 ON/OFF
;   bit 2-0 - SO1 output level (volume) (# 0-7)
	db
SoundOutput:: ; c29b
; corresponds to $ff25
; bit 4-7: ch1-4 so2 on/off
; bit 0-3: ch1-4 so1 on/off
	db
SoundInput:: ; c29c
; corresponds to $ff26
; bit 7: global on/off
; bit 0: ch1 on/off
; bit 1: ch2 on/off
; bit 2: ch3 on/off
; bit 3: ch4 on/off
	db

MusicID:: dw ; c29d
MusicBank:: db ; c29f
NoiseSampleAddress:: dw ; c2a0
wNoiseSampleDelay:: db ; c2a2
	ds 1 ; c2a3
MusicNoiseSampleSet:: db ; c2a4
SFXNoiseSampleSet:: db ; c2a5

Danger:: ; c2a6
; bit 7: on/off
; bit 4: pitch
; bit 0-3: counter
	db

MusicFade:: ; c2a7
; fades volume over x frames
; bit 7: fade in/out
; bit 0-5: number of frames for each volume level
; $00 = none (default)
	db
MusicFadeCount:: db ; c2a8
MusicFadeID:: dw ; c2a9

	ds 5

CryPitch:: dw ; c2b0
CryLength:: dw ; c2b2

LastVolume:: db ; c2b4
wc2b5:: db ; c2b5

SFXPriority:: ; c2b6
; if nonzero, turn off music when playing sfx
	db

	ds 1

Channel1JumpCondition:: db
Channel2JumpCondition:: db
Channel3JumpCondition:: db
Channel4JumpCondition:: db

wStereoPanningMask:: db ; c2bc

CryTracks:: ; c2bd
; plays only in left or right track depending on what side the monster is on
; both tracks active outside of battle
	db

wSFXDuration:: db
CurSFX:: ; c2bf
; id of sfx currently playing
	db
ChannelsEnd::

wMapMusic:: db ; c2c0

wDontPlayMapMusicOnReload:: db
wMusicEnd::
