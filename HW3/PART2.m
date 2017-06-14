%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Construction of BS coordinate %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num_of_user = 100;
inter_side_distance = 500
len_hex = inter_side_distance/sqrt(3);
num_first_tier = 6;
num_second_tier = 12;

angle = atan(sqrt(3)/3);
bs_coordinate = [0,0,1];

for i = 1:num_first_tier
 coordinate_of_each = [real(inter_side_distance*exp(j*angle)),imag(inter_side_distance*exp(j*angle)),i+1];
 bs_coordinate = [bs_coordinate;coordinate_of_each];
 angle = angle + (2*pi)/num_first_tier;
end
angle = 0;
for i = 1:num_second_tier
    if rem(i,2) == 0
        coordinate_of_each = [real(inter_side_distance*2*exp(j*angle)),imag(inter_side_distance*2*exp(j*angle)),i + num_first_tier+1];
    elseif rem(i,2) == 1
        coordinate_of_each = [real(len_hex*3*exp(j*angle)),imag(len_hex*3*exp(j*angle)),i + num_first_tier+1];
    end
 bs_coordinate = [bs_coordinate;coordinate_of_each];
 angle = angle + (2*pi)/num_second_tier;
end
num_of_bs = size(bs_coordinate);
 num_of_bs = num_of_bs(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Construction of  moobile coordinate %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
location_at_bs = int16(1 + 18*rand(num_of_user,1));
location_at_bs = double(location_at_bs);
num_of_user_each_bs = 1;
all_mobile_coordinate = [];
for i = 1:num_of_user
    bs_index = location_at_bs(i);
    each_cell_mobile_coordinate = [gen_user_in_hexgaon(num_of_user_each_bs,bs_coordinate(bs_index,1:2),inter_side_distance),bs_index];
    all_mobile_coordinate = [all_mobile_coordinate ; each_cell_mobile_coordinate];
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Construction of  random walk mobility model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
minSpeed = 1;           %m/s
maxSpeed = 15;          %m/s
minT = 1;               %s
maxT = 6;               %s
simulation_time = 10    ;  %s
handover_list = [];
A = inter_side_distance/2;
B = inter_side_distance/(sqrt(3)*2);
exceed = 0;
%%%%%%%%%%% tire 3 %%%%%%%%%%%
    center = [];
    center = [center ;9*B -3*A ];
    center = [center ;9*B -1*A];
    center = [center ;9*B  1*A];
    center = [center ;9*B  3*A];
    center = [center ;6*B  4*A];
    center = [center ;3*B  5*A];
    center = [center ;0    6*A];
    center = [center ;-3*B  5*A];
    center = [center ;-6*B  4*A];
    center = [center ;-9*B 3*A];
    center = [center ;-9*B 1*A];
    center = [center ;-9*B -1*A];
    center = [center ;-9*B -3*A];
    center = [center ;-6*B -4*A];
    center = [center ;-3*B -5*A];
    center = [center ;0    -6*A];
    center = [center ;3*B  -5*A];
    center = [center ;6*B  -4*A];
%%%%%%%%%%% tire 3 %%%%%%%%%%%

for time = 1 : simulation_time
    if rem(time-1,maxT) == 0
        T_chosen = 1 + (maxT - minT)*rand(num_of_user,1);
        Speed_chosen = 1 + (maxSpeed - minSpeed)*rand(num_of_user,1);
        Direction_chosen = (2*pi)*rand(num_of_user,1);
    end
    
    Amplitude = logical(T_chosen).*Speed_chosen;
    Angle = Direction_chosen;
    movement = [real(Amplitude.*exp(j*Angle)),imag(Amplitude.*exp(j*Angle))];
    all_mobile_coordinate(:,1:2) = movement + all_mobile_coordinate(:,1:2);

    for i = 1:num_of_user 
        if all_mobile_coordinate(i,3) > 7 & all_mobile_coordinate(i,3) < 20
               if   any([ test_if_inside(center(1,:),inter_side_distance,all_mobile_coordinate(i,1:2))     test_if_inside(center(2,:),inter_side_distance,all_mobile_coordinate(i,1:2))   test_if_inside(center(3,:),inter_side_distance,all_mobile_coordinate(i,1:2)) ])
                    all_mobile_coordinate(i,1:2) = all_mobile_coordinate(i,1:2) - [15*B,-A]; exceed = exceed +1;
                    if  test_if_inside(center(1,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 15;
                    elseif test_if_inside(center(2,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 14;
                    elseif test_if_inside(center(3,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 13;
                    end
               elseif any([test_if_inside(center(4,:),inter_side_distance,all_mobile_coordinate(i,1:2))   test_if_inside(center(5,:),inter_side_distance,all_mobile_coordinate(i,1:2))   test_if_inside(center(6,:),inter_side_distance,all_mobile_coordinate(i,1:2)) ]  )
                    all_mobile_coordinate(i,1:2) = all_mobile_coordinate(i,1:2) - [9*B,7*A]; exceed = exceed +1;
                    if  test_if_inside(center(4,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 17;
                    elseif test_if_inside(center(5,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 16;
                    elseif test_if_inside(center(6,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 15;
                    end
               elseif any([test_if_inside(center(7,:),inter_side_distance,all_mobile_coordinate(i,1:2))   test_if_inside( center(8,:),inter_side_distance,all_mobile_coordinate(i,1:2))   test_if_inside(center(9,:),inter_side_distance,all_mobile_coordinate(i,1:2)) ]  )
                    all_mobile_coordinate(i,1:2) = all_mobile_coordinate(i,1:2) - [-6*B,8*A]; exceed = exceed +1;
                    if  test_if_inside(center(7,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 19;
                    elseif test_if_inside(center(8,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 18;
                    elseif test_if_inside(center(9,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 17;
                    end
               elseif any([test_if_inside(center(10,:),inter_side_distance,all_mobile_coordinate(i,1:2))  test_if_inside(center(11,:),inter_side_distance,all_mobile_coordinate(i,1:2))  test_if_inside(center(12,:),inter_side_distance,all_mobile_coordinate(i,1:2)) ] )
                    all_mobile_coordinate(i,1:2) = all_mobile_coordinate(i,1:2) - [-15*B,A]; exceed = exceed +1;
                    if  test_if_inside(center(10,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 9;
                    elseif test_if_inside(center(11,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 8;
                    elseif test_if_inside(center(12,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 19;
                    end
               elseif any([test_if_inside(center(13,:),inter_side_distance,all_mobile_coordinate(i,1:2))  test_if_inside(center(14,:),inter_side_distance,all_mobile_coordinate(i,1:2))  test_if_inside(center(15,:),inter_side_distance,all_mobile_coordinate(i,1:2)) ] )
                    all_mobile_coordinate(i,1:2) = all_mobile_coordinate(i,1:2) - [-9*B,-7*A]; exceed = exceed +1;
                    if  test_if_inside(center(13,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 11;
                    elseif test_if_inside(center(14,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 10;
                    elseif test_if_inside(center(15,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 9;
                    end
               elseif any([ test_if_inside(center(16,:),inter_side_distance,all_mobile_coordinate(i,1:2))  test_if_inside(center(17,:),inter_side_distance,all_mobile_coordinate(i,1:2))  test_if_inside(center(18,:),inter_side_distance,all_mobile_coordinate(i,1:2)) ] )
                    all_mobile_coordinate(i,1:2) = all_mobile_coordinate(i,1:2) - [6*B,-8*A];   exceed = exceed +1;
                    if  test_if_inside(center(16,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 13;
                    elseif test_if_inside(center(17,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 12;
                    elseif test_if_inside(center(18,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 11;
                    end
               else
                   
               end   
        end
    end
    for i = 1:num_of_user
        if T_chosen(i) > 1
            T_chosen(i) = T_chosen(i) - 1;
        else 
            T_chosen(i) = 0;
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Calculate Power(Uplink) and Distance %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Power_trans = 33;     %dBm
 Power_mobile = 23;    %dBm
 Gain_trans_ante = 14;
 Gain_rece_ante = 14;
 Height_base = 51.5;
 Height_rece = 1.5;
 
 mobile_coordinate_bs = all_mobile_coordinate(:,3);
 mobile_coordinate = all_mobile_coordinate(:,1:2);
 BS_coordinate = bs_coordinate(:,1:2);
 Power_of_bs_rece = [];
 dis = [];
 for mobile_index = 1 : num_of_user
     for bs_index = 1 : num_of_bs
        dis_vector = mobile_coordinate(mobile_index,:)- BS_coordinate( bs_index,: );
        distance = sqrt((dis_vector(1))^2+(dis_vector(2))^2);
        Power_rece =  Two_Ray_Model(Power_mobile,Gain_trans_ante,Gain_rece_ante,Height_base,Height_rece,distance);
        dis = [dis;distance];
        Power_of_bs_rece = [Power_of_bs_rece;Power_rece];
     end
 end  
 Power_of_bs_rece = power(10,Power_of_bs_rece/10);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Calculate Intereference %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Interference_of_bs_rece_from_other_mobile = [];
 for mobile_index = 1 : num_of_user
     for bs_index = 1 : num_of_bs
         Interference = 0;
         for i = 1 : num_of_bs  
            Interference = Interference + Power_of_bs_rece(bs_index + (i -1)*num_of_bs );
         end
         Interference = Interference - Power_of_bs_rece(bs_index + (mobile_index -1)*num_of_bs );
         Interference_of_bs_rece_from_other_mobile = [Interference_of_bs_rece_from_other_mobile;Interference];
     end
 end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Calculate SINR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Denominator_Of_SINR = []
bandwidth = 10* 10^6;   %Hz
temperature = 27;       %Celsius
Thermal_Noise =  physconst('Boltzmann') * (temperature+273) * bandwidth;
Denominator_Of_SINR = Interference_of_bs_rece_from_other_mobile + Thermal_Noise;
SINR = Power_of_bs_rece ./ Denominator_Of_SINR;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Handover %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
threshold = 100000;
TEMP = [];
for mobile_index = 1 : num_of_user  
   [M,I]    = max(SINR((mobile_index-1)*num_of_bs+1 : mobile_index*num_of_bs,:));
   Denominator =  SINR((mobile_index-1)*num_of_bs + all_mobile_coordinate(mobile_index,3));
   if M ~= Denominator
      ratio = ( M/Denominator )  ;
      if( ratio > threshold )
           handover_list = [handover_list;time all_mobile_coordinate(mobile_index,3) I];
           all_mobile_coordinate(mobile_index,3) = I;
      end
   end
end

end   %%%%%%%%%%%%%%%%%%% end of iteration %%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X_mobile     = all_mobile_coordinate(:,1);
Y_mobile     = all_mobile_coordinate(:,2);
bs_of_mobile = all_mobile_coordinate(:,3);
X_bs     = bs_coordinate(:,1);
Y_bs     = bs_coordinate(:,2);
index_bs = bs_coordinate(:,3);
color = zeros(num_of_user,3);
bs_of_mobile = double(bs_of_mobile); 

 background_color = 0.2;
 for i = 1 : num_of_user
     if rem(bs_of_mobile(i),3) == 0
         color(i,:) = [bs_of_mobile(i)/num_of_bs background_color  background_color ];
     elseif rem(bs_of_mobile(i),3) == 1
         color(i,:) = [background_color bs_of_mobile(i)/num_of_bs  background_color ];
     elseif rem(bs_of_mobile(i),3) == 2
         color(i,:) = [background_color background_color bs_of_mobile(i)/num_of_bs ];
     end
 end
 
 Power = [];
 for i = 1 : num_of_user
    Power = [Power ; Power_of_bs_rece( (i-1)*num_of_bs + all_mobile_coordinate(i,3)  )];
 end
 SINR_ = [];
 for i = 1 : num_of_user
    SINR_ = [SINR_ ; SINR( (i-1)*num_of_bs + all_mobile_coordinate(i,3)  )];
 end
 
 scatter(X_mobile,Y_mobile,50,color,'filled');
 hold on;
 BS_label_for_mobile    = num2str(bs_of_mobile);  BS_label_for_mobile = cellstr(BS_label_for_mobile); 
 Power_label_for_mobile = num2str(Power);  Power_label_for_mobile = cellstr(Power_label_for_mobile);
 SINR_label_for_mobile  = num2str(SINR_);  SINR_label_for_mobile = cellstr(SINR_label_for_mobile);
 
 label = strcat({'   '},BS_label_for_mobile);
 
 text(X_mobile,Y_mobile,label,'FontSize',7);
 hold on;
 scatter(X_bs,Y_bs,100,[0 0 0],'filled','diamond');
 hold on;
 BS_label= num2str(index_bs);  BS_label = cellstr(BS_label);

 for i = 1 : num_of_bs
     gen_boundary_in_hexgaon(bs_coordinate(i,1:2),inter_side_distance)
     hold on;
 end
%{
 for i = 1 : size(center,1)
     gen_boundary_in_hexgaon(center(i,1:2),inter_side_distance)
     hold on;
 end
 hold on;
 scatter(center(:,1),center(:,2));
%}
 text(X_bs, Y_bs, BS_label,'Color','black','FontSize',14) 
 title('Mobile Distribution');
 xlabel('X in meter');
 ylabel('Y in meter');


