function [ft_status, value] = usbio24_get_1bit(handle, number);
% usbio24_get_1bit
% Gets the value of one bit from a USBIO24 device.
%
% [ft_status, value] = usbio24_get_1bit(handle, number)
%
% handle = Integer handle to the device
% number = Number of bit that is requested
%          Must be a number between 0 and 23.
% value = Value for the bit (0/1)
% ft_status = Integer status flag
%
% R. Gomez-Sjoberg 12/22/05

if (number >= 0) && (number <= 23)
    % Compute port where bit is
    port = floor(number/8) + 1;
    % Convert to number within port
    number = mod(number, 8);
    % Send request for byte from that port
    buffer = uint8(96 + port);
    bufp = libpointer('voidPtr',buffer);
    num_bytes = 1;
    [ft_status, buffer, num_bytes] = calllib('ftd2xx', 'FT_Write', handle, bufp, num_bytes, num_bytes);
    if ~ft_status
        % Receive byte from the port
        buffer = uint8(0);
        num_bytes = 1;
         bufp = libpointer('voidPtr',buffer);
        [ft_status, buffer, num_bytes] = calllib('ftd2xx', 'FT_Read', handle, bufp, num_bytes, num_bytes);
        if ~ft_status & (num_bytes == 1)
            % Get binary string and convert to numeric 0/1;
            % (bits are in reverse order)
            bits = uint8(dec2bin(buffer(1), 8)) - 48;
        end
    end
    if ~ft_status
        value = bits(8 - number);
    else
        value = [];
    end
else
    ft_status = 18;
end
