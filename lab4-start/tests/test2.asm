main:	addi	$s0, $zero, 5   	# $s0 = 5
	addi    $s3, $zero, -36 	# $s3 = -36
	add	$s2, $s0, $s3   	# $s2 = $s0 + $s3 = -31
btest:	sub	$t0, $s2, $s0   	# $t0 = $s2 - $s0 = -36
test:	beq	$s3, $s0, end
	addi	$s3, $zero, 5   	# $s3 = 5
	jal	new
	j	test
	addi	$s0, $s0, 5   	# $s0 = 5
	addi	$s4, $s4, 5   	# $s4 = 5
	addi	$s5, $s5, 5   	# $s5 = 5
new:	jr	$ra
end:	addi 	$s6, $s6, 5   	# $s6 = 5
