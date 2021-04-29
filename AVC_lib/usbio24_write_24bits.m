function [ft_status] = usbio24_write_24bits(handle, bits);
% usbio24_write_24bits
% Sets the value of all 24 bits on a USBIO24 device.

%% [ft_status] = usbio24_write_24bits(handle, port, bits)
%
% handle = Integer handle to the device
% bits = Array of 24 bit values (each element is 0/1)
%        First element is bit 0 of port A
% ft_status = Integer status flag
%
% R. Gomez-Sjoberg 7/14/05
%
% Updates to use Matlab prototype file for compatibility with later versions 
% B Passarelli      8/6/08

sb = size(bits);
if sb(2) == 1
    bits = bits';
    nb = sb(1);
else
    nb = sb(2);
end
if nb == 24
    value1 = bits(1:8) * [128; 64; 32; 16; 8; 4; 2; 1];
    value2 = bits(9:16) * [128; 64; 32; 16; 8; 4; 2; 1];
    value3 = bits(17:24) * [128; 64; 32; 16; 8; 4; 2; 1];
    buffer = uint8([65 value1 66 value2 67 value3]);
    num_bytes = 6;
    bufp = libpointer('voidPtr', buffer);
    [ft_status, bufp, num_bytes] = calllib('ftd2xx', 'FT_Write', handle, bufp, num_bytes, num_bytes);

else
    ft_status = 18;
end
