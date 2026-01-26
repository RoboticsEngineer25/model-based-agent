% ===== APPLICANT DATABASE =====
% Format: applicant(Name, Income, CreditScore, LoanAmount, Employment)

applicant(john, 50000, 720, 20000, employed).
applicant(sarah, 30000, 650, 15000, employed).
applicant(mike, 80000, 580, 40000, employed).
applicant(lisa, 45000, 700, 25000, unemployed).
applicant(tom, 60000, 800, 10000, employed).


% ===== 1. SIMPLE REFLEX AGENT =====
% Only looks at CURRENT perception (credit score)
% No memory, no planning, just IF-THEN rules

simple_reflex_agent(Name, Decision) :- applicant(Name, _, CreditScore, _, _),
    (   CreditScore >= 800
    ->   Decision = approved
    ;    Decision = rejected
    ).


% Test simple reflex agent

test_simple_reflex :- 
    write('===== SIMPLE REFLEX AGENT ====='), nl,
    write('Rule: IF credit_score >= 800 THEN approve'), nl, nl,
    applicant(Name, _, Score, _, _),
    simple_reflex_agent(Name, Decision),
    format('~w (Score: ~w) -> ~w~n' , [Name, Score, Decision]),
    fail.

test_simple_reflex :- nl.




