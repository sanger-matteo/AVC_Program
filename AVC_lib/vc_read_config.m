function [vc] = vc_read_config(fname);
% vc_read_config
% Reads valve controller configuration from file on path fname
% Configuration file is a text file with a list of serial numbers
% Order of serial numbers in the file defines the valve numbering:
% 1st controller has valves 1 to 24, 2nd has 25 to 48, etc.
% After the serial number, the polarity of the valves should be specified
% The polarity is separated from the serial number by a TAB
% The polarity is specified by consecutive letters, one letter for each valve:
% o = Normally open, c = Normally closed
% i.e.
% ELCAEP93 <TAB> ccccccccooooooocoooooooo
% ELCAEPNL <TAB> oooooooooooooooooooooooo
%
% vc = vc_read_config(fname)
%
% fname = Full path of configuration file
% vc = Valve controller structure
%      vc.num = Number of controllers to use
%      vc.info(i).handle = Handle of ith controller
%      vc.info(i).sn = Serial number of ith controller
%      vc.info(i).status = Status of ith controller
% vc.info(i).polarity = Arrays with valve polarities of ith controller
%                       polarity(j) = 0 --> jth valve is normally open
%                       polarity(j) = 1 --> jth valve is normally closed
%
% R. Gomez-Sjoberg 7/18/05

if ~exist(fname, 'file')
    error(['Valve controller configuration file "' fname '" does not exist!']);
else
    [sernums pols] = textread(fname, '%s\t%s\n', ...
        'whitespace', '\r\n\t', 'commentstyle', 'matlab');
    num = length(sernums);
    if ~num
        error(['Valve controller configuration file is invalid!']);
    else
        vc.num = num;
        for ii = 1:num
            vc.info(ii).handle = 0;
            vc.info(ii).status = 0;
            vc.info(ii).sn = sernums{ii};
            vc.info(ii).polarity = ones(1, 24);
            pp = pols{ii};
            np = length(pp);
            if np ~= 3
                error('The polarity specification must be formed by three letters!');
            else
                xx = ones(1, 8);
                vc.info(ii).polarity(1:8) = xx.*(lower(pp(1)) == 'c');
                vc.info(ii).polarity(9:16) = xx.*(lower(pp(2)) == 'c');
                vc.info(ii).polarity(17:24) = xx.*(lower(pp(3)) == 'c');
            end
        end
    end
end
