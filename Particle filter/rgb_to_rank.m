function [H,S,V]=rgb_to_rank(I)
[M,N,~] = size(I);
%RGB转换到HSV(多提一句，2=to)
[h,s,v] = rgb2hsv(I);
%颜色（值0-1）
H = h;
h = h*360; 
%纯度（值0-1）
S = s;
%亮度（值0-1）
V = v;

%将HSV空间非等间隔量化
% h量化成46级
% s量化成4级
% v量化成4级
for i = 1:M
    for j = 1:N        
%H子空间
        if h(i,j)>=0&&h(i,j)<10
            H(i,j)=0;
        end
        if h(i,j)>=10&&h(i,j)<20
            H(i,j)=1;
        end
        if h(i,j)>=20&&h(i,j)<30
            H(i,j)=2;
        end
        if h(i,j)>=30&&h(i,j)<40
            H(i,j)=3;
        end
        if h(i,j)>=40&&h(i,j)<50
            H(i,j)=4;
        end
        if h(i,j)>=50&&h(i,j)<60
            H(i,j)=5;
        end
        if h(i,j)>=60&&h(i,j)<70
            H(i,j)=6;
        end
        if h(i,j)>=70&&h(i,j)<80
            H(i,j)=7;
        end
        if h(i,j)>=80&&h(i,j)<90
            H(i,j)=8;
        end
        if h(i,j)>=90&&h(i,j)<100
            H(i,j)=9;
        end
        if h(i,j)>=100&&h(i,j)<110
            H(i,j)=10;
        end
        if h(i,j)>=110&&h(i,j)<120
            H(i,j)=11;
        end
        if h(i,j)>=120&&h(i,j)<130
            H(i,j)=12;
        end
        if h(i,j)>=130&&h(i,j)<140
            H(i,j)=13;
        end
        if h(i,j)>=140&&h(i,j)<150
            H(i,j)=14;
        end
        if h(i,j)>=150&&h(i,j)<160
            H(i,j)=15;
        end
        if h(i,j)>=160&&h(i,j)<170
            H(i,j)=16;
        end
        if h(i,j)>=170&&h(i,j)<180
            H(i,j)=17;
        end
        if h(i,j)>=180&&h(i,j)<190
            H(i,j)=18;
        end
        if h(i,j)>=190&&h(i,j)<200
            H(i,j)=19;
        end
                
        if h(i,j)>=200&&h(i,j)<205
            H(i,j)=20;
        end
        if h(i,j)>=205&&h(i,j)<210
            H(i,j)=21;
        end
        if h(i,j)>=210&&h(i,j)<215
            H(i,j)=22;
        end
        if h(i,j)>=215&&h(i,j)<220
            H(i,j)=23;
        end
        if h(i,j)>=220&&h(i,j)<225
            H(i,j)=24;
        end
        if h(i,j)>=225&&h(i,j)<230
            H(i,j)=25;
        end
        if h(i,j)>=230&&h(i,j)<235
            H(i,j)=26;
        end
        if h(i,j)>=235&&h(i,j)<240
            H(i,j)=27;
        end
        if h(i,j)>=240&&h(i,j)<245
            H(i,j)=28;
        end
        if h(i,j)>=245&&h(i,j)<250
            H(i,j)=29;
        end
        if h(i,j)>=250&&h(i,j)<255
            H(i,j)=30;
        end
        if h(i,j)>=255&&h(i,j)<260
            H(i,j)=31;
        end
        if h(i,j)>=260&&h(i,j)<265
            H(i,j)=32;
        end
        if h(i,j)>=265&&h(i,j)<270
            H(i,j)=33;
        end
        if h(i,j)>=270&&h(i,j)<275
            H(i,j)=34;
        end
        if h(i,j)>=275&&h(i,j)<280
            H(i,j)=35;
        end
        if h(i,j)>=280&&h(i,j)<285
            H(i,j)=36;
        end
        if h(i,j)>=285&&h(i,j)<290
            H(i,j)=37;
        end
        if h(i,j)>=290&&h(i,j)<295
            H(i,j)=38;
        end
        if h(i,j)>=295&&h(i,j)<300
            H(i,j)=39;
        end
        
        if h(i,j)>=300&&h(i,j)<310
            H(i,j)=40;
        end
        if h(i,j)>=310&&h(i,j)<320
            H(i,j)=41;
        end
        if h(i,j)>=320&&h(i,j)<330
            H(i,j)=42;
        end
        if h(i,j)>=330&&h(i,j)<340
            H(i,j)=43;
        end
        if h(i,j)>=340&&h(i,j)<350
            H(i,j)=44;
        end
        if h(i,j)>=350&&h(i,j)<=360
            H(i,j)=45;
        end

%S子空间
        if 0<=s(i,j)&&s(i,j)<0.173
            S(i,j) = 0;
        end
        if 0.923<=s(i,j)&&s(i,j)<=1
            S(i,j) = 0;
        end
        if s(i,j)>=0.173&&s(i,j)<0.423
            S(i,j) = 1;
        end
        if s(i,j)>=0.423&&s(i,j)<0.673
            S(i,j) = 2;
        end
        if s(i,j)>=0.673&&s(i,j)<0.923
            S(i,j) = 3;
        end
        
%V子空间
        if v(i,j)>=0&&v(i,j)<0.25
            V(i,j) = 0;
        end
        if v(i,j)>=0.25&&v(i,j)<0.5
            V(i,j) = 1;
        end
        if v(i,j)>=0.5&&v(i,j)<0.75
            V(i,j) = 2;
        end
        if v(i,j)>=0.75&&v(i,j)<=1
            V(i,j) = 3;
        end
        
    end
end

