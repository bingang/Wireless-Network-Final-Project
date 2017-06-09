%輸入 
%     1. user位置(all_mobile_coordinate)
%     2. user數目(num_of_user)
%     3. 基地台到基地台之間的中心距離(inter_side_distance)
%     4. 最低速率(minSpeed)
%     5. 最高速率(maxSpeed)

%輸出 
%     1. user位置(all_mobile_coordinate)r
%說明
%    給定最高速和最低速，方向任意選擇使user移動
function all_mobile_coordinate = random_walk(num_of_user,inter_side_distance,all_mobile_coordinate,minSpeed,maxSpeed)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Construction of  random walk mobility model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
minSpeed = 0;           %m/s
maxSpeed = 15;          %m/s
A = inter_side_distance/2;
B = inter_side_distance/(sqrt(3)*2);
Speed_chosen = 1 + (maxSpeed - minSpeed)*rand(num_of_user,1);
    Direction_chosen = (2*pi)*rand(num_of_user,1);
    
    Amplitude = Speed_chosen;
    Angle = Direction_chosen;
    movement = [real(Amplitude.*exp(j*Angle)),imag(Amplitude.*exp(j*Angle))];
    all_mobile_coordinate(:,1:2) = movement + all_mobile_coordinate(:,1:2);
%%%%%%%%%%% tire 3 test if mobile run out of boundary %%%%%%%%%%%
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

    for i = 1:num_of_user 
        if all_mobile_coordinate(i,3) > 7 & all_mobile_coordinate(i,3) < 20
               if   any([ test_if_inside(center(1,:),inter_side_distance,all_mobile_coordinate(i,1:2))     test_if_inside(center(2,:),inter_side_distance,all_mobile_coordinate(i,1:2))   test_if_inside(center(3,:),inter_side_distance,all_mobile_coordinate(i,1:2)) ])
                    all_mobile_coordinate(i,1:2) = all_mobile_coordinate(i,1:2) - [15*B,-A]; 
                    if  test_if_inside(center(1,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 15;
                    elseif test_if_inside(center(2,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 14;
                    elseif test_if_inside(center(3,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 13;
                    end
               elseif any([test_if_inside(center(4,:),inter_side_distance,all_mobile_coordinate(i,1:2))   test_if_inside(center(5,:),inter_side_distance,all_mobile_coordinate(i,1:2))   test_if_inside(center(6,:),inter_side_distance,all_mobile_coordinate(i,1:2)) ]  )
                    all_mobile_coordinate(i,1:2) = all_mobile_coordinate(i,1:2) - [9*B,7*A]; 
                    if  test_if_inside(center(4,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 17;
                    elseif test_if_inside(center(5,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 16;
                    elseif test_if_inside(center(6,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 15;
                    end
               elseif any([test_if_inside(center(7,:),inter_side_distance,all_mobile_coordinate(i,1:2))   test_if_inside( center(8,:),inter_side_distance,all_mobile_coordinate(i,1:2))   test_if_inside(center(9,:),inter_side_distance,all_mobile_coordinate(i,1:2)) ]  )
                    all_mobile_coordinate(i,1:2) = all_mobile_coordinate(i,1:2) - [-6*B,8*A]; 
                    if  test_if_inside(center(7,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 19;
                    elseif test_if_inside(center(8,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 18;
                    elseif test_if_inside(center(9,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 17;
                    end
               elseif any([test_if_inside(center(10,:),inter_side_distance,all_mobile_coordinate(i,1:2))  test_if_inside(center(11,:),inter_side_distance,all_mobile_coordinate(i,1:2))  test_if_inside(center(12,:),inter_side_distance,all_mobile_coordinate(i,1:2)) ] )
                    all_mobile_coordinate(i,1:2) = all_mobile_coordinate(i,1:2) - [-15*B,A]; 
                    if  test_if_inside(center(10,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 9;
                    elseif test_if_inside(center(11,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 8;
                    elseif test_if_inside(center(12,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 19;
                    end
               elseif any([test_if_inside(center(13,:),inter_side_distance,all_mobile_coordinate(i,1:2))  test_if_inside(center(14,:),inter_side_distance,all_mobile_coordinate(i,1:2))  test_if_inside(center(15,:),inter_side_distance,all_mobile_coordinate(i,1:2)) ] )
                    all_mobile_coordinate(i,1:2) = all_mobile_coordinate(i,1:2) - [-9*B,-7*A]; 
                    if  test_if_inside(center(13,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 11;
                    elseif test_if_inside(center(14,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 10;
                    elseif test_if_inside(center(15,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 9;
                    end
               elseif any([ test_if_inside(center(16,:),inter_side_distance,all_mobile_coordinate(i,1:2))  test_if_inside(center(17,:),inter_side_distance,all_mobile_coordinate(i,1:2))  test_if_inside(center(18,:),inter_side_distance,all_mobile_coordinate(i,1:2)) ] )
                    all_mobile_coordinate(i,1:2) = all_mobile_coordinate(i,1:2) - [6*B,-8*A];   
                    if  test_if_inside(center(16,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 13;
                    elseif test_if_inside(center(17,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 12;
                    elseif test_if_inside(center(18,:),inter_side_distance,all_mobile_coordinate(i,1:2)) all_mobile_coordinate(i,3) = 11;
                    end
               else
                   
               end   
        end
    end
    
end  
