% SETRHO - Weight charge onto spatial grid
erho = zeros(ng,1); % charge vector
ionrho = zeros(ng,1);

if weight == 0

for j=1:N       
if (x(j) > 0 && x(j) <= (gridx(1)+0.5*gridx(2)))
            erho(1) = erho(1)+1;
end
end

for k=2:ng-1
    for j=1:N
        if ((x(j) > (gridx(k)-0.5*gridx(2))) && (x(j) <= (gridx(k)+0.5*gridx(2))))
            erho(k) = erho(k)+1;
        end
    end
end

    for j=1:N
        if ((x(j) > gridx(ng)-0.5*gridx(2) && (x(j) < 1)))
            erho(ng) = erho(ng)+1;
        end
    end


    

for j=1:N       
if (ionx(j) > 0 && ionx(j) <= (gridx(1)+0.5*gridx(2)))
            ionrho(1) = ionrho(1)+1;
end
end

for k=2:ng-1
    for j=1:N
        if ((ionx(j) > (gridx(k)-0.5*gridx(2))) && (ionx(j) <= (gridx(k)+0.5*gridx(2))))
            ionrho(k) = ionrho(k)+1;
        end
    end
end

    for j=1:N
        if ((ionx(j) > gridx(ng)-0.5*gridx(2) && (ionx(j) < 1)))
            ionrho(ng) = ionrho(ng)+1;
        end
    end
    
    % Linear Weighting
elseif weight == 1
    for j= 1:ng-1
        for k = 1:N
            if ((x(k) < gridx(j+1)) && (x(k) > gridx(j)))
                erho(j) = erho(j) + (gridx(j+1)-x(k))/dx*L;
                erho(j+1) = erho(j+1) + (x(k) - gridx(j))/dx*L;
            end
            if ((ionx(k) < gridx(j+1)) && ionx(k) > gridx(j))
                ionrho(j) = ionrho(j) + (gridx(j+1)-ionx(k))/dx*L;
                ionrho(j+1) = ionrho(j+1) + (ionx(k) - gridx(j))/dx*L;
            end
        end
    end
end

        density_e = erho*nN/(dx*dx*dx);
    erho = -erho*nN*q/(dx);
    
         density_i = ionrho*nN/(dx*dx*dx);
        ionrho = ionrho*nN*q/(dx);

        
        rho = erho+ionrho;