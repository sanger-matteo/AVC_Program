function [vc_out] = vc_set_bits(vc_in, numbers, values, pol);
% vc_set_bits
% Set the value of one or several bits on the valve controllers
%
% [vc_out] = vc_set_bits(vc_in, numbers, values, [pol])
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
% IMPORTANT: All valve numbers must be on the same controller.
%            The controller is chosen based on the 1st valve number
%
% R. Gomez-Sjoberg 7/14/05

vc_out = vc_in;

if nargin == 3
    pol = 0;
end
    
% Compute controller number from 1st valve number
cn = floor(numbers(1)/24) + 1;
if (cn <= vc_in.num) & (cn > 0)
    numbers = mod(numbers, 24*(cn - 1));
    if ~pol
        values = ~xor(values, vc_in.info(cn).polarity(numbers + 1));
    end
    vc_out.info(cn).status = usbio24_set_bits(vc_in.info(cn).handle, numbers, values);
end
