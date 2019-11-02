elem = 1;
p = 2;
nen = 6;
ngaus = 3;
% set information of reference element
refElem = SetRefElement(elem,p,ngaus);

area = 0;
filename = 'mesh_data.txt';  % test with a sphere 
[connect coord] = readData(filename);

%%%%%---------3D--------%%%%%%
for i = 1:size(connect,1)
    Xe = coord(connect(i,:),:);
    for ig = 1:ngaus  
        N_ig    = refElem.N(ig,:);
        Nxi_ig  = refElem.Nxi(ig,:);
        Neta_ig = refElem.Neta(ig,:);
        
        Jacob = [Nxi_ig(1:nen); Neta_ig(1:nen)]*Xe;

        Jx = det(Jacob(:,1:2));
        Jy = det(Jacob(:,2:3));
        Jz = det(Jacob(:,[1,3]));
        area = area + norm([Jx,Jy,Jz])*refElem.wgp(ig);
    end
end

err = abs((area-4*pi*10^2)/(4*pi*10^2))

%%%%%%%%%-------2D---------%%%%%%%%%%%%
% Xe = [-1,0;
%       1,0;
%       0,1;
%       0,-0.2;
%       0.4,0.5;
%       -0.4,0.5];
% for ig = 1:ngaus  
%     N_ig    = N(ig,:);
%     Nxi_ig  = Nxi(ig,:);
%     Neta_ig = Neta(ig,:);
% 
%     Jacob = [Nxi_ig(1:nen); Neta_ig(1:nen)]*Xe;
%     J = det(Jacob); 
%     
%     area = area + J*wgp(ig);
% end
% 
% area



