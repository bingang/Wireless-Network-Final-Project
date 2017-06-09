%輸入 
%     1. user位置(all_mobile_coordinate)
%     2. 基地台位置(bs_coordinate)
%輸出 
%     1. Power
%       矩陣大小為 num_of_user * 1
%       單位為 焦耳
%     2. SINR
%       矩陣大小為 num_of_user * 1
function [Power SINR] = Calculate_Power_and_SINR(all_mobile_coordinate,bs_coordinate)
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Calculate Power %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Power_trans = 33;     %dBm
 Power_mobile = 0;     %dBm
 Gain_trans_ante = 14;
 Gain_rece_ante = 14;
 Height_base = 51.5;
 Height_rece = 1.5;
 center = [0,0];
 mobile_coordinate_bs = all_mobile_coordinate(:,3);
 mobile_coordinate = all_mobile_coordinate(:,1:2);
 BS_coordinate = bs_coordinate(:,1:2);
 Power_of_bs_rece = [];
 dis = [];
 num_of_user = size(all_mobile_coordinate,1);
 num_of_bs = size(BS_coordinate,1);
 
 for mobile_index = 1 : num_of_user
     for bs_index = 1 : num_of_bs
        dis_vector = mobile_coordinate(mobile_index,:)- BS_coordinate( bs_index,: );
        distance = sqrt((dis_vector(1))^2+(dis_vector(2))^2);
        Power_rece =  Two_Ray_Model(Power_trans,Gain_trans_ante,Gain_rece_ante,Height_base,Height_rece,distance);
        dis = [dis;distance];
        Power_of_bs_rece = [Power_of_bs_rece;Power_rece];
     end
 end  
 Power_of_bs_rece = power(10,Power_of_bs_rece/10);
 Power = [];
 for mobile_index = 1 : num_of_user
    Power = [Power ; Power_of_bs_rece(1 + (mobile_index -1)*num_of_bs);]
 end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Calculate Intereference %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Interference_of_ms_rece_from_other_bs = [];
 for mobile_index = 1 : num_of_user
     Interference = 0;
     for i = 1 : num_of_bs  
          Interference = Interference + Power_of_bs_rece(i+ (mobile_index-1)*num_of_bs );
     end
         Interference = Interference - Power_of_bs_rece(1 + (mobile_index -1)*num_of_bs );
     Interference_of_ms_rece_from_other_bs = [Interference_of_ms_rece_from_other_bs;Interference];
 end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Calculate SINR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Denominator_Of_SINR = []
bandwidth = 10* 10^6;   %Hz
temperature = 27;       %Celsius
Thermal_Noise =  physconst('Boltzmann') * (temperature+273) * bandwidth;
Denominator_Of_SINR = Interference_of_ms_rece_from_other_bs + Thermal_Noise;
SINR = Power ./ Denominator_Of_SINR;
end