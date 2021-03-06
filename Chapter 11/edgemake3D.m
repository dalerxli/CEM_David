function edgemake3D
% EDGEMAKE Make edges on mesh.
% Element 1 first:
global ELEMENTS ELEMENT_EDGES NUM_ELEMENTS EDGES NUM_EDGES LOCALEDGENODES
EDGES(1,:) = [ELEMENTS(1,1),ELEMENTS(1,2)];
EDGES(2,:) = [ELEMENTS(1,1),ELEMENTS(1,3)];
EDGES(3,:) = [ELEMENTS(1,1),ELEMENTS(1,4)];
EDGES(4,:) = [ELEMENTS(1,2),ELEMENTS(1,3)];
EDGES(5,:) = [ELEMENTS(1,2),ELEMENTS(1,4)];
EDGES(6,:) = [ELEMENTS(1,3),ELEMENTS(1,4)];
ELEMENT_EDGES(1,1) = 1;
ELEMENT_EDGES(1,2) = 2;
ELEMENT_EDGES(1,3) = 3;
ELEMENT_EDGES(1,4) = 4;
ELEMENT_EDGES(1,5) = 5;
ELEMENT_EDGES(1,6) = 6;
% Now other elements
edge_counter = 6;
for ielem = 2:NUM_ELEMENTS
   for jedge = 1:6 % a tet has six edges
     TEMPEDGES(1,:) = [ELEMENTS(ielem,LOCALEDGENODES(jedge,1)),ELEMENTS(ielem,LOCALEDGENODES(jedge,2))];
     new_edge = 1; % Default: true. Re-set for each edge.
     % Now test if this edge has already been assigned
     for kedge = 1:edge_counter
       if (TEMPEDGES(1,:) == EDGES(kedge,:)) 
         new_edge = 0;
         ELEMENT_EDGES(ielem,jedge) = kedge;
         break;
       end
     end
     if new_edge 
       edge_counter = edge_counter+1;
       EDGES(edge_counter,:) = TEMPEDGES(1,:);
       ELEMENT_EDGES(ielem,jedge) = edge_counter;
     end
   end
end
NUM_EDGES = edge_counter;
