--!strict

local test = require('@std/test')
local Math = require('../math')

local function near(asserts, actual: number, expected: number, eps: number?)
	local e = eps or 1e-6
	asserts.that(
		math.abs(actual - expected) <= e,
		`expected ~{expected} (±{e}), got {actual}`
	)
end

test.case('StudsToMeters', function(a)
	near(a, Math.StudsToMeters(10), 2.8)
end)

test.case('MetersToStuds', function(a)
	near(a, Math.MetersToStuds(10), 35.71428571, 1e-4)
end)

test.case('KmhToStudsPerSecond', function(a)
	near(a, Math.KmhToStudsPerSecond(36), 35.71428571, 1e-4)
end)

test.case('MphToStudsPerSecond', function(a)
	near(a, Math.MphToStudsPerSecond(10), 4.4704 * 3.571428571, 1e-3)
end)

test.case('StudsPerSecondToKmh', function(a)
	near(a, Math.StudsPerSecondToKmh(10), 10.08)
end)

test.case('StudsPerSecondToMph', function(a)
	near(a, Math.StudsPerSecondToMph(10), 6.2636, 1e-4)
end)

test.case('Isinf', function(a)
	a.eq(Math.Isinf(1 / 0), true)
	a.eq(Math.Isinf(5), false)
end)

test.case('Isnan', function(a)
	a.eq(Math.Isnan(0 / 0), true)
	a.eq(Math.Isnan(5), false)
end)

test.case('IsFinite', function(a)
	a.eq(Math.IsFinite(5), true)
	a.eq(Math.IsFinite(1 / 0), false)
end)

test.case('FlipSign', function(a)
	a.eq(Math.FlipSign(5), -5)
end)

test.case('CopySign', function(a)
	a.eq(Math.CopySign(5, -2), -5)
	a.eq(Math.CopySign(-5, 3), 5)
end)

test.case('IsInRange', function(a)
	a.eq(Math.IsInRange(5, 1, 10), true)
	a.eq(Math.IsInRange(11, 1, 10), false)
end)

test.case('TruncateToNDecimals', function(a)
	near(a, Math.TruncateToNDecimals(3.14159, 2), 3.14)
end)

test.case('SnapNumber', function(a)
	a.eq(Math.SnapNumber(7, 5), 5)
	a.eq(Math.SnapNumber(8, 5), 10)
end)

test.case('GetDigitAtPos', function(a)
	a.eq(Math.GetDigitAtPos(12345, 1), 5)
	a.eq(Math.GetDigitAtPos(12345, 2), 4)
end)

test.case('AddTrailingZeros', function(a)
	a.eq(Math.AddTrailingZeros(123456, 2), 123400)
end)

test.case('RoundDownToMultiple', function(a)
	a.eq(Math.RoundDownToMultiple(17, 5), 15)
end)

test.case('RoundToNearestMultiple', function(a)
	a.eq(Math.RoundToNearestMultiple(17, 5), 15)
	a.eq(Math.RoundToNearestMultiple(18, 5), 20)
end)

test.case('PositiveMod', function(a)
	a.eq(Math.PositiveMod(-1, 5), 4)
	a.eq(Math.PositiveMod(7, 5), 2)
end)

test.case('NewtonRaphson', function(a)
	near(a, Math.NewtonRaphson(16, 20), 4, 1e-4)
	a.eq(Math.NewtonRaphson(0), 0)
end)

test.case('FastInvSqrt', function(a)
	near(a, Math.FastInvSqrt(4), 0.5, 1e-2)
end)

test.case('NaturalLog', function(a)
	near(a, Math.NaturalLog(Math.e), 1)
end)

test.case('Derivative', function(a)
	near(a, Math.Derivative(3, 1e-6, function(x: number): number return x * x end), 6, 1e-3)
end)

test.case('AngleDifference', function(a)
	a.eq(Math.AngleDifference(10, 350), -20)
end)

