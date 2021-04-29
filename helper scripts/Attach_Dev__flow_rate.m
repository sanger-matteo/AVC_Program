%% Attachment device
% What is the Q (quantitative flow rate) necessary to use for a given
% growth chamber in order to obtain a specific flow velocity??? 
% We aim to have a flow velocity such that the cells are pushed down and 
% there is plenty of media recirculation and create a monolayer

u_avg = 1.2e-3 ;       % [m/s] , final aimd flow velocity in growth chamber
cmb_width = 1800 ;     % [um]
cmb_height = 20 ;      % [um]

% since u_avg = Q / Cross_section_area

Q = u_avg * (cmb_width * cmb_height * 10^-3)  % given in [ul/s]

