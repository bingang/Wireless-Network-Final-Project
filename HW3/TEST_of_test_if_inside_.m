%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Part 0 Construction of BS coordinate %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num_of_user = 10000;
inter_side_distance = 500
len_hex = inter_side_distance/sqrt(3);
num_first_tier = 6;
num_second_tier = 12;

angle = atan(sqrt(3)/3);
bs_coordinate = [0,0,1];

for i = 1:num_first_tier
 coordinate_of_each = [real(inter_side_distance*exp(j*angle)),imag(inter_side_distance*exp(j*angle)),i+1];
 bs_coordinate = [bs_coordinate;coordinate_of_each];
 angle = angle + (2*pi)/6;
end
angle = 0;
for i = 1:num_second_tier
    if rem(i,2) == 0
        coordinate_of_each = [real(inter_side_distance*2*exp(j*angle)),imag(inter_side_distance*2*exp(j*angle)),i + num_first_tier+1];
    elseif rem(i,2) == 1
        coordinate_of_each = [real(len_hex*3*exp(j*angle)),imag(len_hex*3*exp(j*angle)),i + num_first_tier+1];
    end
 bs_coordinate = [bs_coordinate;coordinate_of_each];
 angle = angle + (2*pi)/12;
end
num_of_bs = size(bs_coordinate);
 num_of_bs = num_of_bs(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Part 1 Construction of  moobile coordinate %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
location_at_bs = int16(1 + 18*rand(num_of_user,1));
location_at_bs = double(location_at_bs);
num_of_user_each_bs = 1;
all_mobile_coordinate = [];
for i = 1:num_of_user
    bs_index = location_at_bs(i);
    each_cell_mobile_coordinate = [gen_user_in_hexgaon(num_of_user_each_bs,bs_coordinate(bs_index,1:2),inter_side_distance),bs_index];
    all_mobile_coordinate = [all_mobile_coordinate ; each_cell_mobile_coordinate];
end
center = bs_coordinate(5,1:2);
for i = 1: num_of_user
 IN = test_if_inside(center,inter_side_distance,all_mobile_coordinate(i,1:2));
 all_mobile_coordinate(i,4) = IN;
end

X_mobile     = all_mobile_coordinate(:,1);
Y_mobile     = all_mobile_coordinate(:,2);
bs_of_mobile = all_mobile_coordinate(:,3);
in_of_mobile = all_mobile_coordinate(:,4);
bs_of_mobile = double(bs_of_mobile); 
color = [];
for i = 1 : num_of_user
    if all_mobile_coordinate(i,4) == 1
        color = [color;1 0 0];
    else
        color = [color;0 1 0];
    end
end
in_or_not
 gen_boundary_in_hexgaon(center,inter_side_distance)
 hold on;
 scatter(X_mobile,Y_mobile,50,color);
 hold on;
 
 
 
 title('Mobile Distribution');
 xlabel('X in meter');
 ylabel('Y in meter');