% ACCEL - Calculate force and advance velocity

ai = zeros(N,1);
a = zeros(N,1);


% Redistribute force to particles

% For weight equal to zero (NGP)
if weight == 0

for j=1:N  
if ((x(j) ~= 0) && (x(j) ~= 1))      
if (x(j) <= (gridx(1)+0.5*gridx(2)))
            a(j) = -qm*E(1);
end
end
if ((ionx(j) ~= 0) && (ionx(j) ~= 1))      
if (ionx(j) <= (gridx(1)+0.5*gridx(2)))
            ai(j) = qmi*E(1);
end
end
end

for k=2:ng-1
    for j=1:N
        if ((x(j) ~= 0) && (x(j) ~= 1)) 
        if (x(j) > (gridx(k)-0.5*gridx(2))) && (x(j) <= (gridx(k)+0.5*gridx(2)))
            a(j) = -qm*E(k);
        end
        end
        if ((ionx(j) ~= 0) && (ionx(j) ~= 1))
        if (ionx(j) > (gridx(k)-0.5*gridx(2))) && (ionx(j) <= (gridx(k)+0.5*gridx(2)))
            ai(j) = qmi*E(k);
        end
        end
    end
end

    for j=1:N
        if ((x(j) ~= 0) && (x(j) ~= 1)) 
        if x(j) > gridx(ng)-0.5*gridx(2) 
            a(j) = -qm*E(ng);
        end
        end
        if ((ionx(j) ~= 0) && (ionx(j) ~= 1)) 
        if ionx(j) > gridx(ng)-0.5*gridx(2) 
            ai(j) = qmi*E(ng);
        end
        end
    end
    
    %Linear weighting
elseif weight == 1
    for j= 1:ng-1
        for k = 1:N
            if ((x(k) ~= 0) && (x(k) ~= 1)) 
            if ((x(k) < gridx(j+1)) && (x(k) > gridx(j)))
                a(k) =  -qm*((gridx(j+1)-x(k))*E(j)/dx*L + (x(k) - gridx(j))*E(j+1)/dx*L);
            end
            end
            if ((ionx(k) ~= 0) && (ionx(k) ~= 1))
            if ((ionx(k) < gridx(j+1)) && ionx(k) > gridx(j))
                ai(k) = qmi*((gridx(j+1)-ionx(k))*E(j)/dx*L + (ionx(k) - gridx(j))*E(j+1)/dx*L);
            end
            end
        end
    end        
end
    

v_old = vx;
v_oldi = vxi;
vx = v_old + a*dt/(L*L);
vxi = v_oldi + ai*dt/(L*L);