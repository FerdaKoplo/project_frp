# Spatial and Location-Allocation Models

> Source basis: Bearman et al. 2023 (AGILE GIScience, spopt p-median); van Willigen 2023 (Wageningen MSc, multi-commodity capacitated location-allocation); Luna Rojas & Flores de la Mota 2022 (EMSS, day-care facilities); Nevat & Mughal 2022 (*Atmosphere* 13, urban climate); de Steiguer et al. 2003 (USDA NE-307, MCDM); Ishimatsu et al. 2013 (AIAA, space logistics network). See [[Summary of the Algorithmic Approach]].

If the archipelagic problem is stated in one sentence, it is this: **where do facilities go, and who is assigned to them, when demand is scattered across islands?** That is precisely the location-allocation problem class.

## The taxonomy

**Bearman et al. (2023)** state the standard classification:

> "Location problems are commonly classified into three categories: covering-based problems, median-based problems, and other problems (Daskin, 2008). The covering-based problem can be further divided into Location Set Covering Problem (LSCP), Maximal Covering Location Problem (MCLP), and p-centre location problem. Median-based problems include two main models: p-median location problem, and fixed charge facility location problem (Daskin, 2008)."

And the domain's practical scope:

> "Location-allocation is a key element of GIS and network analysis, and it has a wide variety of applications across the public, private, and academic sectors."

| Model | Objective | Archipelagic meaning |
|---|---|---|
| **LSCP** | Min facilities covering all demand | Every island served — often infeasible |
| **MCLP** | Max covered demand given p facilities | Realistic budget-bound version |
| **p-centre** | Min worst-case distance | Minimax fairness — the equity extreme |
| **p-median** | Min total travel distance/time | Efficiency with fairness weighting |
| **Fixed charge** | Min cost incl. facility opening cost | Adding the capital budget constraint |

## The p-median model — the corpus's most transferable formulation

**Bearman et al. (2023)** give the complete capacitated p-median model, solved for UCL student-teacher placements over public transport:

Objective and constraints (verbatim structure):

> "Minimise sum_i sum_j c_ij X_ij (1) Subject to: sum_j X_ij = 1, for all i in I (2); sum_i X_ij <= b_j, for all j in J (3); sum_i X_ij = b_j, when p_j = 1 (4); X_ij <= Y_j, for all j in J (5)" where "X_ij = 1, if student i is assigned to school j; 0, otherwise. Y_j = 1, if school j is selected; 0, otherwise."

Read constraint by constraint: (2) every demand point is assigned; (3) facility capacity respected; (4) pre-selected facilities must be used; (5) you can only assign to an *opened* facility. That is the full MILP skeleton of "which islands get the clinic, which island goes to which clinic."

> "The p-median model is designed to minimise the total travel distance or time of customers to the nearest facility (Serra and Marianov, 1998). This model can provide an optimal solution for the placement of facilities based on the existing demand and location."

Solved with the open-source stack — PuLP's default CBC solver — with honest timing:

> "To solve the optimisation problem, we use the default solver of pulp, which is COIN-OR Branch and Cut Solver (CBC). Take an example, when studying the business subject, there are in total 19 students and 38 schools waiting to be allocated, and 4 predefined schools that must be fulfilled. The calculation time is 0.2 seconds by using the new function in spopt, under the environment of Python 3.8.3 in macOS 10.15.5."

Stack: "pandas, geopandas, NumPy, gurobipy, spopt" — and the outcome metric is policy-readable:

> "The results ... has shown a marked improvement on public transport travel time, with public transport travel time reduced by 891 minutes overall for an initial sample of 93 students (9.58 minutes per student)."

## Multi-commodity capacitated location-allocation — the harder sibling

**van Willigen (2023)** handles multiple commodities and capacities simultaneously (NP-hard by inclusion of UFLP), comparing a custom GA against Gurobi. This is the version needed when different *types* of resource (health, education, infrastructure goods) flow through the same facility network — exactly the archipelagic multi-service case.

## Multi-objective public-sector location: the day-care case

**Luna Rojas & Flores de la Mota (2022)** state the general multiobjective problem:

> "The general multiobjective problem formulation is posed as follows: Minimize F(x) = [F_1(x), F_2(x), ..., F_k(x)]^T, x in R^n (16) subject to g_i(x) <= 0, i = 1,...,l (17); h_i(x) = 0, i = 1,...,m (18)... A solution x is Pareto optimal if it is not possible to move from that point and improve at least one objective function without detriment to another objective function."

Their public-sector motivation is the federal problem in miniature:

> "One of the concerns within public organizations in Mexico is to improve the services provided to citizens, however, budget cuts have caused these institutions to seek solutions that fit their resources. Location-allocation of facilities is one of the most important decision-making problems, however, applications of this type of problem have hardly been studied in the context of the institutions in charge of social security in the Mexican public sector."

Objectives: "minimize the cost of operation and the distance traveled by service users, while maximizing the demand covered", solved "by LINGO 19.0".

**Pareto optimality is the formal version of a trade-off** — no single point satisfies every objective; the planner chooses *along* the frontier. This is the mathematical language for the seven trade-offs in [[Federation Research/Tradeoff With The Federation Resources Planning]].

## Spatial allocation without facilities: the portfolio version

**Nevat & Mughal (2022)** (urban climate risk) allocate a budget across regions rather than facilities — closest to the transfer-allocation problem:

> "A practical and common approach for allocating the money is to partition the physical domain into a finite number of regions, and allocate the money to each region according to some decision mechanism... Each region will be allocated a portion of the money, denoted by {a_k in R+}, such that sum_k a_k = 1, meaning that all the money will be used."

Note the constraint `sum_k a_k = 1` — the entire budget is distributed, the normalization is automatic, and the shares `a_k` are the decision variables. **This is structurally the equalization-transfer model of [[Federation Research/Translating Political Constraints to Algorithmic Rules]]: replace "regions" with "island provinces" and the share `a_k` with the transfer formula `T_i`.** Their use of ML surrogate models to make the optimization tractable is covered in [[Operations Research vs Machine Learning]].

## Multi-criteria decision models (MCDM)

**de Steiguer et al. (2003)** survey MCDM for forestry and natural resources — where goals are incommensurable and stakeholder weights dominate:

> MCDM "first developed during World War II by the U.S. military for strategic decisionmaking" (inventory) — MCDM is the soft, weight-and-score cousin of optimization. The federal planning problem needs both: MCDM for deciding objective *weights* (a political process), LP/GA for optimizing given them (a technical process). Yan et al. (2026)'s AHP + GA pairing makes exactly this division.

## The spatial layer of the federal model — synthesis

| Question | Model from this vault |
|---|---|
| Which islands get a facility? | p-median / fixed-charge MILP (Bearman et al. 2023; van Willigen 2023) |
| Given fixed budget, who is covered? | MCLP — and the answer "not everyone" is the mainland–island trade-off |
| How to split the budget across islands? | Portfolio/shares allocation (Nevat & Mughal 2022) = the transfer formula |
| How to weigh competing objectives? | Pareto frontier + MCDM methods (Luna Rojas 2022; de Steiguer 2003) |
| Distance basis for cost indices? | Euclidean × detour factor, calibrated from real data (van Willigen 2023 — see [[Synthetic Data Generation]]) |

## Related notes
- [[Mixed-Integer Linear Programming]] — the formulation class
- [[Synthetic Data Generation]] — van Willigen's instance-construction method
- [[Federation Research/How Federation Resources Planning Affected Archipelagos Nation]] — the geographic penalty these models formalize
- [[Federation Research/Translating Political Constraints to Algorithmic Rules]] — where the cost-of-provision index enters