test.case('IsPermutation', function(a)
	a.eq(Math.IsPermutation(123, 321), true)
	a.eq(Math.IsPermutation(123, 45), false)
end)

test.case('ReverseNumber', function(a)
	a.eq(Math.ReverseNumber(123), 321)
end)

test.case('Factorial', function(a)
	a.eq(Math.Factorial(5), 120)
	a.eq(Math.Isnan(Math.Factorial(-1)), true)
end)

test.case('ConvertOrderedDataToNumber', function(a)
	a.eq(Math.ConvertOrderedDataToNumber(500), 500)
end)

test.case('ConvertNumberToOrderedData', function(a)
	a.eq(Math.ConvertNumberToOrderedData(500), 500)
end)

test.case('MapToRange', function(a)
	near(a, Math.MapToRange(5, 0, 10, 0, 100), 50)
	near(a, Math.MapToRange(15, 0, 10, 0, 100, true), 100)
end)

test.case('Damp', function(a)
	near(a, Math.Damp(0, 10, 1, 1), 10 * (1 - math.exp(-1)), 1e-6)
end)

test.case('AngleLerp', function(a)
	near(a, Math.AngleLerp(0, 90, 0.5), 45)
end)

test.case('Bound', function(a)
	near(a, Math.Bound(0, 10, 5), 0.5)
end)

test.case('ComputeLaunchAngle', function(a)
	local inRange, angle = Math.ComputeLaunchAngle(50, 0, 100, 9.8)
	a.eq(inRange, true)
	a.that(angle > 0 and angle < math.pi / 2)

	local outRange, fallback = Math.ComputeLaunchAngle(1e9, 0, 1, 9.8)
	a.eq(outRange, false)
	near(a, fallback, 0.25 * math.pi)
end)

test.case('Mean', function(a)
	near(a, Math.Mean({ 1, 2, 3, 4 }), 2.5)
end)

test.case('Average', function(a)
	near(a, Math.Average({ 2, 4 }), 3)
end)

test.case('Median', function(a)
	a.eq(Math.Median({ 3, 1, 2 }), 2)
	near(a, Math.Median({ 1, 2, 3, 4 }), 2.5)
end)

test.case('StdDev', function(a)
	near(a, Math.StdDev({ 2, 4, 4, 4, 5, 5, 7, 9 }), 2)
end)

test.case('Range', function(a)
	a.eq(Math.Range({ 3, 1, 9, 4 }), 8)
end)

test.case('Mode', function(a)
	a.eq(Math.Mode({ 1, 2, 2, 3 }), 2)
end)

test.case('Variance', function(a)
	near(a, Math.Variance({ 2, 4, 4, 4, 5, 5, 7, 9 }), 4)
end)

test.case('ZScore', function(a)
	near(a, Math.ZScore(5, { 2, 4, 4, 4, 5, 5, 7, 9 }), 0)
end)

test.case('Sigmoid', function(a)
	near(a, Math.Sigmoid(0), 0.5)
end)

test.case('Quadratic', function(a)
	near(a, Math.Quadratic(1, 0, 0, 3), 9)
end)

test.case('Bezier', function(a)
	near(a, Math.Bezier(0, 1, 0, 0.5), 0.5)
end)

test.case('BinaryExponentiation', function(a)
	a.eq(Math.BinaryExponentiation(3, 4, 100), 81)
	a.eq(Math.BinaryExponentiation(2, 10, 1000), 24)
end)

test.case('FindNearestLowerAndHigherNumbers', function(a)
	local lower, higher = Math.FindNearestLowerAndHigherNumbers(5, { 1, 3, 7, 9 })
	a.eq(lower, 3)
	a.eq(higher, 7)
end)

test.case('GCD', function(a)
	a.eq(Math.GCD(48, 36), 12)
end)

test.case('LCM', function(a)
	a.eq(Math.LCM(4, 6), 12)
end)

