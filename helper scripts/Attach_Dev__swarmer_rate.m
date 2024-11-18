%% Attachment device - Generation of swarmers
% How many new swarmer cells are generated at every given minute???
% Quite a trivial question necessary to design our device properly or we
% may end up with too few cells moving in the testing chambers.

G = 90 ;    % [min] , +- 10 min, generation of NA1000, with or without flow

S_free = 12e6 ;   % [um^2] , available glass surface for attachment of cells
height = 20 ;            % [um]

Surf_D = 0.15 ;                       % [#/um^2] , surface cell density, 0.0147 after 36 h
N_surf_chamber = S_free * Surf_D ;    % [cells/um^2] , number of cells attached to surface
N_swarm = N_surf_chamber / G ;        % number of new swarmer generated every min

D_swarmer = N_swarm / (S_free * height)           % [cell/um^3]

Vol_test_chamber = 300 * 300 * 20 ;    % [um^3]

D_swarmer * Vol_test_chamber 

