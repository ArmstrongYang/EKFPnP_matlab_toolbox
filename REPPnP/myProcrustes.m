%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This toolbox illustrates how to use the REPPnP and EPPnP 
% algorithms described in:
%
%       Luis Ferraz, Xavier Binefa, Francesc Moreno-Noguer.
%       Very Fast Solution to the PnP Problem with Algebraic Outlier Rejection. 
%       In Proceedings of CVPR, 2014. 
%
% Copyright (C) <2014>  <Luis Ferraz, Xavier Binefa, Francesc Moreno-Noguer>
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the version 3 of the GNU General Public License
% as published by the Free Software Foundation.
% 
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
% General Public License for more details.       
% You should have received a copy of the GNU General Public License
% along with this program. If not, see <http://www.gnu.org/licenses/>.
%
% Luis Ferraz, CMTech-UPF, June 2014.
% luisferrazc@gmail.com,http://cmtech.upf.edu/user/62
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [R, b, mc] = myProcrustes(X,Y)
%X is an structure containing points, points centered in the origin, points
%normalized
%Y are 3D points
    dims = size(Y,2);
    mY = mean(Y,2);
    cY = Y - mY * ones(1,dims);
    ncY = norm(cY(:));
    tcY = cY/ncY;
    
    A = X.nP * tcY';
    [L, D, M] = svd(A);
  
%     R = M * L';
%     
%     if(mY(3)>0 && det(R)<0)
        R = M * diag([1,1,sign(det(M*L'))])* L';
%   end
    
    b = sum(diag(D)) * X.norm/ncY;
    c = X.mP - b*R'*mY;
    mc = c * ones(1,dims);
end