function [output_t,output_x]=summing_functions(input_t1,input_x1,input_t2,input_x2)

%% Check & Define time interval
[time_interval,~]=Check_and_Define_time_interval(input_t1,input_t2);

%% HSB and LSB of both input signals
input_t1_HSB=input_t1(length(input_t1));
input_t1_LSB=input_t1(1);
input_t2_HSB=input_t2(length(input_t2));
input_t2_LSB=input_t2(1);

%% Different point to sum
if (input_t1_HSB) == (input_t2_HSB)
    if (input_t1_LSB) == (input_t2_LSB)
        output_t=input_t1;
        output_x=input_x1+input_x2;
    elseif (input_t1_LSB) < (input_t2_LSB)
        output_t=input_t1;
        offset_amount=offset_amount_calculate(input_t2_LSB,input_t1_LSB,time_interval);
        offset_matrix=zeros(1,round(offset_amount));
        input_x2_withoffset=[offset_matrix input_x2];
        output_x=input_x1+input_x2_withoffset;
    elseif (input_t1_LSB) > (input_t2_LSB)
        output_t=input_t2;
        offset_amount=offset_amount_calculate(input_t1_LSB,input_t2_LSB,time_interval);
        offset_matrix=zeros(1,round(offset_amount));
        input_x1_withoffset=[offset_matrix input_x1];
        output_x=input_x2+input_x1_withoffset;
    else
        msg='Something must be wrong, Check the function summing_coordinates';
        error(msg);
    end
    
elseif (input_t1_HSB) > (input_t2_HSB)
    if (input_t1_LSB) == (input_t2_LSB)
        output_t=input_t1;
        offset_amount=offset_amount_calculate(input_t1_HSB,input_t2_HSB,time_interval);
        offset_matrix=zeros(1,round(offset_amount));
        input_x2_withoffset=[input_x2 offset_matrix];
        output_x=input_x1+input_x2_withoffset;
    elseif (input_t1_LSB) < (input_t2_LSB)
        output_t=input_t1;
        
        offset_amount_H=offset_amount_calculate(input_t1_HSB,input_t2_HSB,time_interval);
        offset_matrix_H=zeros(1,round(offset_amount_H));

        offset_amount_L=offset_amount_calculate(input_t2_LSB,input_t1_LSB,time_interval);
        offset_matrix_L=zeros(1,round(offset_amount_L));
        
        input_x2_withoffset=[offset_matrix_L input_x2 offset_matrix_H];
        output_x=input_x1+input_x2_withoffset;
    elseif (input_t1_LSB) > (input_t2_LSB)
        output_t=[input_t2_LSB:time_interval:input_t1_HSB input_t1_HSB];
        
        offset_amount_H=offset_amount_calculate(input_t1_HSB,input_t2_HSB,time_interval);
        offset_matrix_H=zeros(1,round(offset_amount_H));

        offset_amount_L=offset_amount_calculate(input_t1_LSB,input_t2_LSB,time_interval);
        offset_matrix_L=zeros(1,round(offset_amount_L));
        
        input_x1_withoffset=[offset_matrix_L input_x1];
        input_x2_withoffset=[input_x2 offset_matrix_H];
        output_x=input_x1_withoffset+input_x2_withoffset;
    else
        msg='Something must be wrong, Check the function summing_coordinates';
        error(msg);
    end
    
elseif (input_t1_HSB) < (input_t2_HSB)
    if (input_t1_LSB) == (input_t2_LSB)
        output_t=input_t2;
        
        offset_amount_H=offset_amount_calculate(input_t2_HSB,input_t1_HSB,time_interval);
        offset_matrix_H=zeros(1,round(offset_amount_H));
        input_x1_withoffset=[input_x1 offset_matrix_H];
        output_x=input_x1_withoffset+input_x2;
    elseif (input_t1_LSB) < (input_t2_LSB)
        output_t=[input_t1_LSB:time_interval:input_t2_HSB input_t2_HSB];
        
        offset_amount_H=offset_amount_calculate(input_t2_HSB,input_t1_HSB,time_interval);
        offset_matrix_H=zeros(1,round(offset_amount_H));

        offset_amount_L=offset_amount_calculate(input_t1_LSB,input_t2_LSB,time_interval);
        offset_matrix_L=zeros(1,round(offset_amount_L));
        
        input_x2_withoffset=[offset_matrix_L input_x2];
        input_x1_withoffset=[input_x1 offset_matrix_H];
        output_x=input_x1_withoffset+input_x2_withoffset;
    elseif (input_t1_LSB) > (input_t2_LSB)
        output_t=input_t2;
        
        offset_amount_H=offset_amount_calculate(input_t2_HSB,input_t1_HSB,time_interval);
        offset_matrix_H=zeros(1,round(offset_amount_H));

        offset_amount_L=offset_amount_calculate(input_t1_LSB,input_t2_LSB,time_interval);
        offset_matrix_L=zeros(1,round(offset_amount_L));
        
        input_x1_withoffset=[offset_matrix_L input_x1 offset_matrix_H];
        output_x=input_x2+input_x1_withoffset;
    else
        msg='Something must be wrong, Check the function summing_coordinates';
        error(msg);
    end
    
else
    msg='Something must be wrong, Check the function summing_coordinates';
    error(msg);
end