% Detector tensor D depends on arm vector :  n1,n2,n3
% TDI works here
% e.g.   D_1 = kron(n1,n1)-kron(n2,n2); D_2 = kron(n1,n1)+kron(n2,n3)-kron(n3,n3);

%the contraction of detector tensor and polarization tensor is detentor
% response
function [D_plus,D_cross] = Dectector_tensor(n1,n2,n3)

% TDI for 2 arms 
D_plus =  (n1')*n1 - (n2')*n2;  
D_cross = (n1')*n1 - (n2')*n2;  


%D = kron(n1',n1)+kron(n2',n2)-kron(n3',n3);  % 3 arms

% D_plus, D_cross 
end
