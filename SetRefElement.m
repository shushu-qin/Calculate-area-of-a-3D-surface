function Element = SetRefElement(elem,p,ngaus)
% 
% Element = SetRefElement(elem,p,ngauss)
% Reference element properties (type of element, degree, number of nodes,
% nodal coordinates, integration points and weights, shape functions
% evaluated at the integration points)

nen = (p+1)*(p+2)/2; 

Element.elem   = elem; 
Element.nen    = nen; 
Element.degree = p; 

Element.ngaus = ngaus; 
[zgp,wgp] = Quadrature(elem, ngaus); 
[N,Nxi,Neta] = ShapeFunc(elem,nen,zgp); 
Element.zgp = zgp; 
Element.wgp = wgp; 
Element.N    = N; 
Element.Nxi  = Nxi; 
Element.Neta = Neta; 

