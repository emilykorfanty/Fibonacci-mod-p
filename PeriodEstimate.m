
x = 2:N;
P_a = zeros(1,N-1);
P_b = zeros(1,N-1);
P_c = zeros(1, N-1);
P_d = zeros(1, N-1);
P_e = zeros(1, N-1);

for i=1:N-1
    P_a(i) = 2*(x(i)+1);
    P_b(i) = x(i)-1;
    P_c(i) = 2*(x(i)+1)/3;
    P_d(i) = (x(i)-1)/2;
    P_e(i) = (x(i)+1)/3;
end

plot(x, P_a);
hold on
plot(x, P_b);
plot(x, P_c);
plot(x, P_d);
plot(x, P_e);
