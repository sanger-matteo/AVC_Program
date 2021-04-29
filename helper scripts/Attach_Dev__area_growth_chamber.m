Helper scriptsc1 = 1800 ;
c2 = 6900 ;

l1 = 30 ;
l2 = 100 ;

h = 20 ; 
N = 11 * 30 ;

S_pillar = 2* (l1 + l2) * h ; 

S_free_chamber = (c1 * c2) + 2* (c1 + c2) * h  

S_available = S_free_chamber + S_pillar - 2*N * (l1*l2) 

Delta = S_free_chamber - S_available


