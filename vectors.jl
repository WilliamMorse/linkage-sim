println("hello there")
using Plots

function len(tuple)
	for (i, element) in enumertate(tuple)
		q = i
	end
	return q
end

function link_end_position(length, angle)
    x = length*cos(angle)
    y = lenght*sin(angle)
    return (x,y)
end

function add_links_from_lengths_and_angles(lengths, angles)
    dx = 0
    dy = 0
    for (i, length) in enumerate(lengths)
        dx, dy += link_end_position(length, angles[i])
    end
    return (dx,dy)
end

function distance_between_points_2(x1,y1,x2,y2)
    dx = abs(x1-x2)
    dy = abs(y1-y2)
    return dx^2+dy^2
end

function circle_intersection(link1, link2)
	"""
	Links need to have format (x, y, length) for the circle intersection.
	Intersection math from: http://paulbourke.net/geometry/circlesphere/
	"""
    x1,y1,length1 = link1
    x2,y2,length2 = link2
    dist2 = distance_between_points_2(x1,y1,x2,y2)
	dist = sqrt(dist2)
    if (dist2 > (length1 + length2)^2)
        return "distance too great"
    elseif dist2 < abs(length1 - length2)
        return "nested links"
	elseif dist2 == 0 & length1 == length2
		return "circles are coincident and same size"
    else
		a = (length1^2-length2^2+dist2)/(2*dist)
		h = sqrt(length1^2 - a^2)
		p2x = x1 + a*(x2-x1)/dist
		p2y = y1 + a*(y2-y1)/dist

		p3x1 = p2x + h*(y2-y1)/dist
		p3x2 = p2x - h*(y2-y1)/dist

		p3y1 = p2y + h*(x2-x1)/dist
		p3y2 = p2y - h*(x2-x1)/dist
		if dist == length1 + length2
			return (p3x1, p3y1)
		elseif dist == abs(length1 - length2)
			return (p3x1, p3y1)
		else
			return ((p3x1, p3x2), (p3y1, p3y2))
		end
	end
end

function angle(x1,y1,x2,y2)
	x = x2-x1
	y = y2-y1
	angle = atan2(x,y)
	return angle
end

"""
println(circle_intersection((0,0,4),(5,0,1)))
println(circle_intersection((0,0,4),(3,0,1)))
println(circle_intersection((0,0,4),(3,0,2)))

points then links
then pins
then motors
then propogate

why not start with the propogation?
here's a simple point pattern:
"""

function points()
	a = ((0,0),(0,1),(2,0))
	return a
end


function link_all(points)

	lengths = ()
	angles = ()
	anchors = ()

	numberOfPoints = len(points[:1])
	for (i, point) in enumerate(points)
		for j in i:numberOfPoints
			x1,y1 = (points[i][1], points[i][2])
			x2,y2 = (points[j][1], points[j][2])
			lengths += sqrt(distance_between_points_2(x1,y1,x2,y2))
			angles += angle(x1,y1,x2,y2)
			anchors += (x1,y1)
		end
	end
	return (anchors, lenghts, angles)
end

a = points()
print(link_all(a))
plot(rot(a))
