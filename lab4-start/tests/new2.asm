main:	add	$s2, $s0, $s3   	# $s2 = $s0 + $s3 = -31
	addi	$s0, $zero, 5   	# $s0 = 5
	addi	$s1, $zero, 5   	# $s0 = 5
	addi	$s6, $zero, 5   	# $s0 = 5
	addi    $s3, $zero, -36 	# $s3 = -36
	add	$s2, $s0, $s3   	# $s2 = $s0 + $s3 = -31
	sub	$t0, $s2, $s0   	# $t0 = $s2 - $s0 = -36
test:	sll	$t1, $s3, 2
hello:  j	main
	j	test