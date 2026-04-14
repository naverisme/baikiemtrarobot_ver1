function q = ik_ppp(Px, Py, Pz)

    d1 = Pz;
    d2 = Px;
    d3 = -Py; 
    
    if d3 < 0
        warning('toa do Y = %.2f dang dương, trục  d3 bi huong len tren', Py);
    end
    
    q = [d1, d2, d3];
end