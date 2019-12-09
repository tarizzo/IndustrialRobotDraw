function htm = dh_to_htm_degrees(d, theta, a, alpha)
    htm = [cosd(theta), -1*cosd(alpha)*sind(theta), sind(alpha)*sind(theta),  a*cosd(theta);
        sind(theta), cosd(alpha)*cosd(theta), -1*sind(alpha)*sind(theta), a*sind(theta);
        0, sind(alpha), cosd(alpha), d;
        0, 0, 0, 1];