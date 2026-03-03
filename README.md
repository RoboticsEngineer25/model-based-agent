# Model-Based Agent (Prolog)

This project demonstrates a simple model-based agent for loan approval using Prolog. The agent maintains an internal state (income, credit score, employment status) and makes decisions based on this state.
# Model-Based Agent (Prolog)

This project demonstrates a simple model-based agent for loan approval using Prolog. The agent maintains an internal state (income, credit score, employment status) and makes decisions based on this state.

## Files

- `model-based-agent.pl`: Prolog implementation of a model-based agent for loan approval.
- `single-reflex-agent.pl`: (Add description if available)
- `goal-based-agent.pl`: (Add description if available)
- `utility-based-agent.pl`: Prolog implementation of a utility-based agent for loan approval (expected utility maximization).

## model-based-agent.pl
## utility-based-agent.pl

This agent assigns a numerical utility to each possible action (approve, reject, request more info) based on factors such as credit score, employment status, debt-to-income ratio (DTI), and profit expectation. It selects the action with the highest expected utility.

### Factors Used
- **Credit Metric**: Normalized credit score.
- **Employment Factor**: Weight for job stability and industry risk.
- **DTI & Leverage**: Penalty for high DTI.
- **Profit Expectation**: Expected revenue minus risk of default.

### Example Usage
1. Start SWI-Prolog and load the file:
   ```
   swipl -s utility-based-agent.pl
   ```
2. Set the internal state:
   ```
   ?- update_income(4000).
   ?- update_credit_score(720).
   ?- update_employment_status(employed).
   ?- update_dti(0.3).
   ```
3. Make a decision:
   ```
   ?- utility_based_decide(Action).
   ```
   The variable `Action` will be unified with the agent's decision.

### Notes
- You must use SWI-Prolog or a compatible Prolog environment.
- The agent uses a simple, illustrative utility model. Adjust weights and formulas for real-world use.

---
Add descriptions for other agent files as needed.

### Internal State
- `income/1`: Stores the applicant's income.
- `credit_score/1`: Stores the applicant's credit score.
- `employment_status/1`: Stores the applicant's employment status.

### State Update Predicates
- `update_income(Value)`: Sets the income.
- `update_credit_score(Value)`: Sets the credit score.
- `update_employment_status(Value)`: Sets the employment status.

### Decision Logic
- `approve_loan`: Succeeds if income ≥ 3000, credit score ≥ 670, and employment status is employed.
- `reject_loan`: Succeeds if credit score < 670.
- `request_more_info`: Succeeds if credit score is not provided.
- `decide(Action)`: Determines the action (`approve_loan`, `reject_loan`, or `request_more_info`).

### Example Usage

1. Start SWI-Prolog and load the file:
   ```
   swipl -s model-based-agent.pl
   ```
2. Set the internal state:
   ```
   ?- update_income(4000).
   ?- update_employment_status(employed).
   ?- update_credit_score(700).
   ```
3. Make a decision:
   ```
   ?- decide(Action).
   ```
   The variable `Action` will be unified with the agent's decision.

## Requirements
- [SWI-Prolog](https://www.swi-prolog.org/)

---
Add descriptions for other agent files as needed.
