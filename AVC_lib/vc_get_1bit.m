function [vc_out, value] = vc_get_1bit(vc_in, number, pol);
% vc_get_1bit
% Get the value of one bit from a valve controller
%
% [vc_out, value] = vc_get_1bit(vc_in, number, [pol])
%
% vc.num = Number of controllers to use
% vc.info(i).handle = Handle of ith controller
% vc.info(i).sn = Serial number of ith controller
% vc.info(i).status = Status of ith controller
% vc.info(i).polarity = Arrays with valve polarities of ith controller
%                       polarity(j) = 0 --> jth valve is normally open
%                       polarity(j) = 1 --> jth valve is normally closed
% number = Valve numbers (numbers start at 0)
% value = Valve value (0/1)
% pol = Optional argument.
%       If pol==1, values reflect the true states of the control lines
%       independently of the manifold polarity
%
% R. Gomez-Sjoberg 12/22/05

vc_out = vc_in;

if nargin == 2
    pol = 0;
end

cn = floor(number/24) + 1;
if (cn <= vc_in.num) & (cn > 0)
    number = mod(number, 24*(cn - 1));
    [vc_out.info(cn).status, value] = usbio24_get_1bit(vc_in.info(cn).handle, number);
    if ~vc_out.info(cn).status
        if ~pol && ~vc_in.info(cn).polarity(number + 1)
            value = uint8(~value);
        end
    else
        value = [];
    end
end
