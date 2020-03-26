%% plot the desired paths
figure; axis equal; set(gcf,'color','w'); hold on; grid on; axis equal;
view(0,90);
xlabel('X'); ylabel('Y'); zlabel('Z')
hAxes = gca;

% desired path: projected trefoil knot
th = 0: 0.01: 4*pi;
height = 0;
gain=1; nx=3; ny=4; nz=7; betax=0.1; betay=0.7; betaz=0;
x = 250*cos(gain*nx*th+betax)+600;
y = 250*cos(gain*ny*th+betay)+350;
hold on;  
pltobj = plot3(x, y, height*ones(1, length(x)), 'LineWidth', 1);
xlabel('X'); ylabel('Y'); zlabel('W')
pz = zeros(size(px));

%% plot starting position
plot3(px(1), py(1), pz(1), 'bo', 'LineWidth', 1);

htraj = animatedline(hAxes, 'LineWidth', 2, 'MaximumNumPoints',Inf);
hpt = animatedline(hAxes, 'Color','blue', 'Marker', '.', 'MarkerSize', 20, 'MaximumNumPoints',Inf);
htri = animatedline(hAxes, 'MaximumNumPoints',Inf);
hvtr = animatedline(hAxes, 'Color','red', 'Marker', '.', 'MarkerSize', 20, 'MaximumNumPoints',Inf);  % "virtual target"
hnoi = animatedline(hAxes, 'Color', [0.5 0.5 0.5], 'Marker', '.', 'MarkerSize', 20, 'MaximumNumPoints',Inf);    % noise animation
%axis([300 900 0 600])
legend([pltobj, hpt, hnoi, hvtr], {'desired path', 'actual robot position', 'perceived robot position', 'desired trajectory point'}, 'Location','northeast')
legend('boxoff')

%% animation
expand = 0.1;
lenx=max(px)-min(px); leny=max(py)-min(py); lenz=max(pz)-min(pz);
xlim([min(px)-expand*lenx, max(px)+expand*lenx]); 
ylim([min(py)-expand*leny, 730]); 
numpoints = length(px);
drawnum = 500;
set(gcf, 'Position',  [700, 400, 600, 600])
pause(5)
for i = 1 : drawnum : numpoints-(drawnum-1)
    dis = sprintf("Time (s): %0.3f", time(i+(drawnum-1)));
    tt = text(hAxes, 280, 650, 0, dis);

    % trajectory 
    addpoints(htraj, px(i:i+(drawnum-1)), py(i:i+(drawnum-1)), pz(i:i+(drawnum-1)));
    % trajectory point
    addpoints(hpt, px(i+(drawnum-1)), py(i+(drawnum-1)), pz(i+(drawnum-1)));
    p1 = [px(i+(drawnum-1)); py(i+(drawnum-1)); pz(i+(drawnum-1))];
    vel = [cos(theta(i+(drawnum-1))); sin(theta(i+(drawnum-1))); 0];
    L = 40; 
    p1 = p1 - 0.433*L*vel/norm(vel);
    p = cal_tri_pts(p1, vel, L);		% get four points to draw a triangle and then draw it
    addpoints(htri, p(1,3), p(2,3), p(3,3));
    addpoints(htri, p(1,1), p(2,1), p(3,1));
    addpoints(htri, p(1,2), p(2,2), p(3,2));
    addpoints(htri, p(1,3), p(2,3), p(3,3));
    addpoints(htri, p(1,4), p(2,4), p(3,4));
    addpoints(htri, p(1,1), p(2,1), p(3,1));
    addpoints(hvtr, xd(i+(drawnum-1)), yd(i+(drawnum-1)), height);
    addpoints(hnoi, noise_px(i+(drawnum-1)), noise_py(i+(drawnum-1)), height)

    drawnow
    pause(0.01) 

    delete(tt)
    clearpoints(hpt)
    clearpoints(htri)
    clearpoints(hvtr)
    clearpoints(hnoi)
end


function p = cal_tri_pts(p1, v, L)
% input:    p1 -- the midpoint of one edge of a triangle; COLUMN vector
%           v  -- a velocity vector; pointing from p1 to a vertex; COLUMN vector
%           L  -- edge length of the triangle
% output:   p = [p1, p2, p3, p4] contaning the verteces of the triangle
%           p2, p3 and p4 (COLUMN vectors); p1 is the same as the input;
%
%                          p3
%                          *                     
%                         /|\
%                        / | \
%                       /  |  \
%                      /___|___\ 
%                     p4   p1   p2
%
    p3=p1+0.866*L*v/norm(v);
    solx = v(2)*(1/(v(1)^2 + v(2)^2))^(1/2);
    soly = -v(1)*(1/(v(1)^2 + v(2)^2))^(1/2);
    vv=double([solx;soly;0]);
    p2=p1+0.5*L*vv;
    p4=p1-0.5*L*vv;
    p=[p1, p2, p3, p4];
end