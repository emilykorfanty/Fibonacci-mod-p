% plots the pisano periods modulo p up to p=N, then for p^k \leq N

N = 10000; % Upper limit on p^k
p = primes(N); % Primes

n = zeros(1,length(N)); % Pisano periods for Fibonacci modulo n
k = 0; %counter for powers
Fk = eye(2); % counter for matrix powers
F = [1, 1; 1, 0];

GLOP = zeros(1,length(N)); % This will hold a (bad) estimate of the periods
for i = 1:length(p)
GLOP(i) = (p(i)^2-1)*(p(i)^2-p(i));    
k = 1;
Fk = F;

while isequal(Fk,eye(2)) == 0
    k = k+1;
    Fk = mod(Fk*F, p(i));
end
n(i)=k;
end

scatter(p, n, '.', 'k');
xlim([0 N]);

hold on

PrimePowers;

nn = zeros(1, LPP);

for i = 1:LPP   
k = 1;
Fk = F;

while isequal(Fk,eye(2)) == 0
    k = k+1;
    Fk = mod(Fk*F, PP(i));
end
nn(i)=k;
end

scatter(PP, nn, 'b');
xlabel('m');
ylabel('Pisano period modulo m');
title('Periods of the Fibonacci sequence modulo m');

PeriodEstimate;
legend('m is prime', 'm is a prime power', '2(m+1)', 'm-1', ...
    '2(p+1)/3', '(p-1)/2', '(p+1)/3');


hold off