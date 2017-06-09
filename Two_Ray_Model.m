% Unit of imput and output
% Gain_trans_ante,Gain_rece_ante all in "db"
% Height_base,Height_rece,Distance are all "in meter"
% Power_trans is in "dbm"
% output is in "db" 
function Power_rece = Two_Ray_Model(Power_trans,Gain_trans_ante,Gain_rece_ante,Height_base,Height_rece,Distance)
  Gain_Of_Channel = 10*log( (Height_base*Height_rece)/(Distance.^2));
  Power_rece = Power_trans + Gain_trans_ante + Gain_rece_ante + Gain_Of_Channel + 30;
end

function Power_rece = Log_Normal_Shadowing(mean,deviation,number_of_sample)
   Power_rece =  normrnd(mean,deviation,[1 number_of_sample]);
end