function [fitVal,varargout] = fitnessfuctionforpso(xVec,params)
%template   Paper:findchirp
[nrows,~]=size(xVec);
fitVal = zeros(nrows,1);
validPts = ones(nrows,1);
%Check for out of bound coordinates and flag them
validPts = chkstdsrchrng(xVec);
fitVal(~validPts)=inf;
xVec(validPts,:) = s2rvector(xVec(validPts,:),params);
%在这里加入各常数

ybar = params.Data;
Sn = params.Sn;
%Fs = params.Fs;
tbar = params.t;
D11 = params.D11;
D22 = params.D22;
D33 = params.D33;
D12 = params.D12;
D13 = params.D13;
D23 = params.D23;


for lpc = 1:nrows
    if validPts(lpc)
    % Only the body of this block should be replaced for different fitness
    % functions
        x = xVec(lpc,:);

w0 = x(1);
alpha = x(2);
delta = x(3);

F_out = fitnessfunction(ybar,w0,alpha,delta,tbar,Sn,D11,D22,D33,D12,D13,D23);

fitVal(lpc) = -F_out;%min->max
    end
end
%Return real coordinates if requested
if nargout > 1
    varargout{1}=xVec;
    if nargout > 2
            varargout{2} = r2svector(xVec,params);
    end
end

function rVec = s2rvector(xVec,params)
%Convert standardized coordinates to real using non-uniform range limits
%R = S2RSCALAR(X,P)
%Takes standardized coordinates in X (coordinates of one point per row) and
%returns real coordinates in R using the range limits defined in P.rmin and
%P.rmax. The range limits can be different for different dimensions. (If
%they are same for all dimensions, use S2RSCALAR instead.)

%Soumya D. Mohanty
%April 2012

[nrows,ncols] = size(xVec);
rVec = zeros(nrows,ncols);
rmin = params.rmin;
rmax = params.rmax;
rngVec = rmax-rmin;
for lp = 1:nrows
    rVec(lp,:) = xVec(lp,:).*rngVec+rmin;
end

function xVec = r2svector(rVec,params)
%Convert real coordinates to standardized ones.
%X = R2SVECTOR(R,P)
%Takes standardized coordinates in X (coordinates of one point per row) and
%returns real coordinates in R using the range limits defined in P.rmin and
%P.rmax. The range limits can be different for different dimensions. (If
%they are same for all dimensions, use S2RSCALAR instead.)

%Soumya D. Mohanty
%May 2016
[nrows,ncols] = size(rVec);
xVec = zeros(nrows,ncols);
rmin = params.rmin;
rmax = params.rmax;
rngVec = rmax-rmin;
for lp = 1:nrows
    xVec(lp,:) = (rVec(lp,:)-rmin)./rngVec;
end

function rVec = s2rscalar(xVec,rngMin,rngMax)
%Convert standardized coordinates to real using uniform range limits
%R = S2RSCALAR(X,R1,R2)
%Takes standardized coordinates in X (coordinates of one point per row) and
%returns real coordinates in R using the range limits R1 < R2.

%Soumya D. Mohanty
%April 2012

%Number of rows = number of points
%Number of columns = number of dimensions
[nrows,ncols]=size(xVec);
%Storage for real coordinates
rVec = zeros(nrows,ncols);
%Range for each coordinate dimension is the same
rmin = rngMin*ones(1,ncols);
rmax = rngMax*ones(1,ncols);
rngVec = rmax-rmin;
%Apply range to standardized coordinates and convert to real coordinates
for lp = 1:nrows
    rVec(lp,:) = xVec(lp,:).*rngVec+rmin;
end

function xVec = r2sscalar(rVec,rngMin,rngMax)
%Convert real coordinates to standardized ones using uniform range limits
%R = R2SSCALAR(X,R1,R2)
%Takes standardized coordinates in X (coordinates of one point per row) and
%returns real coordinates in R using the range limits R1 < R2.

%Soumya D. Mohanty
%May 2016

%Number of rows = number of points
%Number of columns = number of dimensions
[nrows,ncols]=size(rVec);
%Storage for real coordinates
xVec = zeros(nrows,ncols);
%Range for each coordinate dimension is the same
rmin = rngMin*ones(1,ncols);
rmax = rngMax*ones(1,ncols);
rngVec = rmax-rmin;
%Apply range to standardized coordinates and convert to real coordinates
for lp = 1:nrows
    xVec(lp,:) = (rVec(lp,:)-rmin)./rngVec;
end

