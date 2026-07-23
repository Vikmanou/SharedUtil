--!native

--[=[
	@class Math

	A module providing various mathematical utilities.

	
]=]

-- Guarded for Lute
local GuiService = if game then game:GetService('GuiService') else nil

local Math = {}

-- Constants

--[=[
	@within Math
	@prop phi number
]=]

--[=[
	@within Math
	@prop e number
]=]
Math.phi = (1 + math.sqrt(5)) / 2
Math.e = math.exp(1)

--[=[
	@within Math
	@prop StudToMeter number
]=]

--[=[
	@within Math
	@prop MeterToStud number
]=]
Math.StudToMeter = .28 -- 1 stud = 0.28 meters
Math.MeterToStud = 3.571428571 -- 1 meter = ~3.57 studs

--[=[
	@within Math
	@prop G number
]=]

--[=[
	@within Math
	@prop c number
]=]
Math.G = 6.673 * 10^-11 -- Gravitational constant (in m³/kg/s²)
Math.c = 299792458 -- Speed of light in m/s

--[=[
	@within Math
	@prop inf number
]=]

--[=[
	@within Math
	@prop nan number
]=]
Math.inf = 1/0
Math.nan = 0/0

--[=[
	@within Math
	@prop int8 number
]=]

--[=[
	@within Math
	@prop int16 number
]=]

--[=[
	@within Math
	@prop int32 number
]=]

--[=[
	@within Math
	@prop int64 number
]=]

--[=[
	@within Math
	@prop uint8 number
]=]

--[=[
	@within Math
	@prop uint16 number
]=]

--[=[
	@within Math
	@prop uint32 number
]=]

--[=[
	@within Math
	@prop uint64 number
]=]
Math.int8 = 2^7 - 1
Math.int16 = 2^15 - 1
Math.int32 = 2^31 - 1
Math.int64 = 2^63 - 1
Math.uint8 = 2^8 - 1
Math.uint16 = 2^16 - 1
Math.uint32 = 2^32 - 1
Math.uint64 = 2^64 - 1

--[=[
	@within Math
	@prop byte number
]=]

--[=[
	@within Math
	@prop kilobyte number
]=]

--[=[
	@within Math
	@prop megabyte number
]=]

--[=[
	@within Math
	@prop gigabyte number
]=]

--[=[
	@within Math
	@prop terabyte number
]=]

--[=[
	@within Math
	@prop petabyte number
]=]
Math.byte = 8
Math.kilobyte = 1024
Math.megabyte = Math.kilobyte * 1024
Math.gigabyte = Math.megabyte * 1024
Math.terabyte = Math.gigabyte * 1024
Math.petabyte = Math.terabyte * 1024

--[=[
	@within Math
	@prop rand Random
]=]
Math.rand = if Random then Random.new() else nil


-- Unit Conversions
do
	--[=[
		@within Math
		@param studs number
		@return number
	]=]
	function Math.StudsToMeters(studs: number): number
		return studs * Math.StudToMeter
	end

	--[=[
		@within Math
		@param meters number
		@return number
	]=]
	function Math.MetersToStuds(meters: number): number
		return meters * Math.MeterToStud
	end

	--[=[
		@within Math
		@param kmh number
		@return number
	]=]
	function Math.KmhToStudsPerSecond(kmh: number): number
		return Math.MetersToStuds(kmh / 3.6)
	end

	--[=[
		@within Math
		@param mph number
		@return number
	]=]
	function Math.MphToStudsPerSecond(mph: number): number
		return Math.MetersToStuds(mph * .44704)
	end

	--[=[
		@within Math
		@param studsPerSec number
		@return number
	]=]
	function Math.StudsPerSecondToKmh(studsPerSec: number): number
		return Math.StudsToMeters(studsPerSec) * 3.6
	end

	--[=[
		@within Math
		@param studsPerSec number
		@return number
	]=]
	function Math.StudsPerSecondToMph(studsPerSec: number): number
		return Math.StudsToMeters(studsPerSec) * 2.237
	end
end


