function [offset_amount]=offset_amount_calculate(num_a,num_b,time_interval)
offset_amount=floor(1+(abs(num_a-num_b))/time_interval);