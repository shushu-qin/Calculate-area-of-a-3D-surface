function [N,Nxi,Neta] = ShapeFunc(elem,nen,zgp) 
% 
% [N,Nxi,Neta] = ShapeFunc(elem,nen,zgp) 
%
% Input:    
%   elem: type of element (0 for quadrilaterals and 1 for triangles)
%   nen:  number of element nodes
%   zgp:  coordinates of Gauss points in the reference element
%
% Output:
%   N, Nxi, Neta: matrices storing the values of the shape functions on the Gauss points
%                 of the reference element. Each row concerns to a Gauss point


xi = zgp(:,1); eta = zgp(:,2); 

vect0 = zeros(size(xi));
vect1 = ones(size(xi));

if nen == 0
    ngaus = length(xi); 
    N = zeros(ngaus,0); 
    Nxi = zeros(ngaus,0); 
    Neta = zeros(ngaus,0); 
else
    if elem == 0   % quadrilateral
        if nen == 1  %Q0
            N    = vect1;
            Nxi  = vect0;
            Neta = vect0;
        elseif nen == 4  %Q1
            N    = [(1-xi).*(1-eta)/4, (1+xi).*(1-eta)/4, ...
                    (1+xi).*(1+eta)/4, (1-xi).*(1+eta)/4]; 
            Nxi  = [(eta-1)/4, (1-eta)/4, (1+eta)/4, -(1+eta)/4]; 
            Neta = [(xi-1)/4, -(1+xi)/4,   (1+xi)/4,  (1-xi)/4 ];
        elseif nen == 8
            N = [(1-xi).*(1-eta).*(-1-xi-eta)/4, (1+xi).*(1-eta).*(-1+xi-eta)/4, ...
                 (1+xi).*(1+eta).*(-1+xi+eta)/4, (1-xi).*(1+eta).*(-1-xi+eta)/4,...
                 (1-xi.*xi).*(1-eta)/2,(1+xi).*(1-eta.*eta)/2,...
                 (1-xi.*xi).*(1+eta)/2,(1-xi).*(1-eta.*eta)/2];
            Nxi = [(1-eta).*(2*xi+eta)/4, (1-eta).*(2*xi-eta)/4,...
                   (1+eta).*(2*xi+eta)/4, (1+eta).*(2*xi-eta)/4,...
                   -xi.*(1-eta),(1-eta.*eta)/2,...
                   -xi.*(1+eta),-(1-eta.*eta)/2];
           Neta = [(1-xi).*(2*eta+xi)/4, -(1+xi).*(xi-2*eta)/4,...
                   (1+xi).*(2*eta+xi)/4, (1-xi).*(-xi+2*eta)/4,...
                   -(1-xi.*xi)/2,-eta.*(1+xi),...
                   (1-xi.*xi)/2,-eta.*(1-xi)];
        elseif nen == 9  %Q2
            N    = [xi.*(xi-1).*eta.*(eta-1)/4, xi.*(xi+1).*eta.*(eta-1)/4, ...
                    xi.*(xi+1).*eta.*(eta+1)/4, xi.*(xi-1).*eta.*(eta+1)/4, ...
                    (1-xi.^2).*eta.*(eta-1)/2,  xi.*(xi+1).*(1-eta.^2)/2,   ...
                    (1-xi.^2).*eta.*(eta+1)/2,  xi.*(xi-1).*(1-eta.^2)/2,   ...
                    (1-xi.^2).*(1-eta.^2)];
            Nxi  = [(xi-1/2).*eta.*(eta-1)/2,   (xi+1/2).*eta.*(eta-1)/2, ...
                    (xi+1/2).*eta.*(eta+1)/2,   (xi-1/2).*eta.*(eta+1)/2, ...
                    -xi.*eta.*(eta-1),          (xi+1/2).*(1-eta.^2),   ...
                    -xi.*eta.*(eta+1),          (xi-1/2).*(1-eta.^2),   ...
                    -2*xi.*(1-eta.^2)];
            Neta = [xi.*(xi-1).*(eta-1/2)/2,    xi.*(xi+1).*(eta-1/2)/2, ...
                    xi.*(xi+1).*(eta+1/2)/2,    xi.*(xi-1).*(eta+1/2)/2, ...
                    (1-xi.^2).*(eta-1/2),       xi.*(xi+1).*(-eta),   ...
                    (1-xi.^2).*(eta+1/2),       xi.*(xi-1).*(-eta),   ...
                    (1-xi.^2).*(-2*eta)];
        else
            error ('Error in ShapeFunc: unavailable quadrilateral')
        end
    elseif elem == 1  % triangle
        if nen == 1  %P0
            N    = vect1;
            Nxi  = vect0;
            Neta = vect0;
        elseif nen == 3  %P1
            N    = [xi,eta,1-(xi+eta)]; 
            Nxi  = [vect1, vect0, -vect1]; 
            Neta = [vect0, vect1, -vect1]; 
        elseif nen == 6  %P2
            N    = [xi.*(2*xi-1),eta.*(2*eta-1),(1-2*(xi+eta)).*(1-(xi+eta)),4*xi.*eta,4*eta.*(1-(xi+eta)),4*xi.*(1-(xi+eta))]; 
            Nxi  = [4*xi-1,vect0,-3+4*(xi+eta),4*eta,-4*eta,4*(1-2*xi-eta)]; 
            Neta = [vect0,4*eta-1,-3+4*(xi+eta),4*xi,4*(1-xi-2*eta),-4*xi]; 
        elseif nen == 4  %P1+
            N    = [xi,eta,1-(xi+eta),27*xi.*eta.*(1-xi-eta)]; 
            Nxi  = [vect1, vect0, -vect1, 27*eta.*(1-2*xi-eta)]; 
            Neta = [vect0, vect1, -vect1, 27*xi.*(1-2*eta-xi)]; 
        elseif nen == 7 %P2+
            N    = [xi.*(2*xi-1)	eta.*(2*eta-1)          (1-2*(xi+eta)).*(1-(xi+eta))	...
                    4*xi.*eta       4*eta.*(1-(xi+eta))     4*xi.*(1-(xi+eta))              ...
                    27*xi.*eta.*(1-xi-eta)]; 
            Nxi  = [4*xi-1          vect0                   -3+4*(xi+eta)                   ...
                    4*eta           -4*eta                  4*(1-2*xi-eta)                  ...
                    27*eta.*(1-2*xi-eta)]; 
            Neta = [vect0           4*eta-1                 -3+4*(xi+eta)                   ...
                    4*xi            4*(1-xi-2*eta)          -4*xi                           ...
                    27*xi.*(1-2*eta-xi)]; 
        else
            error ('Error in ShapeFunc: unavailable triangle')
        end
    else
        error ('Error in ShapeFunc')
    end
end