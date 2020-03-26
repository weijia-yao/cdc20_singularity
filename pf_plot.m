%% desired path: projected trefoil knot
figure; set(gcf,'color','w'); grid on;
th = 0: 0.01: 4*pi;
gain=1; nx=3; ny=4; nz=7; betax=0.1; betay=0.7; betaz=0;
x = 250*cos(gain*nx*th+betax)+600;
y = 250*cos(gain*ny*th+betay)+350;
plot3(x, y, 0*ones(1, length(x)), 'LineWidth', 1)
xlabel('X'); ylabel('Y'); zlabel('W')
hold on;  
 
%%% plot the traj
pz = zeros(size(px));
L = 30;
range = 1:2007091;

% the trajecotry
plot3(px(range), py(range), pz(range), 'm', 'LineWidth', 2);

%%% the direction
index = 1;
point=[px(index); py(index); pz(index)];
vel = [cos(theta(index)); sin(theta(index)); 0];
p = cal_tri_pts(point, vel, L);
line_pts = [p(:,3), p(:,1), p(:,2), p(:,3), p(:,4), p(:,1)];
line(line_pts(1,:), line_pts(2,:), line_pts(3,:), 'LineWidth', 2);

index = 60000;
point=[px(index); py(index); pz(index)];
vel = [cos(theta(index)); sin(theta(index)); 0];
p = cal_tri_pts(point, vel, L);
line_pts = [p(:,3), p(:,1), p(:,2), p(:,3), p(:,4), p(:,1)];
line(line_pts(1,:), line_pts(2,:), line_pts(3,:), 'LineWidth', 2);

index = 135000;
point=[px(index); py(index); pz(index)];
vel = [cos(theta(index)); sin(theta(index)); 0];
p = cal_tri_pts(point, vel, L);
line_pts = [p(:,3), p(:,1), p(:,2), p(:,3), p(:,4), p(:,1)];
line(line_pts(1,:), line_pts(2,:), line_pts(3,:), 'LineWidth', 2);

index = 280000;
point=[px(index); py(index); pz(index)];
vel = [cos(theta(index)); sin(theta(index)); 0];
p = cal_tri_pts(point, vel, L);
line_pts = [p(:,3), p(:,1), p(:,2), p(:,3), p(:,4), p(:,1)];
line(line_pts(1,:), line_pts(2,:), line_pts(3,:), 'LineWidth', 2);

index = 491000;
point=[px(index); py(index); pz(index)];
vel = [cos(theta(index)); sin(theta(index)); 0];
p = cal_tri_pts(point, vel, L);
line_pts = [p(:,3), p(:,1), p(:,2), p(:,3), p(:,4), p(:,1)];
line(line_pts(1,:), line_pts(2,:), line_pts(3,:), 'LineWidth', 2);

index = 701000;
point=[px(index); py(index); pz(index)];
vel = [cos(theta(index)); sin(theta(index)); 0];
p = cal_tri_pts(point, vel, L);
line_pts = [p(:,3), p(:,1), p(:,2), p(:,3), p(:,4), p(:,1)];
line(line_pts(1,:), line_pts(2,:), line_pts(3,:), 'LineWidth', 2);

index = 1601000;
point=[px(index); py(index); pz(index)];
vel = [cos(theta(index)); sin(theta(index)); 0];
p = cal_tri_pts(point, vel, L);
line_pts = [p(:,3), p(:,1), p(:,2), p(:,3), p(:,4), p(:,1)];
line(line_pts(1,:), line_pts(2,:), line_pts(3,:), 'LineWidth', 2);

hold on;
plot3(f1w(1), f2w(1), 0, 'Marker', '.', 'MarkerSize', 30, 'Color', 'red')
plot3(f1w(20000), f2w(20000), 0, 'Marker', '.', 'MarkerSize', 30, 'Color', 'red')
plot3(f1w(300000), f2w(300000), 0, 'Marker', '.', 'MarkerSize', 30, 'Color', 'red')

view(0,90); axis equal;
hold off;

%% plot the error
figure; hold on; grid off; set(gcf,'color','w')
range=1:length(e.Time);
time=e.Time(range); e1=e.Data((range),1); e2=e.Data((range),2); e_norm=sqrt(e1.^2+e2.^2);
plot(time, e1,'LineStyle', '-.','LineWidth', 2);
plot(time, e2,'LineStyle', ':','LineWidth', 2);
plot(time, e_norm,'LineStyle', '-','LineWidth', 2);
legend('e_1','e_2','||e||');
xlabel('time (s)')
hold off;

%%
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