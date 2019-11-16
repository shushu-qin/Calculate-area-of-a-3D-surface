function [connectivity coord] = readData(filename,nen)
%==========================================================================
% Data input phase. Read information from data file
%==========================================================================
fileID = fopen(filename, 'r');

%--------------------------------------------------------------------------
% Read nodes information
%-------------------------------------------------------------------------- 
while ~feof(fileID)   % find the wanted output section first...
    if strfind(fgetl(fileID),'Connectivity')
        fprintf('Find connectivity table\n');
        break;
    end  
end
% Total number of elements in the mesh
nOfElements = fscanf(fileID, '%d', 1);

%--------------------------------------------------------------------------
% Read element information
%--------------------------------------------------------------------------
% Table of connectivities 
connectivity = fscanf(fileID, '\n%d %d %d %d %d %d %d %d %d', [nen,nOfElements]);
connectivity = connectivity';

%--------------------------------------------------------------------------
% Read nodal coordinates
%--------------------------------------------------------------------------
nOfNodes = fscanf(fileID, '\nCoordinate table\n%d', 1);
coord = fscanf(fileID, '\n%f %f %f', [3, nOfNodes]);
coord = coord';

