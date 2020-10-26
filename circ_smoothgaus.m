function [rout,tout] = circ_smoothgaus(r,theta,varargin)

ip = inputParser;
addParameter(ip, 'NumAngles', 200);
addParameter(ip, 'GausWidth', deg2rad(10));
parse(ip, varargin{:});

tout = reshape(linspace(-1*pi,pi+0.1,ip.Results.NumAngles),[],1);

rout = zeros(ip.Results.NumAngles,1);

r = reshape(r, [], 1);

% loop through t
for kk = 1:ip.Results.NumAngles
  % realign current phase to zero
  theta_shift = mod(theta - tout(kk) + pi, 2*pi) - pi;
  
  % compute gaussian weighting for all angles
  gaus = reshape(normpdf(theta_shift, 0, ip.Results.GausWidth), [], 1);

  % compute weighted mean
  rout(kk) = sum(r.*gaus) ./ sum(gaus);
end

end