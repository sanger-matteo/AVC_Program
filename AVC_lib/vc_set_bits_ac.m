function [vc_out] = vc_set_bits_ac(vc_in, numbers, values, pol);
% vc_set_bits_ac
% Set the value of one or several bits on the valve controllers
% Bits can be on any and all controllers
%
% [vc_out] = vc_set_bits_ac(vc_in, numbers, values, [pol])
%
% vc.num = Number of controllers to use
% vc.info(i).handle = Handle of ith controller
% vc.info(i).sn = Serial number of ith controller
% vc.info(i).status = Status of ith controller
% vc.info(i).polarity = Arrays with valve polarities of ith controller
%                       polarity(j) = 0 --> jth valve is normally open
%                       polarity(j) = 1 --> jth valve is normally closed
% numbers = Array of valve numbers (numbers start at 0)
% values = Array of valve values
% pol = Optional argument.
%       If pol==1, values reflect the true states of the control lines
%       independently of the manifold polarity
%
% R. Gomez-Sjoberg 12/22/05

vc_out = vc_in;

if nargin == 3
    pol = 0;
end

% Compute controller numbers for each valve number
cns = floor(numbers/24) + 1;
controllers = unique(cns);
% Actuate valves on each controller
for cn = controllers
    if (cn <= vc_in.num) & (cn > 0)
        idx = find(cns == cn);
        vn = numbers(idx);
        vv = values(idx);
        vn = mod(vn, 24*(cn - 1));
        if ~pol
            vv = ~xor(vv, vc_in.info(cn).polarity(vn + 1));
        end
        vc_out.info(cn).status = usbio24_set_bits(vc_in.info(cn).handle, vn, vv);
    end
end
