function P = vehinhtron(tam, bankinh, n)
    t = linspace(0, 2*pi, n)';
    
    X = tam(1) + bankinh * cos(t);
    Y = tam(2) + bankinh * sin(t);
    Z = tam(3) * ones(n, 1); 
    
    P = [X, Y, Z];
end