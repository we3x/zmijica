
	org	32768
pocetak:	
	call	make_border
	ld	a,%00010000
	ld	(dir1),a
	ld	(dir2),a
	ld	bc,$3040
	ld 	(pozicija1),bc
	call	plot_xy
	ld	bc,$90C0
	ld 	(pozicija2),bc
	call	plot_xy
	;=======================
start:
	HALT
	call	scan_keys_1
	call	scan_keys_2

	ld	a,(dir1)
	bit	4,a
	jr	nz,start

	ld	a,(dir2)
	bit	4,a
	jr	nz,start

	call	move_players
	ld	a,0
	ld	a,(dir1)
	cp	0
	jp	z,start
	
	ld	a,0
	ld	a,(dir2)
	cp	0
	
	jp	z,start

	ld	bc,(pozicija1)
	call	test
	cp 	0
	ret	nz

	ld	bc,(pozicija2)
	call 	test
	cp	0
	ret	nz	

	call	CRTAJ_AAAAAAAAA
	;izlaz ako je q pritisnuto:

	ld	bc,$fbfe
	in	a,(c)
	bit 	0,a
	ret 	z

	jp	start
	ret
;===============================================
;===============================================

;crtanje 	bordera
	
;================================================
make_border:

	ld	c,0
_border_horiz:
	ld	b,0
	call	plot_xy
	ld	b,191
	call	plot_xy
	inc	c
	jr	nz,_border_horiz

	ld	b,0
_border_vert:
	ld	c,0
	call	plot_xy
	ld	c,255
	call	plot_xy
	inc	b
	ld	a,b
	cp	192
	jr	nz,_border_vert

	ret	
;===================================================

;CRTA SMRDICE

;==================================================
CRTAJ_AAAAAAAAA:
	ld	bc,(pozicija1)
	call	plot_xy
	ld	bc,(pozicija2)
	call	plot_xy
	ret
;================================================
;Funkcija za skeniranje tastera prvog igraca

scan_keys_1:
	; citanje tastera za levo:

	ld	bc,$bffe
	in	a,(c)
	bit 	3,a
	call	z,ide_levo1


	; citanje tastera za desno:
	ld	bc,$bffe
	in	a,(c)
	bit	1,a	
	call	z,ide_desno1

	; citanje tastera za gore:
	ld	bc,$dffe
	in	a,(c)
	bit 	2,a
	call 	z,ide_gore1
	
	; citanje tastera za dole:
	ld	bc,$bffe
	in	a,(c)
	bit	2,a
	call	z,ide_dole1

	ret
;=================================================
desno1:	 
	ld	bc,(pozicija1)
	inc 	c
	ld 	(pozicija1),bc
	ret
;=================================================
levo1:
	ld	bc,(pozicija1)
	dec	c
	ld	(pozicija1),bc
	ret
;=================================================	
gore1:
	ld	bc,(pozicija1)
	dec	b
	ld	(pozicija1),bc
	ret
;=================================================
dole1:
	ld	bc,(pozicija1)
	inc	b
	ld	(pozicija1),bc
	ret
;==============================
;javlja da se krecemo u desno

ide_desno1:

	ld	a,%00000001
	ld	(dir1),a
	ret
;============================
;javlja da se krecemo u levo

ide_levo1:

	ld	a,%00000010
	ld	(dir1),a
	ret
;============================
;javlja da se krecemo na gore

ide_gore1:
	ld	a,%00000100
	ld	(dir1),a
	ret
;============================
;javlja da se krecemo na dole

ide_dole1:

	ld	a,%00001000
	ld	(dir1),a
	ret
;====================================


	
;=================================================
;=================================================


;================================================
;==============================================
;funkcija za stalno pomeranje

move_players:
	;prvi igrac


	ld	a,(dir1)
	bit 	0,a
	call 	nz,desno1

	ld	a,(dir1)
	bit	1,a
	call	nz,levo1

	ld	a,(dir1)
	bit	2,a
	call	nz,gore1

	ld	a,(dir1)
	bit	3,a
	call	nz,dole1

	;drugi igrac

	ld	a,(dir2)
	bit 	0,a
	call 	nz,desno2

	ld	a,(dir2)
	bit	1,a
	call	nz,levo2
	
	ld	a,(dir2)
	bit	2,a
	call	nz,gore2

	ld	a,(dir2)
	bit	3,a
	call	nz,dole2

	ret

