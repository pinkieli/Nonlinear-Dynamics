%Masses of the two primary masses
c = input('Enter the ratio of the primary masses M1/M2: ');
mu = c/(1+c);
M1 = mu;
M2 = 1-mu;
%Positions of the two primary masses
rM1 = [-(1-mu),0];
rM2 = [mu,0];
%Set initial position and velocity of the object
r = [.5*(c-1)/(c+1),sqrt(3)/2];  
v = [.01,.01];
state = [ r(1) r(2) v(1) v(2) ];   % Used by R-K routines
%Initialize time
time = 0;
i=1;
j=1;
k=1;
xtemp(1)=r(1);
ytemp(1)=r(1);

%MAIN PROGRAM
%Loop over desired number of steps
tau = .01; 
nStep = input('Enter the number of steps to calculate: ');
xplot=zeros(1,nStep);
yplot=zeros(1,nStep);
vxplot=zeros(1,nStep);
vyplot=zeros(1,nStep);
tplot=zeros(1,nStep);
for iStep=1:nStep  
  %* Record position for plotting
  xplot(iStep) = r(1);
  yplot(iStep) = r(2);
  vxplot(iStep) = v(1);
  vyplot(iStep) = v(2);
  rplot(iStep) = norm(r);
  tplot(iStep) = time;       
  
  %Poincare section - plot position every time vx=0
%   if (iStep>1)
%     if (vxplot(iStep)*vxplot(iStep-1)<0)
%         Pxplot(j)=r(1);
%         Pyplot(j)=r(2);
%         j=j+1;
%     end
%   end
  
  if (mod(iStep,nStep/200)<1)
    k=k+1;
    xtemp(k)=r(1);
    ytemp(k)=r(2);
    figure(1);
    %plot(xtemp,ytemp,'.',rM1(1),rM1(2),'+',rM2(1),rM2(2),'+');
    %drawnow;
  end

  %* Calculate new position and velocity using RK4.
  state = rk4(state,time,tau,'gravrk',M1,M2,rM1,rM2);
  r = [state(1) state(2)];
  v = [state(3) state(4)];
  time = time + tau;
  
end

figure(2);
plot(xplot,yplot,'.',rM1(1),rM1(2),'+',rM2(1),rM2(2),'+',xplot(1),yplot(1),'o');
xlabel('x position'); ylabel('y position');
title('Particle Trajectory');

% figure(3); clf;
% plot(Pxplot,Pyplot,'.');
% title('Poincare section');

figure(4);
plot(tplot,xplot);
xlabel('time'); ylabel('x position');
title('Time series of x position');

figure(5);
plot(tplot,yplot);
xlabel('time'); ylabel('y position');
title('Time series of y position');

figure(6);
n=1;
for i=2:(nStep-1)
    if (xplot(i)>xplot(i-1)&&xplot(i)<xplot(i+1))
        retx(n)=xplot(i);
        n=n+1;
    end
end
retx1=retx(1:end-1);
retx2=retx(2:end);
plot(retx1,retx2,'.');

figure(7);
n=1;
for i=2:(nStep-1)
    if (yplot(i)>yplot(i-1)&&yplot(i)<yplot(i+1))
        rety(n)=yplot(i);
        n=n+1;
    end   
end
rety1=rety(1:end-1);
rety2=rety(2:end);
plot(rety1,rety2,'.');

figure(8);
n=1;
for i=2:(nStep-1)
    if (rplot(i)>rplot(i-1)&&rplot(i)<rplot(i+1))
        retr(n)=rplot(i);
        n=n+1;
    end
end
retr1=retr(1:end-1);
retr2=retr(2:end);
plot(retr1,retr2,'.');