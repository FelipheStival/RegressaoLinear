/* Objective function */
max: +21 Q1 +5 Q2 +10 Q3 +14 Q4 +5 Q5 +5 Q6 +10 Q7 +5 Q8 +5 Q9;

/* Constraints */
Time_Constraint: +24 Q1 +7 Q2 +15 Q3 +12 Q4 +4 Q5 +3 Q6 +10 Q7 +5 Q8 +6 Q9 <= 50;

/* Variable bounds */
Q1 <= 1;
Q2 <= 1;
Q3 <= 1;
Q4 <= 1;
Q5 <= 1;
Q6 <= 1;
Q7 <= 1;
Q8 <= 1;
Q9 <= 1;

/* Integer definitions */
int Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9;
