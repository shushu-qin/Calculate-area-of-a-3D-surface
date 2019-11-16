function [N,Nxi] = ShapeFunc_1D(nen,zgp) 
% 
% [N,Nxi] = ShapeFunc_1D(nen,zgp) 
% N, Nxi:  matrices storing the values of the shape functions on the Gauss points
%          of the reference element
%          Each row concerns to a Gauss point
% nen:     number of nodes per element
% zgp:     coordinates of Gauss points in the reference element


xi = zgp(:,1);

if nen == 2
    N =   [(1-xi)/2,           (1+xi)/2];
    Nxi = [-ones(size(xi))/2,  ones(size(xi))/2];
elseif nen == 3
    N =   [xi.*(xi-1)/2, xi.*(xi+1)/2, (1+xi).*(1-xi)  ];
    Nxi = [xi-1/2,      xi+1/2,   -2*xi          ];
else 
    error ('Error in ShapeFunc_1D: wrong number of nodes')
end

