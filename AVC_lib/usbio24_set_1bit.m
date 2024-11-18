function [ft_status] = usbio24_set_1bit(handle, number, value);
% usbio24_set_1bit
% Sets the value of one bit on the USBIO24 device.

%% [ft_status] = usbio24_set_1bit(handle, number, value)
%
% handle = Integer handle to the device
% number = Bit number (0 to 23)
% value = Value of the bit (0/1)
% ft_status = Integer status flag
%
% R. Gomez-SJoberg 7/14/05
%
% Updates to use Matlab prototype file for compatibility with later versions 
% B Passarelli      8/6/08

if (number >= 0) && (number <= 23)
    if value
        buffer = uint8('H');
    else
        buffer = uint8('L');
    end
    buffer = [buffer uint8(number)];
    bufp = libpointer ('voidPtr', buffer);
    num_bytes = 2;
    [ft_status, bufp, num_bytes] = calllib('ftd2xx', 'FT_Write', handle, bufp, 2, num_bytes);
else
    ft_status = 18;
end
