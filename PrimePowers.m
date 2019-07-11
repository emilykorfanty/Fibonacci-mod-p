
% First, we have to figure out all the prime powers <=10,000 
% plots the pisano periods modulo p^k for values up to N

%% if you want to calculate this separately . . .
%N = 10000;
%p = primes(N); % Primes


%% The main computation

pj = 0; % will be used to store values of p^j
PP=2^2; % the first prime power
j=3;

for i=1:length(p)
while p(i)^j <= N
    pj = p(i)^j;
    PP = [PP pj];
    j=j+1;
end
j=2;
end

LPP=length(PP);
PP = sort(PP);