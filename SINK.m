% SINK - checks particle position against geometry
if BC == 0 % Refective BC
 for l=1:N
    if x(l) < 0
        x(l) = 1+x(l);

    elseif x(l) > 1
        x(l) = x(l)-1;
    end
    
end

for m=1:N
    if ionx(m) < 0
        ionx(m) = 1+ionx(m);    

    elseif ionx(m) > 1

        ionx(m) = ionx(m) - 1;


    end
    
end   
end
if BC == 1 % Wall accumulating charge
for l=1:N
    if x(l) < 0
        x(l) = 0;
                sink_countl = sink_countl+1;
        phi_left = phi_left - nN*q/dx;
        vx(l) = 0;
        v_old(l) = 0;

    elseif x(l) > 1
        phi_right = phi_right - nN*q/dx ;
        x(l) = 1;
        vx(l) = 0;
        v_old(l) = 0;        
        sink_countr = sink_countr+1;
    end
    
end

for m=1:N
    if ionx(m) < 0
        ionx(m) = 0;
                sink_countil = sink_countil+1;
                wall_ions(sink_countil+sink_countir) = vxi(m);
        phi_left = phi_left + nN*q/dx;
        vxi(m) = 0;
        v_oldi(m) = 0;        

    elseif ionx(m) > 1
        sink_countir = sink_countir+1;
        wall_ions(sink_countil+sink_countir) = vxi(m);
        phi_right = phi_right + nN*q/dx; 
        ionx(m) = 1;
        vxi(m) = 0;
        v_oldi(m) = 0;

    end
    
end
end