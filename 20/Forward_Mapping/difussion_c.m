function D2_c = difussion_c(c)

    % Memory
    D2_c = c; 
    % Left side
    D2_c(1,:) = c(2,:)- c(1,:);
    % Interior
    D2_c(2:end-1,:) = c(3:end,:) - 2*c(2:end-1,:) + c(1:end - 2,:);
    % Right side
    D2_c(end,:) = c(end-1,:)- c(end,:);

end