-- Numeric Utilities
do
	--[=[
		@within Math
		@param n number
		@return boolean
	]=]
	function Math.Isinf(n: number): boolean
		return math.abs(n) == Math.inf
	end

	--[=[
		@within Math
		@param n number
		@return boolean
	]=]
	function Math.Isnan(n: number): boolean
		return n ~= n
	end

	--[=[
		@within Math
		@param n number
		@return boolean
	]=]
	function Math.IsFinite(n: number): boolean
		return not (Math.Isnan(n) or Math.Isinf(n))
	end
	
	--[=[
		@within Math
		@param n number
		@return number
	]=]
	function Math.FlipSign(n: number): number
		return n * -1
	end
	
	--[=[
		@within Math
		@param n number
		@param copySign number
		@return number
	]=]
	function Math.CopySign(n: number, copySign: number): number
		return math.abs(n) * math.sign(copySign)
	end

	--[=[
		@within Math
		@param n number
		@param min number
		@param max number
		@return boolean
	]=]
	function Math.IsInRange(n: number, min: number, max: number): boolean
		return n >= min and n <= max
	end

	--[=[
		@within Math
		@param num number
		@param decimals number
		@return number
	]=]
	function Math.TruncateToNDecimals(num: number, decimals: number): number
		local factor = 10 ^ decimals
		return math.floor(num * factor) / factor
	end

	--[=[
		@within Math
		@param n number
		@param snap number
		@return number
	]=]
	function Math.SnapNumber(n: number, snap: number): number
		return math.round(n / snap) * snap
	end

	--[=[
		@within Math
		@param n number
		@param pos number
		@return number
	
		Retrieves the digit at a specific position from the right (1-based index)
	]=]
	function Math.GetDigitAtPos(n: number, pos: number): number
		-- starts counting from the end of number
		return math.floor(n%10^pos/(10^pos/10))
	end

	--[=[
		@within Math
		@param n number
		@param trailing number
		@return number

		Trims a number by replacing a set number of trailing digits with zeroes.
		123456, 2 -> 123400
	]=]
	function Math.AddTrailingZeros(n: number, trailing: number): number
		local new = tostring(n)
		return tonumber(new:sub(1, #new - trailing) .. ('0'):rep(trailing)) :: number
	end

	--[=[
		@within Math
		@param n number
		@param multiple number
		@return number
	]=]
	function Math.RoundDownToMultiple(n: number, multiple: number): number
		return n - (n % multiple)
	end
	
	--[=[
		@within Math
		@param n number
		@param multiple number
	]=]
	function Math.RoundToNearestMultiple(n: number, multiple: number)
		local remainder = n % multiple
		return remainder < multiple/2 and n-remainder or n + (multiple-remainder)
	end
	
	--[=[
		@within Math
		@param a number
		@param b number
		@return number
	]=]
	function Math.PositiveMod(a: number, b: number): number
		return (a % b + b) % b
	end

	--[=[
		@within Math
		@param x number
		@param iterations number?
		@return number
	
		Approximates square root of `x` using Newton-Raphson method
	]=]
	function Math.NewtonRaphson(x: number, iterations: number?): number
		if x == 0 then return 0 end
		
		local estimate = x / 2
		for i = 1, (iterations or 5) do
			estimate = (estimate + x / estimate) / 2
		end

		return estimate
	end

	--[=[
		@within Math
		@param n number
		@return number
	
		Legendary Quake trick
	]=]
	function Math.FastInvSqrt(n: number): number
		local packed = string.pack('<f', n)
		local i = string.unpack('<I4', packed)
		i = 0x5f3759df - bit32.rshift(i, 1)
		local y = string.unpack('<f', string.pack('<I4', i))
		y = y * (1.5 - (n*.5 * y * y))
		return y
	end

	--[=[
		@within Math
		@param exp number
		@return number
	]=]
	function Math.NaturalLog(exp: number): number
		return math.log(exp, Math.e)
	end

	--[=[
		@within Math
		@param x number
		@param dx number
		@param func (number) -> number
		@return number
	]=]
	function Math.Derivative(x: number, dx: number, func: (number) -> number): number
		return (func(x + dx) - func(x)) / dx
	end

	--[=[
		@within Math
		@param a number
		@param b number
		@return number
	
		Returns angle difference (shortest path) between two angles
	]=]
	function Math.AngleDifference(a: number, b: number): number
		local diff = (b - a + 180) % 360 - 180
		return diff
	end

	--[=[
		@within Math
		@param a number
		@param b number
		@return boolean
	]=]
	function Math.IsPermutation(a: number, b: number): boolean
		local counts = table.create(10, 0)

		while a > 0 do
			local digit = a % 10
			counts[digit + 1] += 1
			a //= 10
		end

		while b > 0 do
			local digit = b % 10
			counts[digit + 1] -= 1
			b //= 10
		end

		for i = 1, 10 do
			if counts[i] ~= 0 then
				return false
			end
		end

		return true
	end

	--[=[
		@within Math
		@param n number
		@return number
	]=]
	function Math.ReverseNumber(n: number): number
		local reversed = 0

		while n > 0 do
			reversed = 10 * reversed + n % 10
			n = n // 10
		end

		return reversed
	end

	--[=[
		@within Math
		@param n number
		@return number
	]=]
	function Math.Factorial(n: number): number
		if n < 0 then
			return Math.nan
		end
		
		local res = 1
		for i = 2, n do
			res *= i
		end
		return res
	end

	do -- Number compression
		local PRECISION = 1.0000001 -- use 1.00000001 for higher precision, but overflows 32 bits
		local LOG_PRECISION = math.log(PRECISION)
		local THRESHOLD = 1_000_000

		THRESHOLD = math.min(THRESHOLD, math.log(THRESHOLD) / LOG_PRECISION)

		--[=[
			@within Math
			@param n number
			@return number
		]=]
		function Math.ConvertOrderedDataToNumber(n: number): number
			if n <= THRESHOLD then return n end
			return math.floor(PRECISION ^ n)
		end

		--[=[
			@within Math
			@param n number
			@return number
		]=]
		function Math.ConvertNumberToOrderedData(n: number): number
			if n <= THRESHOLD then return n end
			
			local res = math.log(n) / LOG_PRECISION
			return math.floor(res)
		end
	end
end

-- Interpolation & Mapping
do
	--[=[
		@within Math
		@param t number
		@param a number
		@param b number
		@param c number
		@param d number
		@param clamp boolean?
		@return number
	
		Remaps a value `t` from range [a, b] to [c, d]; clamps to output range if `clamp` is true
	]=]
	function Math.MapToRange(t: number, a: number, b: number, c: number, d: number, clamp: boolean?): number
		local res = c + ((d - c) / (b - a)) * (t - a)
		return clamp and math.clamp(res, c, d) or res
	end

	--[=[
		@within Math
		@param current number
		@param target number
		@param smoothing number
		@param dt number
		@return number
	]=]
	function Math.Damp(current: number, target: number, smoothing: number, dt: number): number
		return math.lerp(current, target, 1 - math.exp(-smoothing * dt))
	end

	--[=[
		@within Math
		@param a1 number
		@param a2 number
		@param t number
		@return number
	]=]
	function Math.AngleLerp(a1: number, a2: number, t: number): number
		local delta = (a2 - a1 + 180) % 360 - 180
		return (a1 + delta * t) % 360
	end
end

-- Geometry & Vector Math
do
	--[=[
		@within Math
		@param a Vector3
		@param b Vector3
		@param c Vector3
		@return number
	]=]
	function Math.TriangleArea(a: Vector3, b: Vector3, c: Vector3): number
		return ((b - a):Cross(c - a)).Magnitude / 2
	end

	--[=[
		@within Math
		@param min number
		@param max number
		@param value number
		@return number
	
		Normalizes a value to a range between 0 and 1 based on min/max
	]=]
	function Math.Bound(min: number, max: number, value: number): number
		return (-max + value) / (-max + min)
	end
	
	--[=[
		@within Math
		@param normal Vector3
		@param dir Vector3
		@return Vector3
	]=]
	function Math.Reflect(normal: Vector3, dir: Vector3): Vector3
		return dir - 2 * (dir:Dot(normal)) * normal
	end

	--[=[
		@within Math
		@param linePos Vector3
		@param lineDirection Vector3
		@param pos Vector3
		@param distFromStart number
		@return Vector3
	]=]
	function Math.ClosestPointToLine(linePos: Vector3, lineDirection: Vector3, pos: Vector3, distFromStart: number): Vector3
		return linePos + lineDirection * math.clamp((pos - linePos):Dot(lineDirection), 0, distFromStart)
	end

	--[=[
		@within Math
		@param v1 Vector3
		@param v2 Vector3
		@return number
	]=]
	function Math.AngleBetween(v1: Vector3, v2: Vector3): number
		return math.deg(math.acos(math.clamp(v1.Unit:Dot(v2.Unit), -1, 1)))
	end

	--[=[
		@within Math
		@param vec Vector3
		@param axis Vector3
		@param angle number
		@return Vector3
	]=]
	function Math.RotateVectorAroundAxis(vec: Vector3, axis: Vector3, angle: number): Vector3
		return CFrame.fromAxisAngle(axis.Unit, math.rad(angle)):VectorToWorldSpace(vec)
	end

	--[=[
		@within Math
		@param center CFrame
		@param radius number
		@param amount number
		@param startAngle number?
		@param endAngle number?
		@param offset number?
		@param y number?
		@return {Vector3}
	]=]
	function Math.GetPointsOnCircle(center: CFrame, radius: number, amount: number, startAngle: number?, endAngle: number?, offset: number?, y: number?): {Vector3}
		local points = table.create(amount)

		local sAngle = (startAngle or 0) + (offset or -1)
		local eAngle = (endAngle or math.pi * 2) + (offset or -1)

		local angleRange = eAngle - sAngle
		local angleStep = angleRange / amount

		for i = 1, amount do
			local angle = sAngle + (i - 1) * angleStep

			points[i] = Vector3.new(
				center.X + radius * math.cos(angle),
				center.Y + (y or 0),
				center.Z + radius * math.sin(angle)
			)
		end

		return points
	end
	
	--[=[
		@within Math
		@param start Vector3
		@param endPos Vector3
		@param segments number
		@param amplitude NumberRange?
		@return {Vector3}
	]=]
	function Math.GenerateZigZagPath(start: Vector3, endPos: Vector3, segments: number, amplitude: NumberRange?): {Vector3}
		local path = table.create(segments + 2)
		path[1] = start

		local direction = (endPos - start).Unit
		local totalDistance = (endPos - start).Magnitude
		local segmentLength = totalDistance / segments

		local up = Vector3.new(0, 1, 0)
		local perp = direction:Cross(up)
		if perp.Magnitude == 0 then
			-- If direction is vertical, use another vector for cross
			perp = direction:Cross(Vector3.new(1, 0, 0))
		end
		perp = perp.Unit

		for i = 0, segments do
			local basePoint = start + direction * segmentLength * i
			local thisAplitude = amplitude and Math.rand:NextNumber(amplitude.Min, amplitude.Max) or 1
			local offset = perp * thisAplitude * ((i % 2 == 0) and 1 or -1)
			local zigzagPoint = basePoint + offset
			path[i + 2] = zigzagPoint
		end

		path[#path] = endPos

		return path
	end
	
	--[=[
		@within Math
		@param instance Instance
		@return number
	
		Get the top down size of a part or model no matter its orientation
	]=]
	function Math.GetWorldHeightY(instance: Instance): number
		if instance:IsA('BasePart') then
			local right = instance.CFrame.RightVector * instance.Size.X
			local up = instance.CFrame.UpVector * instance.Size.Y
			local back = instance.CFrame.LookVector * instance.Size.Z

			return math.abs(right.Y) + math.abs(up.Y) + math.abs(back.Y)
		elseif instance:IsA('Model') then
			local cf, sz = instance:GetBoundingBox()
			local half = sz / 2

			local corners = {
				Vector3.new(-half.X, -half.Y, -half.Z),
				Vector3.new(-half.X, -half.Y,  half.Z),
				Vector3.new(-half.X,  half.Y, -half.Z),
				Vector3.new(-half.X,  half.Y,  half.Z),
				Vector3.new( half.X, -half.Y, -half.Z),
				Vector3.new( half.X, -half.Y,  half.Z),
				Vector3.new( half.X,  half.Y, -half.Z),
				Vector3.new( half.X,  half.Y,  half.Z),
			}

			local minY = math.huge
			local maxY = -math.huge
			for _, corner in corners do
				local worldPos = cf:PointToWorldSpace(corner)
				minY = math.min(minY, worldPos.Y)
				maxY = math.max(maxY, worldPos.Y)
			end

			return maxY - minY
		end

		return 0
	end

end

-- Physics
do
	--[=[
		@within Math
		@param obj BasePart
		@param target BasePart
		@param angleLimit number?
		@param rangeLimit number?
		@return boolean
	
		Checks if `target` is within a field-of-view and range from `obj`
	]=]
	function Math.IsInFront(obj: BasePart, target: BasePart, angleLimit: number?, rangeLimit: number?): boolean
		angleLimit = angleLimit or 180
		rangeLimit =  rangeLimit or math.huge

		local Position = target.Position - obj.Position
		local look = obj.CFrame.LookVector
		local direction = Position.Unit
		local angle = math.deg(math.acos(look:Dot(direction)))

		if look:Dot(Position.Unit) > 0 and Position.Magnitude <= rangeLimit and angle < angleLimit then
			return true
		end

		return false
	end

	--[=[
		@within Math
		@param pt CFrame
		@param cf CFrame
		@param sz Vector3
		@return boolean
	]=]
	function Math.IsCenterInRegion(pt: CFrame, cf: CFrame, sz: Vector3): boolean
		-- CFrame.fromMatrix constructs a CFrame from column vectors
		local encodedOBB = CFrame.fromMatrix(
			cf.Position,
			cf.XVector/sz.X,
			cf.YVector/sz.Y,
			cf.ZVector/sz.Z
		):Inverse() * pt

		return math.abs(encodedOBB.X) <= .5
			and math.abs(encodedOBB.Y) <= .5
			and math.abs(encodedOBB.Z) <= .5
	end

	--[=[
		@within Math
		@param point Vector3
		@param cc Vector3
		@param radius number
		@return boolean
	
		Determines if a point lies within a horizontal circle (ignores Y)
	]=]
	function Math.IsPointInCircleXZ(point: Vector3, cc: Vector3, radius: number): boolean
		local flatPoint = Vector3.new(point.X, 0, point.Z)
		local flatCenter = Vector3.new(cc.X, 0, cc.Z)

		local distance = (flatPoint - flatCenter).Magnitude
		return distance <= radius
	end
	
	do -- https://devforum.roblox.com/t/using-a-beam-to-model-projectile-motion/1302237
		--[=[
			@within Math
			@param horizontalDistance number
			@param distanceY number
			@param intialSpeed number
			@param g number
		
			Returns Tuple:  isInRange(boolean), lauchAngle(in Radians)
			gravity must be (+)number
		]=]
		function Math.ComputeLaunchAngle(horizontalDistance: number, distanceY: number, intialSpeed: number, g: number) -- gravity must be (+)number
			local distanceTimesG = g*horizontalDistance -- Micro-optimizations
			local initialSpeedSquared = intialSpeed^2

			local inRoot = initialSpeedSquared^2 - (g*((distanceTimesG*horizontalDistance)+(2*distanceY*initialSpeedSquared)))
			if inRoot <= 0 then
				return false, .25 * math.pi -- Returns false as it is out of range
				-- Makes launch angle 45˚ for ranges past max Range
			end
			local root = math.sqrt(inRoot)
			local inATan1 = (initialSpeedSquared - root) / distanceTimesG
			local inATan2 = (initialSpeedSquared + root) / distanceTimesG
			local answerAngle1 = math.atan(inATan1) -- When optimal launch angle is lofted
			local answerAngle2 = math.atan(inATan2) -- When optimal launch angle is 'direct'
			-- You might be able to change some things and force the launch angle to be lofted at times for certain circumstance
			-- For example, shooting a basketball might require a more lofted trajectory, although EgoMoose's tutorial might be better for that
			if answerAngle1 < answerAngle2 then -- I've honestly never seen it be answer2, I can't figure out the case when it would be. I might remove it at some point
				return true, answerAngle1 -- Returns true as it is in range, same with below
			else
				return true, answerAngle2
			end
		end
		
		--[=[
			@within Math
			@param distanceVector Vector3
			@param initialSpeed number
			@param g number
			@param allowOutOfRange boolean?
		
			gravity: (+)number
		]=]
		function Math.ComputeLaunchVelocity(distanceVector: Vector3, initialSpeed: number, g: number, allowOutOfRange: boolean?) -- gravity: (+)number
			local horizontalDistanceVector = Vector3.new(distanceVector.X, 0, distanceVector.Z)
			local horizontalDistance = horizontalDistanceVector.Magnitude

			local isInRange, launchAngle = Math.ComputeLaunchAngle(horizontalDistance, distanceVector.Y, initialSpeed, g)
			if not isInRange and not allowOutOfRange then return end

			local horizontaldirectionUnit = horizontalDistanceVector.Unit
			local vy = math.sin(launchAngle)
			local xz = math.cos(launchAngle)
			local vx = horizontaldirectionUnit.X * xz
			local vz = horizontaldirectionUnit.Z * xz

			return Vector3.new(vx*initialSpeed, vy*initialSpeed, vz*initialSpeed)
		end
		
		--[=[
			@within Math
			@param distanceVector Vector3
			@param initialSpeed number
			@param g number
			@param allowOutOfRange boolean?
		
			gravity: (+)number
		]=]
		function Math.ComputeLaunchVelocityBeam(distanceVector: Vector3, initialSpeed: number, g: number, allowOutOfRange: boolean?) -- gravity: (+)number
			local distanceY = distanceVector.Y
			local horizontalDistanceVector = Vector3.new(distanceVector.X, 0, distanceVector.Z)
			local horizontalDistance = horizontalDistanceVector.Magnitude

			local isInRange, launchAngle = Math.ComputeLaunchAngle(horizontalDistance, distanceY, initialSpeed, g)
			if not isInRange and not allowOutOfRange then return end

			local horizontaldirectionUnit = horizontalDistanceVector.Unit
			local vy = math.sin(launchAngle)
			local xz = math.cos(launchAngle)
			local vx = horizontaldirectionUnit.X * xz
			local vz = horizontaldirectionUnit.Z * xz

			-- Just for beaming:
			local v0sin = vy * initialSpeed
			local horizontalRangeHalf = ((initialSpeed^2)/g * (math.sin(2*launchAngle)))/2

			local flightTime
			if horizontalRangeHalf <= horizontalDistance then
				flightTime = ((v0sin+(math.sqrt(v0sin^2+(2*-g*((distanceY))))))/g)
			else          
				flightTime = ((v0sin-(math.sqrt(v0sin^2+(2*-g*((distanceY))))))/g)
			end
			--

			return Vector3.new(vx*initialSpeed, vy*initialSpeed, vz*initialSpeed), flightTime -- flightTime is used to beam
		end
		
		-- v0: initialVelocity(Vec3),   x0: initialPosition(Vec3),   t1: flightTime((+)number),   g: gravity((+)number)
        local c = 1/3
		--[=[
			@within Math
			@param v0 Vector3
			@param x0 Vector3
			@param t1 number
			@param g number
		]=]
		function Math.BeamProjectile(v0: Vector3, x0: Vector3, t1: number, g: number)
			local g = Vector3.new(0, -g, 0)
			-- calculate the bezier points
			local p3 = .5*g*t1*t1 + v0*t1 + x0
			local p2 = p3 - (g*t1*t1 + v0*t1)/3
			local p1 = (c*g*t1*t1 + .5*v0*t1 + x0 - c*(x0+p3))/(3*c) - p2

			-- the curve sizes
			local curve0 = (p1 - x0).magnitude
			local curve1 = (p2 - p3).magnitude

			-- build the world CFrames for the attachments
			local b = (x0 - p3).unit
			local r1 = (p1 - x0).unit
			local u1 = r1:Cross(b).unit
			local r2 = (p2 - p3).unit
			local u2 = r2:Cross(b).unit
			b = u1:Cross(r1).unit

			local cf0 = CFrame.new(
				(x0.x), (x0.y), (x0.z),
				r1.x, u1.x, b.x,
				r1.y, u1.y, b.y,
				r1.z, u1.z, b.z)

			local cf1 = CFrame.new(
				(p3.x), (p3.y), (p3.z),
				r2.x, u2.x, b.x,
				r2.y, u2.y, b.y,
				r2.z, u2.z, b.z)

			return curve0, -curve1, cf0, cf1
		end
	end
end

-- Statistics
do
	--[=[
		@within Math
		@param t {number}
		@return number
	]=]
	function Math.Mean(t: {number}): number
		local sum = 0
		for _, v in t do
			sum += v
		end
		return sum / #t
	end
	Math.Average = Math.Mean

	--[=[
		@within Math
		@param t {number}
		@return number
	]=]
	function Math.Median(t: {number}): number
		local sorted = table.clone(t)
		table.sort(sorted)
		local n = #sorted
		if n % 2 == 1 then
			return sorted[math.ceil(n / 2)]
		else
			return (sorted[n/2] + sorted[n/2 + 1]) / 2
		end
	end

	--[=[
		@within Math
		@param t {number}
		@return number
	]=]
	function Math.StdDev(t: {number}): number
		local mean = Math.Mean(t)
		local variance = 0
		for _, v in t do
			variance += (v - mean) ^ 2
		end
		return math.sqrt(variance / #t)
	end

	--[=[
		@within Math
		@param values {number}
		@return number
	]=]
	function Math.Range(values: {number}): number
		local minVal, maxVal = math.huge, -math.huge
		for _, v in values do
			if v < minVal then minVal = v end
			if v > maxVal then maxVal = v end
		end
		return maxVal - minVal
	end

	--[=[
		@within Math
		@param values {number}
		@return number?
	]=]
	function Math.Mode(values: {number}): number?
		local counts = {}
		local maxCount = 0
		local mode: number?

		for _, v in values do
			counts[v] = (counts[v] or 0) + 1
			if counts[v] > maxCount then
				maxCount = counts[v]
				mode = v
			end
		end

		return mode
	end

	--[=[
		@within Math
		@param values {number}
		@return number
	]=]
	function Math.Variance(values: {number}): number
		local mean = Math.Mean(values)
		local variance = 0
		for _, v in values do
			variance += (v - mean) ^ 2
		end
		return variance / #values
	end

	--[=[
		@within Math
		@param value number
		@param values {number}
		@return number
	]=]
	function Math.ZScore(value: number, values: {number}): number
		local mean = Math.Mean(values)
		local stdDev = math.sqrt(Math.Variance(values))
		return (value - mean) / stdDev
	end
end

-- Functions
do
	--[=[
		@within Math
		@param z number
		@return number
	]=]
	function Math.Sigmoid(z: number): number
		return 1 / (1 + Math.e ^ -z)
	end

	--[=[
		@within Math
		@param a number
		@param b number
		@param c number
		@param t number
		@return number
	]=]
	function Math.Quadratic(a: number, b: number, c: number, t: number): number
		return a * (t ^ 2) + (b * t) + c
	end
	
	--[=[
		@within Math
		@param p0 number
		@param p1 number
		@param p2 number
		@param t number
		@return number
	]=]
	function Math.Bezier(p0: number, p1: number, p2: number, t: number): number
		local a = p0 - 2*p1 + p2
		local b = -2*p0 + 2*p1
		local c = p0
		return a * (t ^ 2) + (b * t) + c
	end

	--[=[
		@within Math
		@param p0 Vector3
		@param p1 Vector3
		@param p2 Vector3
		@param t number
		@return Vector3
	]=]
	function Math.BezierVec3(p0: Vector3, p1: Vector3, p2: Vector3, t: number): Vector3
		local u = 1 - t
		return u*u*p0 + 2*u*t*p1 + t*t*p2
	end

	--[=[
		@within Math
		@param p0 Vector3
		@param p1 Vector3
		@param p2 Vector3
		@param t number
		@return Vector3
	
		First derivative gives the tangent direction at t (not normalized)
	]=]
	function Math.BezierVec3Tangent(p0: Vector3, p1: Vector3, p2: Vector3, t: number): Vector3
		return 2*(1-t)*(p1-p0) + 2*t*(p2-p1)
	end
end

--  Algorithms
do
	--[=[
		@within Math
		@param a number
		@param b number
		@param mod number?
	]=]
	function Math.BinaryExponentiation(a: number, b: number, mod: number?)
		local m = mod or math.huge

		local res = 1
		a = a % m
		while b > 0 do
			if bit32.band(b, 1) ~= 0 then
				res = (res * a) % m
			end
			a = (a * a) % m
			b = bit32.rshift(b, 1)
		end
		return res
	end
	
	--[=[
		@within Math
		@param x number
		@param t {number}
		@return (number?, number?)
	]=]
	function Math.FindNearestLowerAndHigherNumbers(x: number, t: {number}): (number?, number?)
		local lower, higher

		for _, num in t do
			if num < x and (lower == nil or num > lower) then
				lower = num
			elseif num > x and (higher == nil or num < higher) then
				higher = num
			end
		end

		return lower, higher
	end
end

-- Number theory
do
	--[[function Math.gcd(a: number, b: number)
		while b ~= 0 do
			a %= b
			
			a = a + b
			b = a - b
			a = a - b
		end
		return a
	end]]

	--[=[
		@within Math
		@param a number
		@param b number
		@return number
	
		Binary gcd
	]=]
	function Math.GCD(a: number, b: number): number
		if a == 0 or b == 0 then return bit32.bor(a, b) end

		local shift = Math.CountTrailingZeros(bit32.bor(a, b))
		a = bit32.rshift(a, Math.CountTrailingZeros(a))

		repeat
			b = bit32.rshift(b, Math.CountTrailingZeros(b))
			if a > b then
				a, b = b, a
			end
			b -= a
		until b == 0

		return bit32.lshift(a, shift)
	end

	--[=[
		@within Math
		@param a number
		@param b number
		@return number
	]=]
	function Math.LCM(a: number, b: number): number
		return a / Math.GCD(a, b) * b
	end

	--[=[
		@within Math
		@param step number
		@param upTo number
		@return number
	
		Sum starting from step
	]=]
	function Math.SumOfConsecutiveNumbers(step: number, upTo: number): number
		local terms = upTo // step
		local lastTerm = terms * step
		return terms * (step + lastTerm)/2
	end

	--[=[
		@within Math
		@param step number
		@param upTo number
		@return number
	
		Sum starting from step
	]=]
	function Math.SumOfConsecutiveSquares(step: number, upTo: number): number
		local terms = upTo // step
		return step * step * terms * (terms + 1) * (2 * terms + 1) // 6
	end

	--[=[
		@within Math
		@param n number
		@param prime number
		@return number
	]=]
	function Math.GetExponentInPrimeFactorization(n: number, prime: number): number
		local exp = 0
		while n % prime == 0 do
			exp += 1
			n //= prime
		end
		return exp
	end
	
	--[=[
		@within Math
		@param n number
		@return { [number]: number }
	]=]
	function Math.PrimeFactors(n: number): { [number]: number }
		local factors = {}
		local i = 2
		while i * i <= n do
			while n % i == 0 do
				factors[i] = (factors[i] or 0) + 1
				n //= i
			end
			
			i += 1
		end
		
		if n > 1 then
			factors[n] = (factors[n] or 0) + 1
		end
		
		return factors
	end

	do
		--[=[
			@within Math
			@param n number
			@return number
		]=]
		function Math.Totient(n: number): number
			local result = n

			local i = 2
			while i * i <= n do
				if n % i == 0 then
					while n % i == 0 do
						n /= i
					end

					result -= result / i
				end

				i += 1
			end

			if n > 1 then
				result -= result / n
			end

			return result
		end

		--[=[
			@within Math
			@param n number
			@return {number}
		]=]
		function Math.TotientsToN(n: number): {number}
			local phi = table.create(n)

			for i = 1, n do
				phi[i] = i
			end

			for i = 2, n do
				if phi[i] == i then
					for j = i, n, i do
						phi[j] -= phi[j] // i
					end
				end
			end

			return phi
		end

		--[=[
			@within Math
			@param n number
			@return number
		
			https://projecteuler.net/overview=0351
			O(n^(2/3) * (log log n)^(1/3))
		]=]
		function Math.TotientSum(n: number): number
			local L = math.floor((n / math.log(math.log(n))) ^ (2 / 3))

			-- Modified Sieve of Eratosthenes for Euler's Totient function
			local sieve = table.create(L)
			for i = 1, L do
				sieve[i] = i
			end

			for p = 2, L do
				if sieve[p] == p then
					for k = p, L, p do
						sieve[k] -= sieve[k] // p
					end
				end

				if p > 1 then
					sieve[p] += sieve[p - 1]
				end
			end

			-- Main loop
			local maxX = n // L
			local bigV = table.create(maxX, 0)

			for x = maxX, 1, -1 do
				local k = n // x
				local res = k * (k + 1) // 2

				-- First inner loop
				local sqrtk = math.floor(math.sqrt(k))
				for g = 2, sqrtk do
					local kg = k // g
					if kg <= L then
						res -= sieve[kg]
					else
						res -= bigV[x * g]
					end
				end

				-- Second inner loop
				for z = 1, sqrtk do
					local q = k // z
					if z ~= q then
						local diff = q - (k // (z + 1))
						res -= diff * sieve[z]
					end
				end

				bigV[x] = res
			end

			return bigV[1]
		end
	end

	do
		--[=[
			@within Math
			@param num number
			@return number
		]=]
		function Math.NumberOfDivisors(num: number): number
			local total = 1

			local i = 2
			while i * i <= num do
				if num % i == 0 then
					local e = 0
					repeat
						e += 1
						num /= i
					until num % i ~= 0

					total *= e + 1
				end

				i += 1
			end

			if num > 1 then
				total *= 2
			end

			return total
		end

		--[=[
			@within Math
			@param num number
			@return number
		]=]
		function Math.SumOfDivisors(num: number): number
			local total = 1

			local i = 2
			while i * i <= num do
				if num % i == 0 then
					local exp = 0
					repeat
						exp += 1
						num //= i
					until num % i ~= 0

					local sum, pow = 0, 1
					repeat
						sum += pow
						pow *= i
						exp -= 1
					until exp < 0

					total *= sum
				end

				i += 1
			end

			if num > 1 then
				total *= (1 + num)
			end

			return total
		end

		--[=[
			@within Math
			@param n number
			@return {number}
		]=]
		function Math.UniquePrimeDivisorsCountSieve(n: number): {number}
			local sieve = table.create(n, 0)

			for p = 2, n do
				if sieve[p] ~= 0 then continue end

				for mult = p, n, p do
					sieve[mult] += Math.GetExponentInPrimeFactorization(mult, p)
				end
			end

			return sieve
		end
	end

	do
		--[=[
			@within Math
			@param n number
			@return boolean
		]=]
		function Math.IsPrime(n: number): boolean
			if n == 2 or n == 3 then return true end
			if n % 2 == 0 or n % 3 == 0 then return false end

			local i = 5
			while i * i <= n do
				if n % i == 0 or n % (i + 2) == 0 then return false end
				i += 6
			end

			return true
		end

		--[=[
			@within Math
			@param L number
			@param R number
			@return {boolean}
		]=]
		function Math.SegmentedPrimeSieve(L: number, R: number): {boolean}
			local lim = math.floor(math.sqrt(R))

			local mark = table.create(lim + 1, false)
			local primes = {}

			for i = 2, lim do
				if not mark[i] then
					table.insert(primes, i)
					for j = i * i, lim, i do
						mark[j] = true
					end
				end
			end

			--

			local isPrime = table.create(R - L + 1, true)
			for _, i in primes do
				for j = math.max(i * i, (L + i - 1) // i * i), R, i do
					isPrime[j - L + 1] = false
				end
			end

			if L == 1 then
				isPrime[1] = false
			end

			return isPrime
		end
	end

	--[=[
		@within Math
		@param n number
		@return boolean
	
		Derived from: P(n) = n(3n - 1)/2
	]=]
	function Math.IsPentagonalNumber(n: number): boolean
		local k = (1 + math.sqrt(1 + 24 * n)) / 6
		return math.floor(k + .5) == k
	end
	
	--[=[
		@within Math
		@param n number
		@return boolean
	
		Derived from: T(n) = n(n + 1)/2
	]=]
	function Math.IsTriangularNumber(n: number): boolean
		local x = (math.sqrt(8 * n + 1) - 1) // 2
		return x * (x + 1) // 2 == n
	end

	--[=[
		@within Math
		@param n number
		@return {number}
	]=]
	function Math.GenerateSquareNumbers(n: number): {number}
		local sieve = table.create(n, 0)

		local currentOdd = 1
		local currentSum = 1
		for i = 1, n do
			sieve[i] = currentSum

			currentOdd += 2
			currentSum += currentOdd
		end

		return sieve
	end
	
	--[=[
		@within Math
		@param n number
		@return boolean
	]=]
	function Math.IsPerfectSquare(n: number): boolean
		if n < 0 then return false end
		local root = math.floor(math.sqrt(n) + .5)
		return root * root == n
	end
end

-- Bit manipulation
do
	--[=[
		@within Math
		@param n number
		@param x number
		@return boolean
	]=]
	function Math.IsBitSet(n: number, x: number): boolean
		return bit32.btest(bit32.band(n, bit32.lshift(1, x)))
	end

	--[=[
		@within Math
		@param n number
		@param x number
		@return number
	]=]
	function Math.SetBit(n: number, x: number): number
		return bit32.bor(n, bit32.lshift(1, x))
	end

	--[=[
		@within Math
		@param n number
		@param x number
		@return number
	]=]
	function Math.FlipBit(n: number, x: number): number
		return bit32.bxor(n, bit32.lshift(1, x))
	end

	--[=[
		@within Math
		@param n number
		@param x number
		@return number
	]=]
	function Math.ClearBit(n: number, x: number): number
		return bit32.band(n, bit32.bnot(bit32.lshift(1, x)))
	end

	--[=[
		@within Math
		@param n number
		@return boolean
	]=]
	function Math.IsPowerOfTwo(n: number): boolean
		return n > 0 and bit32.band(n, n - 1) == 0
	end

	--[=[
		@within Math
		@param n number
		@return number
	]=]
	function Math.CountSetBits(n: number): number
		local count = 0
		while n ~= 0 do
			n = bit32.band(n, n - 1)
			count += 1
		end
		return count
	end

	--[=[
		@within Math
		@param x number
		@return number
	]=]
	function Math.CountTrailingZeros(x: number): number
		if x == 0 then return 0 end

		local n = 0
		while bit32.band(x, 1) == 0 do
			x = bit32.rshift(x, 1)
			n += 1
		end
		return n
	end

	--[=[
		@within Math
		@param n number
		@return number
	
		Returns the number of bits needed to represent n
	]=]
	function Math.BitLength(n: number): number
		if n <= 0 then return 0 end
		return math.floor(math.log(n, 2)) + 1
	end
end

-- Gui
do
	--[=[
		@within Math
		@param x number
		@param y number
		@param parentFrame GuiObject?
		@return (number, number)
	]=]
	function Math.ScaleToOffset(x: number, y: number, parentFrame: GuiObject?): (number, number)
		local size = parentFrame and parentFrame.AbsoluteSize or workspace.Camera.ViewportSize
		return x * size.X, y * size.Y
	end

	--[=[
		@within Math
		@param x number
		@param y number
		@param parentFrame GuiObject?
		@return (number, number)
	]=]
	function Math.OffsetToScale(x: number, y: number, parentFrame: GuiObject?): (number, number)
		local size = parentFrame and parentFrame.AbsoluteSize or workspace.Camera.ViewportSize
		return x / size.X, y / size.Y
	end

	--[=[
		@within Math
		@param gui GuiObject
		@return { topleft: Vector2, bottomleft: Vector2, topright: Vector2, bottomright: Vector2,  }
	]=]
	function Math.GetGuiCorners(gui: GuiObject): { topleft: Vector2, bottomleft: Vector2, topright: Vector2, bottomright: Vector2,  }
		local pos = gui.AbsolutePosition
		local size = gui.AbsoluteSize
		local rotation = math.rad(gui.Rotation)

		local cornerAngle = math.atan2(size.Y, size.X)
		
		local a = pos + size/2-math.sqrt((size.X/2)^2 + (size.Y/2)^2) * Vector2.new(math.cos(rotation + cornerAngle), math.sin(rotation + cornerAngle))
		local b = pos + size/2-math.sqrt((size.X/2)^2 + (size.Y/2)^2) * Vector2.new(math.cos(rotation - cornerAngle), math.sin(rotation - cornerAngle))
		local c = pos + size/2+math.sqrt((size.X/2)^2 + (size.Y/2)^2) * Vector2.new(math.cos(rotation + cornerAngle), math.sin(rotation + cornerAngle))
		local d = pos + size/2+math.sqrt((size.X/2)^2 + (size.Y/2)^2) * Vector2.new(math.cos(rotation - cornerAngle), math.sin(rotation - cornerAngle))

		return { 
			topleft = a,
			bottomleft = b,
			topright = d,
			bottomright = c
		}
	end

	--[=[
		@within Math
		@param gui0 GuiObject
		@param gui1 GuiObject
		@return boolean
	]=]
	function Math.IsGui0InsideGui1(gui0: GuiObject, gui1: GuiObject): boolean
		if gui0.AbsoluteSize.X > gui1.AbsoluteSize.X or gui0.AbsoluteSize.Y > gui1.AbsoluteSize.Y then return false end

		local corners0, corners1 = Math.GetGuiCorners(gui0), Math.GetGuiCorners(gui1)

		local cornersInside = 0

		for _, corner in corners0 do
			if Math.IsInRange(corner.x, corners1[1].X, corners1[4].X) and Math.IsInRange(corner.y, corners1[1].Y, corners1[2].Y) then
				cornersInside += 1
			end
		end

		return cornersInside == 4
	end
	
	--[=[
		@within Math
		@param point Vector2
		@param edgeStartPos Vector2
		@param edgeEndPos Vector2
		@return boolean
	
		Checks if a ray from a point intersects a GUI edge (for polygon hit tests)
	]=]
	function Math.DoesRayFromPointIntersectGuiEdge(point: Vector2, edgeStartPos: Vector2, edgeEndPos: Vector2): boolean
		local x1, y1 = edgeStartPos.X, edgeStartPos.Y
		local x2, y2 = edgeEndPos.X, edgeEndPos.Y

		local x3, y3 = point.X, point.Y
		local x4, y4 = point.X + Math.int32, point.Y

		local den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4)

		if den == 0 then return false end

		local t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den
		local u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / den

		if t and u and t > 0 and t < 1 and u > 0 then
			return true
		end

		return false
	end
	
	--[=[
		@within Math
		@param gui GuiObject
		@param point Vector2
		@return boolean
	]=]
	function Math.IsPointInGUI(gui: GuiObject, point: Vector2): boolean
		return point.X >= gui.AbsolutePosition.X and 
			point.X <= gui.AbsolutePosition.X + gui.AbsoluteSize.X and
			point.Y >= gui.AbsolutePosition.Y and 
			point.Y <= gui.AbsolutePosition.Y + gui.AbsoluteSize.Y
	end

	--[=[
		@within Math
		@param guiObject0 GuiObject
		@param guiObject1 GuiObject
		@return boolean
	]=]
	function Math.AreGuisColliding(guiObject0: GuiObject, guiObject1: GuiObject): boolean
		local ap1 = guiObject0.AbsolutePosition
		local as1 = guiObject0.AbsoluteSize
		local sum = ap1 + as1

		local ap2 = guiObject1.AbsolutePosition
		local as2 = guiObject1.AbsoluteSize
		local sum2 = ap2 + as2

		local corners0 = Math.GetGuiCorners(guiObject0)
		local corners1 = Math.GetGuiCorners(guiObject1)

		local edges = {
			{
				a = corners1.topleft,
				b = corners1.bottomleft
			},
			{
				a = corners1.topleft,
				b = corners1.topright
			},
			{
				a = corners1.bottomleft,
				b = corners1.bottomright
			},
			{
				a = corners1.topright,
				b = corners1.bottomright
			}
		}

		local collisions = 0

		for _, corner in corners0 do
			for _, edge in edges do
				if Math.DoesRayFromPointIntersectGuiEdge(corner, edge.a, edge.b) then
					collisions += 1
				end
			end
		end

		if collisions % 2 ~= 0 then
			return true
		end

		if (ap1.x < sum2.x and sum.x > ap2.x) and (ap1.y < sum2.y and sum.y > ap2.y) then
			return true
		end

		return false
	end
	
	--[=[
		@within Math
		@param origin Vector2
		@param endpoint Vector2
		@param parent Instance
		@param thickness number
		@param frameToUse Frame?
		@param image string?
		@return Frame | ImageLabel
	]=]
	function Math.DrawLine(origin: Vector2, endpoint: Vector2, parent: Instance, thickness: number, frameToUse: Frame?, image: string?): Frame | ImageLabel
		local line do
			local hyp = (endpoint - origin).Magnitude
			
			line = frameToUse or (image and Instance.new('ImageLabel') or Instance.new('Frame'))
			line.Name = 'ConstraintLine'
			line.AnchorPoint = Vector2.new(.5, .5)
			line.Size = UDim2.new(0, hyp, 0, (thickness or 5) + (image and 15 or 0))
			line.BackgroundTransparency = image and 1 or 0
			line.BorderSizePixel = 0

			if image then
				line.Image = image
			end

			line.Parent = parent
		end
		
		local mid = (origin + endpoint)/2
		local theta = math.atan2((endpoint-mid).Y, (endpoint-mid).X)

		-- Apply rotation and update position
		line.Position = UDim2.fromOffset(mid.X, mid.Y + GuiService.TopbarInset.Height)
		line.Rotation = math.deg(theta)

		return line
	end
end

-- Time
do
	--[=[
		@within Math
		@param s number
		@param floor boolean?
		@return (number, number, number, number)
	
		General DHMS conversion for independant manipulation with formatting
	]=]
	function Math.GetDHMS(s: number, floor: boolean?): (number, number, number, number)
		local d, h, m, s = s/86400, (s/(60*60))%24, s/60%60, s%60
		
		local f = function(n: number)return floor and math.floor(n) or n end
		return f(d), f(h), f(m), f(s)
	end
end


-- Number formatting
do
	--[=[
		@within Math
		@param n number
		@return string
	]=]
	function Math.Comma(n: number): string
		local left, num, decimal = string.match(tostring(n), '^([^%d]*%d)(%d*)(.-)$')
		return left .. (num:reverse():gsub('(%d%d%d)', '%1,'):reverse()) .. decimal
	end
	
	local Suffixes = {
		'', 'K', 'M', 'B', 'T', 'Qd', 'Qn', 'Sx', 'Sp', 'Oc', 'No',
		'Dc', 'UDc', 'DDc', 'TDc', 'QdDc', 'QnDc', 'SxDc', 'SpDc', 'OcDc', 'NoDc',
		'Vg', 'UVg', 'DVg', 'TVg', 'QdVg', 'QnVg', 'SxVg', 'SpVg', 'OcVg', 'NoVg',
		'Tg', 'UTg', 'DTg', 'TTg', 'QdTg', 'QnTg', 'SxTg', 'SpTg', 'OcTg', 'NoTg',
		'Qa', 'UQa', 'DQa', 'TQa', 'QdQa', 'QnQa', 'SxQa', 'SpQa', 'OcQa', 'NoQa',
		'Qi', 'UQi', 'DQi', 'TQi', 'QdQi', 'QnQi', 'SxQi', 'SpQi', 'OcQi', 'NoQi',
		'Se', 'USe', 'DSe', 'TSe', 'QdSe', 'QnSe', 'SxSe', 'SpSe', 'OcSe', 'NoSe',
		'St', 'USt', 'DSt', 'TSt', 'QdSt', 'QnSt', 'SxSt', 'SpSt', 'OcSt', 'NoSt',
		'Og', 'UOg', 'DOg', 'TOg', 'QdOg', 'QnOg', 'SxOg', 'SpOg', 'OcOg', 'NoOg',
		'Nn', 'UNn', 'DNn', 'TNn', 'QdNn', 'QnNn', 'SxNn', 'SpNn', 'OcNn', 'NoNn',
		'Ce'
	}
    function Math.SuffixNumber(n: number): string
		if type(n) ~= 'number' then return n end
		if n < 1000 then return tostring(math.floor(n)) end
		
		local power = math.floor(math.log10(n) / 3)
		local index = power + 1
		local suffix = Suffixes[index] or 'e' .. (power * 3)
		
		local scaled = n / (10 ^ (power * 3))
		
		return string.format('%.2f', scaled):gsub('%.?0+$', '') .. suffix
	end
end


-- Colors
do
	--[=[
		@within Math
		@param color Color3
		@return Color3
	]=]
	function Math.InvertColor(color: Color3): Color3
		return Color3.new(1 - color.R, 1 - color.G, 1 - color.B)
	end
	
	--[=[
		@within Math
		@param color Color3
		@return Color3
	
		Complementary color (180° hue shift)
	]=]
	function Math.ComplementaryColor(color: Color3): Color3
		local h, s, v = color:ToHSV()
		h = (h + .5) % 1
		return Color3.fromHSV(h, s, v)
	end
	
	--[=[
		@within Math
		@param color Color3
		@return boolean
	]=]
	function Math.TextShouldBeBlack(color: Color3): boolean
		return (color.R * .299 + color.G * .587 + color.B * .114) > 186
	end
	
	--[=[
		@within Math
		@param color Color3
		@param amount number
		@return Color3
	]=]
	function Math.Lighten(color: Color3, amount: number): Color3
		local h, s, v = color:ToHSV()
		v = math.clamp(v + amount, 0, 1)
		return Color3.fromHSV(h, s, v)
	end

	--[=[
		@within Math
		@param color Color3
		@param amount number
		@return Color3
	]=]
	function Math.Darken(color: Color3, amount: number): Color3
		local h, s, v = color:ToHSV()
		v = math.clamp(v - amount, 0, 1)
		return Color3.fromHSV(h, s, v)
	end
	
	--[=[
		@within Math
		@param a Color3
		@param b Color3
		@return number
	
		Useful to check if colors are similar
	]=]
	function Math.ColorDistance(a: Color3, b: Color3): number
		return math.sqrt((a.R - b.R) ^ 2 + (a.G - b.G) ^ 2 + (a.B - b.B) ^ 2)
	end
	
	--[=[
		@within Math
		@param color Color3
		@param colors {Color3}
		@return Color3
	]=]
	function Math.GetNearestColor(color: Color3, colors: {Color3}): Color3
		local closest: Color3?
		local bestDist = math.huge

		local r, g, b = color.R, color.G, color.B
		
		for _, v in colors do
			local dr = v.R - r
			local dg = v.G - g
			local db = v.B - b
			
			local dist = dr * dr + dg * dg + db * db
			
			if dist < bestDist then
				bestDist = dist
				closest = v
			end
		end
		
		return closest
	end
end


return table.freeze(Math)