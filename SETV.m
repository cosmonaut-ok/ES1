% SETV - Go back half a time step in velocity

a = zeros(N,1);
ai = zeros(N,1);

% Redistribute force to particles
if weight == 0
for j=1:N       
if (x(j) <= (gridx(1)+0.5*gridx(2)))
            a(j) = -qm*E(1);
end
if (ionx(j) <= (gridx(1)+0.5*gridx(2)))
            ai(j) = -qmi*E(1);
end
end

for i=2:ng-1
    for j=1:N
        if (x(j) > (gridx(i)-0.5*gridx(2))) && (x(j) <= (gridx(i)+0.5*gridx(2)))
            a(j) = -qm*E(i);
        end
        if (ionx(j) > (gridx(i)-0.5*gridx(2))) && (ionx(j) <= (gridx(i)+0.5*gridx(2)))
            ai(j) = -qmi*E(i);
        end
    end
end

    for j=1:N
        if x(j) > gridx(ng)-0.5*gridx(2) 
            a(j) = -qm*E(ng);
        end
        if ionx(j) > gridx(ng)-0.5*gridx(2)
            ai(j) = -qmi*E(ng);
        end
    end
        %Linear weighting
elseif weight == 1
    for j= 1:ng-1
        for k = 1:N
            if ((x(k) ~= 0) && (x(k) ~= 1)) 
            if ((x(k) < gridx(j+1)) && (x(k) > gridx(j)))
                a(k) =  -qm*((gridx(j+1)-x(k))*E(j)/dx + (x(k) - gridx(j))*E(j+1)/dx);
            end
            end
            if ((ionx(k) ~= 0) && (ionx(k) ~= 1))
            if ((ionx(k) < gridx(j+1)) && ionx(k) > gridx(j))
                ai(k) = qmi*((gridx(j+1)-ionx(k))*E(j)/dx + (ionx(k) - gridx(j))*E(j+1)/dx);
            end
            end
        end
    end       
end


v_old = vx - a*dt/2;
v_oldi = vxi-ai*dt/2;