.align 0x4

dlplayCode:
	ldr r0, =DLPLAY_NSSHANDLE_LOC_VA ; ns:s handle location
	ldr r0, [r0]

	mrc p15, 0, r1, c13, c0, 3
	add r1, 0x80
	ldr r2, =0x00100180 ; NSS:RebootSystem
	str r2, [r1], #4
	ldr r2, =0x00000001 ; flag
	str r2, [r1], #4
	ldr r2, =0x00000000 ; lower word PID (0 for gamecard)
	str r2, [r1], #4
	ldr r2, =0x00000000 ; upper word PID
	str r2, [r1], #4
	ldr r2, =0x00000002 ; mediatype (2 for gamecard)
	str r2, [r1], #4
	ldr r2, =0x00000000 ; reserved
	str r2, [r1], #4
	ldr r2, =0x00000000 ; flag
	str r2, [r1], #4

	.word 0xef000032 ; svc 0x32 (sendsyncrequest)

	;sleep forever and ever...
	ldr r0, =0xFFFFFFFF
	ldr r1, =0x0FFFFFFF
	.word 0xef00000a ; svc 0xa (sleep)

	.pool
dlplayCode_end:

.align 0x4
dlplayHook:
	.word DLPLAY_CODE_LOC_VA, DLPLAY_CODE_LOC_VA, DLPLAY_CODE_LOC_VA, DLPLAY_CODE_LOC_VA
	.word DLPLAY_CODE_LOC_VA, DLPLAY_CODE_LOC_VA
dlplayHook_end:
