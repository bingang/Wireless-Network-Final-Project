%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Parameter configuration %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num_of_user = 100;
inter_side_distance = 500;
simulation_time = 50;
minSpeed = 0;
maxSpeed = 15;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Construction of BS coordinate %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bs_coordinate = Construction_of_BS_coordinate(inter_side_distance);
num_of_bs = size(bs_coordinate,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Construction of  moobile coordinate %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mobile_coordinate = Construction_of_mobile_coordinate(num_of_user,bs_coordinate,inter_side_distance);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Show_Background(Base Station) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nothing = Show_Background(bs_coordinate,inter_side_distance);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  mobile move %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for time = 1: simulation_time
  mobile_coordinate = random_walk(num_of_user,inter_side_distance,mobile_coordinate,minSpeed,maxSpeed);
   [Power SINR] = Calculate_Power_and_SINR(mobile_coordinate,bs_coordinate);
   % Handoff  mechanism HERE!!!!!!!!!!!!!!!!!!!
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  show final position %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   nothing = Show_Mobile_Movement(mobile_coordinate,num_of_bs);

