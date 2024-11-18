    function [ft_status, values] = usbio24_get_bits(handle, numbers);
% usbio24_get_bits
% Gets the value of several bits from a USBIO24 device.
%
% [ft_status, values] = usbio24_get_bits(handle, numbers)
%
% handle = Integer handle to the device
% numbers = Array of bit numbers that are requested
%           Max array length is 24.
%           Each element must be a number between 0 and 23.
% values = Array of values for the bits (0/1)
% ft_status = Integer status flag
%
% R. Gomez-Sjoberg 11/15/05
%
% Updates to use Matlab prototype file for compatibility with later versions 
% B Passarelli      8/6/08
nb = length(numbers);
if (nb <= 24) && (min(numbers) >= 0) && (max(numbers) <= 23)
    bits = [];
    for ii = 1:3
        % Send request for byte from each port
        buffer = uint8(96 + ii);
        num_bytes = 1;
        bufp = libpointer ('voidPtr', buffer);
        [ft_status, buffer, num_bytes] = calllib('ftd2xx', 'FT_Write', handle, bufp, num_bytes, num_bytes);
        if ~ft_status
            % Receive byte from the port
            buffer = uint8(0);
            num_bytes = 1;
            bufp = libpointer ('voidPtr', buffer);
            [ft_status, buffer, num_bytes] = calllib('ftd2xx', 'FT_Read', handle, bufp, num_bytes, num_bytes);
            if ~ft_status & (num_bytes == 1)
                % Get binary string and convert to numeric 0/1
                % Bits are in reverse order
                bb = uint8(dec2bin(buffer(1), 8)) - 48;
                bits = [bb bits];
            else
                break;
            end
        else
            break;
        end
    end
    if ~ft_status
        values = bits(24 - numbers);
    else
        values = [];
    end
else
    ft_status = 18;
    values = [];
end
