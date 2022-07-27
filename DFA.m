%@ Detrended Fluctuation Analysis (DFA)from continous data
clear all;
clc;
tic
load GP01.mat; %Please Change the .mat name here
A=GP01; %Please Change the .mat name here
initial_length=3; %Initia leanth, i.e.,starting from what point
change_in_length=5;% changing leantgh, here each 5 data
[l,c]=size(A);
for ic=1:c
v=A(:,ic);
v=v(~isnan(v)); % not NaN values
%  ---- cumulative sum
S=0.0; 
for i=1:length(v)
    Vt(i)=S+v(i);
    S=Vt(i);
end

m=initial_length;
dm=change_in_length;
im=1;
while m < length(Vt)
for j=1:floor(length(Vt)/m)-1
  zt=(j-1)*m+1:j*m;
  Yt=Vt((j-1)*m+1:j*m);
  P=polyfit(zt,Yt,1);
  yfit = P(1)*zt+P(2);
end
sum1=sum((yfit-Yt).^2)/length(Yt);
            F_n(im)=sqrt(sum1);
            nn(im)=m;
            im=im+1;
            m=m+dm;
end

 coef=polyfit(log(nn(1:end)),log(F_n(1:end)),1);
 alpha(ic)=coef(1); % you will get single ?-DFA values for each row. Please check Readme file
end
%% If plot needed

%figure(1)
%plot(1:c,alpha,'-');
%xlabel('column Number');
%ylabel('\alpha','FontSize',22);


