function Element = SetRefElement1D(nen,ngaus)
% 
% Element = SetRefElement(elem,p,ngauss)
% Reference element properties (type of element, degree, number of nodes,
% nodal coordinates, integration points and weights, shape functions
% evaluated at the integration points)


Element.nen    = nen; 
Element.ngaus = ngaus; 
[zgp,wgp] = Quadrature_1D(ngaus); 
[N,Nxi] = ShapeFunc_1D(nen,zgp); 
Element.zgp = zgp; 
Element.wgp = wgp; 
Element.N    = N; 
Element.Nxi  = Nxi; 


