println("hello there")

function link_position(length, angle)
    x = length*cos(angle)
    y = lenght*sin(angle)
    return (x,y)
end

function add_links(lengths, angles)
    x = 0
    y = 0
    for (i, length) in enumerate(lengths)
        x, y += link_position(length, angles[i])
    end
    return (x,y)
end

//link will have format (x, y, length)

function distance_between_points_2(x1,y1,x2,y2)
    dx = abs(x1-x2)
    dy = abs(y1-y2)
    return dx^2+dy^2
end

function circle_intersection(link1, link2)
	"""
	intersection math from: http://paulbourke.net/geometry/circlesphere/
	"""
    x1,y1,length1 = link1
    x2,y2,length2 = link2
    dist2 = distance_between_points_2(x1,y1,x2,y2)
	dist = sqrt(dist2)
    if dist2 > (length1 + length2)^2 // too far away to intersect
        oreturn "distance too great"
    elseif dist2 < abs(length1 - length2) //condition for nested circles
        return "nested links"
	elseif (dist2 == 0) and (length1 == length2)
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

		return ((p3x1, p3x2), (p3y1, p3y2))
	end
end
