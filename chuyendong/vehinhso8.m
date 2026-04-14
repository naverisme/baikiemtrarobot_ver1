function P = vehinhso8(tam, kichthuoc, n)
  
    t = linspace(0, 2*pi, n)';
    
    X = tam(1) + (kichthuoc * cos(t)) ./ (1 + sin(t).^2);
    Y = tam(2) + (kichthuoc * cos(t) .* sin(t)) ./ (1 + sin(t).^2);
    Z = tam(3) * ones(n, 1); 
    
    P = [X, Y, Z];
end