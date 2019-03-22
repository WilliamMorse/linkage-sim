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
