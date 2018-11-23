function bin=histgram(x,y,hx,hy,H,S,V,image_boundary_x,image_boundary_y,v_count)
bin=zeros(1,v_count); 
matrix=1:1:v_count;

%a归一化常数a
a=(hx+hy)^0.5;
d=0;

%四舍五入取整得到长短半轴
e=round((hx)^0.5);
f=round((hy)^0.5);

for pixel_x=(x-e):(x+e)
    for pixel_y=(y-f):(y+f)
        if(((x-pixel_x)^2/hx+(y-pixel_y)^2/hy)<=1&&pixel_x<=image_boundary_x&&pixel_x>0&&pixel_y<=image_boundary_y&&pixel_y>0)
             bin_id=matrix(H(pixel_y,pixel_x)*7+S(pixel_y,pixel_x)*4+V(pixel_y,pixel_x)*1+1);
             %(min=0*16+0*4+0+1=1,max=45*4+3*3+3+1=193)
             
             %距离中心越近的点越重要
             pixel_distance=(((double(x-pixel_x))^2)+((double(y-pixel_y))^2))^0.5;   
             r=pixel_distance/a; 
             k=50*(1-r^2); 
             
             %得到颜色直方图
             bin(bin_id)=bin(bin_id)+k;   
             d=d+k;                       
        end
    end
end

%归一化
f=1/d;
for time=1:1:v_count
    bin(time)=f*bin(time);
end