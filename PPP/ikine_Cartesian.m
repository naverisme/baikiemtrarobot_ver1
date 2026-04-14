function q = ikine_Cartesian(Px, Py, Pz)

    d1 = Pz;
    d2 = Px;
    d3 = -Py; 
    
    if d3 < 0
        warning('Tọa độ Y = %.2f đang dương, trục d3 sẽ bị kéo ngược lên trên!', Py);
    end
    
    q = [d1, d2, d3];
end