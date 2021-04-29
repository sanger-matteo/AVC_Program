function [ft_status] = usbio24_set_bits(handle, numbers, values);
% usbio24_set_bits
% Sets the value of sveral bits on a USBIO24 device.
%
% [ft_status] = usbio24_set_bits(handle, numbers, values)
%
% handle = Integer handle to the device
% numbers = Arrays of bit numbers
%           Max array length is 24.
%           Each element must be a number between 0 and 23.
% values = Array of values for the bits (0/1)
% ft_status = Integer status flag
%
% R. Gomez-Sjoberg 7/14/05
%
% Updates to use Matlab prototype file for compatibility with later versions 
% B Passarelli      8/6/08
nb = length(numbers);
if (nb <= 24) && (min(numbers) >= 0) && (max(numbers) <= 23)
    buffer = uint8([]);
    for ii = 1:nb
        if values(ii)
            vs = uint8('H');
        else
            vs = uint8('L');
        end
        buffer = [buffer vs uint8(numbers(ii))];
    end
    num_bytes = length(buffer);
    bufp = libpointer('voidPtr', [buffer 0]);
    char(bufp.Value);
    
    [ft_status, bufp, num_bytes] = calllib('ftd2xx', 'FT_Write', handle, bufp, num_bytes, num_bytes);

else
    ft_status = 18;
end
