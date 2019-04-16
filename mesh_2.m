%This is for our circle

function [NL, EL] = mesh_2(d1,d2,p,m, R)

%previously q was the corners of our domain
%now we use q to fix the circle (which is in the middle)
q = [0.5-d1/2 0.5-d2/2; 0.5+d1/2 0.5-d2/2; 0.5-d1/2 0.5+d2/2; 0.5+d1/2 0.5+d2/2];

PD = 2;

NoN = 2*(p+1)*(m+1) + 2*(p-1)*(m+1);
NoE = 4*p*m;
NPE = 4;

% Nodes
NL = zeros(NoN, PD);

a = (q(2,1) - q(1,1))/p;
b = (q(3,2) - q(1,2))/p;

%Region 1
coor11 = zeros((p+1)*(m+1), PD);

%The flat part of region 1 at the bottom
for i = 1:p+1
    coor11(i, 1) = q(1,1) + (i-1)*a;
    coor11(i, 2) = q(1,2);
end

%the innermost curved part of region 1 at the top
for i = 1:p+1
    coor11(m*(p+1) + i, 1) = R*cos( (5*pi/4) + (i-1)*(pi/2)/p ) + 0.5;
    coor11(m*(p+1) + i, 2) = R*sin( (5*pi/4) + (i-1)*(pi/2)/p ) + 0.5;
end

%everything else in between
for i = 1:m-1
    for j = 1:p+1
        
        x = (coor11(m*(p+1) + j, 1) - coor11(j, 1))/m;
        y = (coor11(m*(p+1) + j, 2) - coor11(j, 2))/m;
        
        coor11(i*(p+1)+j, 1) = coor11((i-1)*(p+1)+j, 1) + x;
        coor11(i*(p+1)+j, 2) = coor11((i-1)*(p+1)+j, 2) + y;
    end
end


%Region 2
coor22 = zeros((p+1)*(m+1), PD);

%The flat part of region 1 at the bottom
for i = 1:p+1
    coor22(i, 1) = q(3,1) + (i-1)*a;
    coor22(i, 2) = q(3,2);
end

%the innermost curved part of region 1 at the top
for i = 1:p+1
    coor22(m*(p+1) + i, 1) = R*cos( (3*pi/4) - (i-1)*(pi/2)/p ) + 0.5;
    coor22(m*(p+1) + i, 2) = R*sin( (3*pi/4) - (i-1)*(pi/2)/p ) + 0.5;
end

%everything else in between
for i = 1:m-1
    for j = 1:p+1
        
        x = (coor22(m*(p+1) + j, 1) - coor22(j, 1))/m;
        y = (coor22(m*(p+1) + j, 2) - coor22(j, 2))/m;
        
        coor22(i*(p+1)+j, 1) = coor22((i-1)*(p+1)+j, 1) + x;
        coor22(i*(p+1)+j, 2) = coor22((i-1)*(p+1)+j, 2) + y;
    end
end

%Region 3
coor33 = zeros((p-1)*(m+1), PD);

%The flat part of region 1 at the bottom
for i = 1:p-1
    coor33(i, 1) = q(1,1);
    coor33(i, 2) = q(1,2) + i*b;
end

%the innermost curved part of region 1 at the top
for i = 1:p-1
    coor33(m*(p-1) + i, 1) = R*cos( (5*pi/4) - (i)*(pi/2)/p ) + 0.5;
    coor33(m*(p-1) + i, 2) = R*sin( (5*pi/4) - (i)*(pi/2)/p ) + 0.5;
end

%everything else in between
for i = 1:m-1
    for j = 1:p-1
        
        x = (coor33(m*(p-1) + j, 1) - coor33(j, 1))/m;
        y = (coor33(m*(p-1) + j, 2) - coor33(j, 2))/m;
        
        coor33(i*(p-1)+j, 1) = coor33((i-1)*(p-1)+j, 1) + x;
        coor33(i*(p-1)+j, 2) = coor33((i-1)*(p-1)+j, 2) + y;
    end
end


%Region 4
coor44 = zeros((p-1)*(m+1), PD);

%The flat part of region 1 at the bottom
for i = 1:p-1
    coor44(i, 1) = q(2,1);
    coor44(i, 2) = q(2,2) + i*b;
end

%the innermost curved part of region 1 at the top
for i = 1:p-1
    coor44(m*(p-1) + i, 1) = R*cos( (7*pi/4) + (i)*(pi/2)/p ) + 0.5;
    coor44(m*(p-1) + i, 2) = R*sin( (7*pi/4) + (i)*(pi/2)/p ) + 0.5;
end

%everything else in between
for i = 1:m-1
    for j = 1:p-1
        
        x = (coor44(m*(p-1) + j, 1) - coor44(j, 1))/m;
        y = (coor44(m*(p-1) + j, 2) - coor44(j, 2))/m;
        
        coor44(i*(p-1)+j, 1) = coor44((i-1)*(p-1)+j, 1) + x;
        coor44(i*(p-1)+j, 2) = coor44((i-1)*(p-1)+j, 2) + y;
    end
end



%%%Now we store everything in a node list

%This is okay, but complicated to generate a element list
%NL = [coor11; coor22; coor33; coor44];

%We reorder it to make generating element list easier
for i = 1:m+1
    NL((i-1)*4*p+1:(i)*4*p, :) = [coor11((i-1)*(p+1)+1:(i)*(p+1),:);
                                  coor44((i-1)*(p-1)+1:(i)*(p-1),:);
                                  flipud(coor22((i-1)*(p+1)+1:(i)*(p+1),:));
                                  flipud(coor33((i-1)*(p-1)+1:(i)*(p-1),:))];
end



% Elements

EL = zeros(NoE,NPE);

%The strategy for naming here is:
%1. We go over each strip in the matrix
%2. Each block we have local node numbers that start and count
%counterclockwise (1, 2, 3, 4)
%3. We then assign global node numbers from counterclockwise of each strip
    %That is, if p = 4, and we have 4 regions, then the last node of the
    %strip has a global number of 16
%4. For the next strip, we start with the next number (Here it's 17)
    %That means that for the first block:
    %Local Node 1 = Global Node 1
    %Local Node 2 = Global Node 12
    %Local Node 3 = Global Node 17
    %Local Node 4 = Global Node 18
    

for i = 1:m
    for j = 1:4*p
        
        if (j == 1)
            EL((i-1)*(4*p) + j, 1) = (i-1)*4*p + 1;
            EL((i-1)*(4*p) + j, 4) = (i)*4*p + 1;
            EL((i-1)*(4*p) + j, 2) = EL((i-1)*(4*p) + j, 1) + 1;
            EL((i-1)*(4*p) + j, 3) = EL((i-1)*(4*p) + j, 4) + 1;
            
            
        elseif (j == 4*p)
            EL((i-1)*(4*p) + j, 1) = (i)*4*p;
            EL((i-1)*(4*p) + j, 4) = (i+1)*4*p;
            EL((i-1)*(4*p) + j, 2) = (i-1)*4*p + 1;
            EL((i-1)*(4*p) + j, 3) = (i)*4*p + 1;
            
        else
            EL((i-1)*(4*p)+j ,1) = EL((i-1)*(4*p)+j-1,2);
            EL((i-1)*(4*p)+j ,4) = EL((i-1)*(4*p)+j-1,3);
            EL((i-1)*(4*p)+j ,3) = EL((i-1)*(4*p)+j ,4) + 1;
            EL((i-1)*(4*p)+j ,2) = EL((i-1)*(4*p)+j ,1) + 1;
        
        
        
        
        
    end
end


end

