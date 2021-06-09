function[] = TaskTest(param1)
   disp(param1);
   value= split(param1,"_")
   fname = sprintf('%s_%s_prova', value{1},value{3});
   disp(fname)
    set(gcf, 'Visible', 'off');
    figure('Visible', 'off')
    scatter(1,1,'x');
    drawnow()
   export_fig(['C:/Users/guazz/Desktop/' fname], '-pdf');
end