clear;
nen = 3;
ngaus = 4;
    
% set information of reference element
refElem = SetRefElement1D(nen,ngaus);

length = 0;
filename = 'mesh1.txt';  
[connect coord] = readData(filename,nen);

%%%%%---------3D--------%%%%%%
for i = 1:size(connect,1)
    Xe = coord(connect(i,:),:);
    for ig = 1:ngaus  
        N_ig    = refElem.N(ig,:);
        Nxi_ig  = refElem.Nxi(ig,:);

        Jacob = Nxi_ig(1:nen)*Xe;

        detJ = norm(Jacob);
        length = length + detJ*refElem.wgp(ig);
    end
end
length