test.case('SumOfConsecutiveNumbers', function(a)
	a.eq(Math.SumOfConsecutiveNumbers(1, 10), 55)
end)

test.case('SumOfConsecutiveSquares', function(a)
	a.eq(Math.SumOfConsecutiveSquares(1, 3), 14)
end)

test.case('GetExponentInPrimeFactorization', function(a)
	a.eq(Math.GetExponentInPrimeFactorization(24, 2), 3)
end)

test.case('PrimeFactors', function(a)
	a.eq(Math.PrimeFactors(12), { [2] = 2, [3] = 1 })
end)

test.case('Totient', function(a)
	a.eq(Math.Totient(9), 6)
end)

test.case('TotientsToN', function(a)
	a.eq(Math.TotientsToN(6), { 1, 1, 2, 2, 4, 2 })
end)

test.case('TotientSum', function(a)
	a.eq(Math.TotientSum(10), 32)
end)

test.case('NumberOfDivisors', function(a)
	a.eq(Math.NumberOfDivisors(12), 6)
end)

test.case('SumOfDivisors', function(a)
	a.eq(Math.SumOfDivisors(12), 28)
end)

test.case('UniquePrimeDivisorsCountSieve', function(a)
	a.eq(Math.UniquePrimeDivisorsCountSieve(6), { 0, 1, 1, 2, 1, 2 })
end)

test.case('IsPrime', function(a)
	a.eq(Math.IsPrime(97), true)
	a.eq(Math.IsPrime(98), false)
end)

test.case('SegmentedPrimeSieve', function(a)
	a.eq(Math.SegmentedPrimeSieve(10, 20), {
		false, true, false, true, false, false, false, true, false, true, false,
	})
end)

test.case('IsPentagonalNumber', function(a)
	a.eq(Math.IsPentagonalNumber(5), true)
	a.eq(Math.IsPentagonalNumber(6), false)
end)

test.case('IsTriangularNumber', function(a)
	a.eq(Math.IsTriangularNumber(6), true)
	a.eq(Math.IsTriangularNumber(7), false)
end)

test.case('GenerateSquareNumbers', function(a)
	a.eq(Math.GenerateSquareNumbers(5), { 1, 4, 9, 16, 25 })
end)

test.case('IsPerfectSquare', function(a)
	a.eq(Math.IsPerfectSquare(16), true)
	a.eq(Math.IsPerfectSquare(17), false)
end)

test.case('IsBitSet', function(a)
	a.eq(Math.IsBitSet(5, 0), true)
	a.eq(Math.IsBitSet(5, 1), false)
end)

test.case('SetBit', function(a)
	a.eq(Math.SetBit(0, 3), 8)
end)

test.case('FlipBit', function(a)
	a.eq(Math.FlipBit(0, 1), 2)
	a.eq(Math.FlipBit(2, 1), 0)
end)

test.case('ClearBit', function(a)
	a.eq(Math.ClearBit(7, 1), 5)
end)

test.case('IsPowerOfTwo', function(a)
	a.eq(Math.IsPowerOfTwo(16), true)
	a.eq(Math.IsPowerOfTwo(6), false)
end)

test.case('CountSetBits', function(a)
	a.eq(Math.CountSetBits(7), 3)
end)

test.case('CountTrailingZeros', function(a)
	a.eq(Math.CountTrailingZeros(8), 3)
end)

test.case('BitLength', function(a)
	a.eq(Math.BitLength(8), 4)
end)

test.case('GetDHMS', function(a)
	local d, h, m, s = Math.GetDHMS(90061, true)
	a.eq(d, 1)
	a.eq(h, 1)
	a.eq(m, 1)
	a.eq(s, 1)
end)

test.case('Comma', function(a)
	a.eq(Math.Comma(1234567), '1,234,567')
end)

test.case('SuffixNumber', function(a)
	a.eq(Math.SuffixNumber(1500), '1.5K')
	a.eq(Math.SuffixNumber(999), '999')
end)
