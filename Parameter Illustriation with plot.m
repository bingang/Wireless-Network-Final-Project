% Inital State without movement
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Parameter configuration %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num_of_user = 100;
inter_side_distance = 500;
simulation_time = 100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Construction of BS coordinate %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bs_coordinate = Construction_of_BS_coordinate(inter_side_distance);
num_of_bs = size(bs_coordinate,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Construction of  moobile coordinate %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mobile_coordinate = Construction_of_mobile_coordinate(num_of_user,bs_coordinate,inter_side_distance);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Needed Parameter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Power_Itself Power_Other SINR_Itself SINR_Other Interference_Itself] = Calculate_Power_and_SINR(mobile_coordinate,bs_coordinate);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 subplot(5,1,1)  
 plot(Power_Itself,'Marker','o')
 title('Power_Itself in db(tansmitted power is 33dbm, Gain of trans antenna = 14db, Gain of rece antenna = 14db)');
 subplot(5,1,2)  
 plot(Power_Other,'Marker','o')
 title('Power_Other in db(tansmitted power is 33dbm, Gain of trans antenna = 14db, Gain of rece antenna = 14db)');
 subplot(5,1,3)  
 plot(SINR_Itself,'Marker','o')
 title('SINR_Itself');
 subplot(5,1,4)  
 plot(SINR_Other,'Marker','o')
 title('SINR_Other');
 subplot(5,1,5)  
 plot(Interference_Itself,'Marker','o')
 title('Interference_Itself');
 
 
    
