function[] = TaskTest(param1, param2)
   disp(param1);
   disp(param2);
   value= split(param1,"_")
   fname = sprintf('%s_%s_Median_All', value{1},value{3});
   disp(fname)
end