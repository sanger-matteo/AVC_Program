function [vc_out] = vc_set_1bit(vc_in, number, value, pol);
% vc_set_1bit
% Set the value of one bit on the valve controllers
%
% [vc_out] = vc_set_1bit(vc_in, number, value, [pol])
%
% vc.num = Number of controllers to use
% vc.info(i).handle = Handle of ith controller
% vc.info(i).sn = Serial number of ith controller
% vc.info(i).status = Status of ith controller
% vc.info(i).polarity = Arrays with valve polarities of ith controller
%                       polarity(j) = 0 --> jth valve is normally open
%                       polarity(j) = 1 --> jth valve is normally closed
% number = Number of the valve to be set
% value = Value for the valve (0/1)
% pol = Optional argument.
%       If pol==1, values reflect the true state of the control line
%       independently of the manifold polarity
%
% R. Gomez-Sjoberg 12/22/05

vc_out = vc_in;

if nargin == 3
    pol = 0;
end

cn = floor(number/24) + 1;
if cn <= vc_in.num
    number = mod(number, 24*(cn - 1));
    if ~pol && ~vc_in.info(cn).polarity(number + 1)
        value = uint8(~value);
    end
    vc_out.info(cn).status = usbio24_set_1bit(vc_in.info(cn).handle, number, value);
end
