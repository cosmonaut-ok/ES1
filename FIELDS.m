% FIELDS - E field solver

A = zeros(ng,ng);

A(1,1) = -2;
A(1,2) = 1;

rho(1) = rho(1) + phi_left;

for l=2:ng-1
    A(l,l-1) = 1;
    A(l,l) = -2;
    A(l,l+1) = 1;
end


A(ng,ng-1) = 1;
A(ng,ng) = -2;
rho(ng) = rho(ng)+phi_right;
phi = inv(A)*(-rho)*epsi*(dx*dx);
phi = phi;
E = zeros(ng,1);

E(1) = (phi(1)-phi(2))/(dx);

for j=2:ng-1
    E(j) = (phi(j-1)-phi(j+1))/(2*dx);
end

E(ng) = (phi(ng-1)-phi(ng))/(dx);
E;
