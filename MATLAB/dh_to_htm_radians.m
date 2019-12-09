function htm = dh_to_htm_radians(d, theta, a, alpha)
    htm = [cos(theta), -1*round(cos(alpha), 3)*sin(theta), round(sin(alpha), 3)*sin(theta),  a*cos(theta);
        sin(theta), round(cos(alpha), 3)*cos(theta), -1*round(sin(alpha), 3)*sin(theta), a*sin(theta);
        0, round(sin(alpha), 3), round(cos(alpha), 3), d;
        0, 0, 0, 1];