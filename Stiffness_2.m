function output = Stiffness_test(x, GPE)

   
    
    conductivity = 1;
    
    %Distinguish if it's a TR or QU element
    NPE = size(x, 1);
    
    %PD
    PD = size(x, 2);
    
    %Transpose our element matrix coordinates (for reasons?)
    coor = x';
    
    k = zeros(NPE, NPE);
    
   
    K = 0; %big K
    
    for gp = 1:GPE
        
        J = zeros(PD, PD);
        grad = zeros(PD, NPE);
        
        [xi, eta, alpha] = GaussPoint(NPE, GPE, gp);
        
        grad_nat = grad_N_nat(NPE, xi, eta);
        
        J = coor * grad_nat'; %we take transpose of grad_nat
        
        grad = inv(J)' * grad_nat;
        %                 for n = 1:NPE
        %                     grad(:, n) = grad(:, n) + inv(J)' * grad_nat(:, n);
        %                 end
        
        %                 for b = 1:PD
        %                     K = K + (-conductivity) * grad(b, i) * grad(b, j) * det(J) * alpha;
        %                 end
        
        
    end
    
    for i = 1:NPE
        for j = 1: NPE
            k(i, j) = k(i, j) + (-conductivity)* dot(grad(:, i),grad(:, j)) * det(J) * alpha;
        end
    end
    
            
    output = k;
    
        


end

function result = grad_N_nat(NPE, xi, eta)

    PD = 2;
    result = zeros(PD, NPE);
    
    if(NPE == 3)
        
        %fill in 'result' matrix with derivative values
        result(1, 1) = 1;
        result(1, 3) = -1;
        result(2, 2) = 1;
        result(2, 3) = -1;
        
    elseif(NPE == 4)
        
        result(1, 1) = -1/4 * (1-eta);
        result(1, 2) = 1/4 * (1-eta);
        result(1, 3) = 1/4 * (1+eta);
        result(1, 4) = -1/4 * (1+eta);
        
        result(2, 1) = -1/4 * (1-xi);
        result(2, 2) = -1/4 * (1+xi);
        result(2, 3) = 1/4 * (1+xi);
        result(2, 4) = 1/4 * (1-xi);
    end
end
        

function [xi, eta, alpha] = GaussPoint(NPE, GPE, gp)
    
    if(NPE == 3) %if it's a 3 noded TR element
        xi = 1/3; eta = 1/3; alpha = 1 * 1/2; %we only need 1 GP, we multiply alpha by 1/2 so we dont have to do it later
    elseif(NPE == 4) %if it's a 4-node QU element
        % we have 2 options for QU element, 1 or 4 GP
        if(GPE == 1)
            xi = 0; eta = 0; alpha = 4;
        elseif(GPE == 4)
            switch gp
                case 1
                    xi = -1/sqrt(3); eta = -1/sqrt(3); alpha = 1;
                case 2
                    xi = 1/sqrt(3); eta = -1/sqrt(3); alpha = 1;
                case 3
                    xi = 1/sqrt(3); eta = 1/sqrt(3); alpha = 1;
                case 4
                    xi = -1/sqrt(3); eta = 1/sqrt(3); alpha = 1;
            end
        end
    end 
end
