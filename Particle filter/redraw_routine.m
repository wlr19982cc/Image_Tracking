function im_routine=redraw_routine(image_boundary_x,image_boundary_y,routine,struct_index)
%对其轨迹进行重绘
for i=1:image_boundary_x
    for j=1:image_boundary_y
        im_routine(j,i)=0.8;
    end
end
i=1;
j=1;
while(j<=struct_index)
    for new_x=routine(j).x-i:routine(j).x+i
       for new_y=routine(j).y:routine(j).y+i
            im_routine(new_y,new_x)=0;
       end
    end   
    j=j+1;
end
