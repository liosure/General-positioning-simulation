function W = Zeroforcing(CHL, ~)
    H_pseudo_inv = pinv(CHL);
    norms = sqrt(sum(abs(H_pseudo_inv).^2, 1));
    W = H_pseudo_inv ./ norms;
end