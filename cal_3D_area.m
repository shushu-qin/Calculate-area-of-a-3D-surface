elem = 0;
if elem==1
    nen = 6;
    ngaus = 3;
else
    nen = 8;
    ngaus = 4;
end
    
% set information of reference element
refElem = SetRefElement(elem,nen,ngaus);

area = 0;
filename = 'mesh3.txt';  
[connect coord] = readData(filename,nen);

%%%%%---------3D--------%%%%%%
for i = 1:size(connect,1)
    Xe = coord(connect(i,:),:);
    for ig = 1:ngaus  
        N_ig    = refElem.N(ig,:);
        Nxi_ig  = refElem.Nxi(ig,:);
        Neta_ig = refElem.Neta(ig,:);
        
        Jacob = [Nxi_ig(1:nen); Neta_ig(1:nen)]*Xe;

        detJ = norm(cross(Jacob(1,:),Jacob(2,:)));
        area = area + detJ*refElem.wgp(ig);
    end
end
area
% err = abs((area-4*pi*10^2)/(4*pi*10^2))