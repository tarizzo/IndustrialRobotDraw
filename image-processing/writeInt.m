function writeInt(tc, xValue, yValue)
    if xValue > 255 && yValue > 255
        fwrite(tc, [255; xValue - 255; 255; yValue - 255]);
    elseif xValue > 255 && yValue <= 255
        fwrite(tc, [255; xValue - 255; yValue; 0]);
    elseif xValue <= 255 && yValue > 255
        fwrite(tc, [xValue; 0; 255; yValue - 255]);
    else
         fwrite(tc, [xValue; 0; yValue; 0]);
end

