function [ft_status] = usbio24_write_1port(handle, port, bits);
% usbio24_write_1port
% Sets the value of all 8 bits on a port on a USBIO24 device.

%% [ft_status] = usbio24_write_1port(handle, port, bits)
%
% handle = Integer handle to the device
% port = Port number (0 = A, 1 = B, 2 = C)
% bits = Array of 8 bit values (each element is 0/1)
%        First element is the least significant value bit
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
if (port >= 0) && (port <= 2) && (nb == 8)
    value = bits * [1; 2; 4; 8; 16; 32; 64; 128];
    buffer = uint8([(65 + port) value 0]);
    num_bytes = 3;
    bufp = libpointer ('voidPtr', buffer);
    [ft_status, buffer, num_bytes] = calllib('ftd2xx', 'FT_Write', handle, bufp, num_bytes, num_bytes);
else
    ft_status = 18;
end
