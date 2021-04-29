function [vc_out] = vc_set_bits(vc_in, bits);
% vc_set_bits
% Set the value of several bits on the valve controllers
%
% [vc_out] = vc_set_bits(vc_in, bits)
%
% vc.num = Number of controllers to use
% vc.info(i).handle = Handle of ith controller
% vc.info(i).sn = Serial number of ith controller
% vc.info(i).status = Status of ith controller
% vc.info(i).polarity = Arrays with manifold polarities of ith controller
%                       polarity(j) = 0 --> jth manifold is normally open
%                       polarity(j) = 1 --> jth manifold is normally closed
% bits(i).num = Number of valve assigned to ith bit
% bits(i).value = Value of ith bit (0/1)
%
% R. Gomez-Sjoberg 7/14/05

vc_out = vc_in;

nb = length(bits);
% cn = floor(bits(1).num/24) + 1;
% if cn <= vc_in.num
%     for ii = 1:nb
        
for ii = 1:nb
    vc_out = vc_set_1bit(vc_in, bits(ii));
end