;================================================
;================================================
;Funkcija za skeniranje tastera drugog igraca
;
scan_keys_2:
	
	
	; citanje tastera za levo:

	ld	bc,$fdfe
	in	a,(c)
	bit 	0,a
	call	z,ide_levo2


	; citanje tastera za desno:
	ld	bc,$fdfe
	in	a,(c)
	bit	2,a	
	call	z,ide_desno2

	; citanje tastera za gore:
	ld	bc,$fbfe
	in	a,(c)
	bit 	1,a
	call 	z,ide_gore2
	
	; citanje tastera za dole:
	ld	bc,$fdfe
	in	a,(c)
	bit	1,a
	call	z,ide_dole2

	ret
	;==============================
	;javlja da se krecemo u desno

ide_desno2:

	ld	a,%00000001
	ld	(dir2),a
	ret
	;============================
	;javlja da se krecemo u levo

ide_levo2:
	ld	a,%00000010
	ld	(dir2),a
	ret
	;============================
	;javlja da se krecemo na gore

ide_gore2:

	ld	a,%00000100
	ld	(dir2),a
	ret
	;============================
	;javlja da se krecemo na dole
	
ide_dole2:
	ld	a,%00001000
	ld	(dir2),a
	ret

	;====================================
	
;=================================================
desno2:	 
	
	ld	bc,(pozicija2)
	inc 	c
	ld 	(pozicija2),bc
	ret
;=================================================
levo2:
	ld	bc,(pozicija2)
	dec	c
	ld	(pozicija2),bc
	ret
;=================================================	
gore2:
	ld	bc,(pozicija2)
	dec	b
	ld	(pozicija2),bc
	ret
;=================================================
dole2:
	ld	bc,(pozicija2)
	inc	b
	ld	(pozicija2),bc
	ret
;=================================================
;=================================================

test:
	;izlazi ako nema pomeranja
	
	;ld 	a,(dir1)
	;cp 	0
	;ret	z
	;ld 	a,(dir2)
	;cp 	0
	;ret	z

	;u a se nalazi rezultat, cp se a,a==0 ako nema, a==nesto ako ima
	push	bc
	push	hl

	; Izracunava adresu bajta u kome je piksel.
	; Rezultat ostaje u HL:

	ld	a,b
	call	calc_y_addr
	ld	a,c
	and	%11111000
	srl	a
	srl	a
	srl	a
	or	l
	ld	l,a

	; Postavljanje potrebnog piksela:

	ld	a,c
	and	%00000111

	ld	b,%10000000

_pixel_shift2:
	
	cp	0
	jr	z,_shift_done2	
	srl	b
	dec	a
	jr	_pixel_shift2
	
_shift_done2:

	ld	a,b
	and	(hl)
	
	pop	hl
	pop	bc
	ret	



;------------------------------------------------
; Postavlja tacku na koordinate (X,Y) gde su 
; koordinate u paru BC = (YX). 
;------------------------------------------------

plot_xy:
	push	af
	push	bc
	push	hl

	; Izracunava adresu bajta u kome je piksel.
	; Rezultat ostaje u HL:

	ld	a,b
	call	calc_y_addr
	ld	a,c
	and	%11111000
	srl	a
	srl	a
	srl	a
	or	l
	ld	l,a

	; Postavljanje potrebnog piksela:

	ld	a,c
	and	%00000111

	ld	b,%10000000

_pixel_shift:
	
	cp	0
	jr	z,_shift_done	
	srl	b
	dec	a
	jr	_pixel_shift
	
_shift_done:

	ld	a,b
	or	(hl)
	ld	(hl),a
	
	pop	hl
	pop	bc
	pop	af
	ret	

;------------------------------------------------
; Racuna adresu pocetnog bajta na osnovu Y 
; koordinate u registru A, gde je sadržaj A
; organizovan kao IIMMMNNN, dok HL finalno
; treba da sardzi 010IINNNMMM00000
;------------------------------------------------

calc_y_addr:
	; Ubaci NNN u H:

	ld	hl,$4000
	push	af
	and	%00000111
	or	h
	ld	h,a

	; Ubaci MMM u L:

	pop	af
	push	af
	and	%00111000
	sla	a
	sla	a
	or	l
	ld	l,a

	; Ubaci II u H:

	pop	af
	push	af
	and	%11000000
	srl	a
	srl	a
	srl	a
	or	h
	ld	h,a

	pop	af
	ret
;============================================

pozicija1:
	dw	$3040

pozicija2:
	dw	$90c0
dir1:
	db	0
dir2:	
	db	0


