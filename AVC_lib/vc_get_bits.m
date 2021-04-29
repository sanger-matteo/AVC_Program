function [vc_out, values] = vc_get_bits(vc_in, numbers, pol);
% vc_get_bits
% Get the value of one or several bits from a valve controller
%
% [vc_out, values] = vc_get_bits(vc_in, numbers, [pol])
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
% R. Gomez-Sjoberg 11/15/05

vc_out = vc_in;

if nargin == 2
    pol = 0;
end
    
cn = floor(numbers(1)/24) + 1;
if (cn <= vc_in.num) & (cn > 0)
    numbers = mod(numbers, 24*(cn - 1));
    [vc_out.info(cn).status, v] = usbio24_get_bits(vc_in.info(cn).handle, numbers);
    if ~vc_out.info(cn).status
        if pol
            values = v;
        else
        	values = ~xor(v, vc_in.info(cn).polarity(numbers + 1));
        end
    else
        values = [];
    end
else
    values = [];
end
