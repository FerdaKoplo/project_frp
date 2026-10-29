# Resource Allocation with PuLP

> Source basis: Bearman et al. 2023 (AGILE GIScience 4, spopt p-median) — the corpus's only PuLP file. All general PuLP content below is external knowledge, flagged as such. See [[Summary of the Algorithmic Approach]].

**PuLP** is the open-source Python LP/MILP modeller — the lightest path from a formula on paper to a solved allocation. In this corpus it appears in exactly one place: the spopt location-allocation case.

## PuLP in the corpus — the one solid anchor

**Bearman et al. (2023)** built a capacitated p-median school-placement model inside the **spopt** (spatial optimisation) package, part of the PySAL family, and solved it with PuLP's default solver:

> "To solve the optimisation problem, we use the default solver of pulp, which is COIN-OR Branch and Cut Solver (CBC). Take an example, when studying the business subject, there are in total 19 students and 38 schools waiting to be allocated, and 4 predefined schools that must be fulfilled. The calculation time is 0.2 seconds by using the new function in spopt, under the environment of Python 3.8.3 in macOS 10.15.5."

Two facts worth keeping: **CBC (COIN-OR Branch and Cut) is PuLP's default solver** — open-source, no licence needed — and a small MILP solves in **fractions of a second**. The full Python stack of that paper:

> "The work is currently being undertaken in Python, making use of the pandas, geopandas, NumPy, gurobipy, spopt, filelock, pyarrow, pyrate-limiter, and requests libraries."

And the reproducibility posture — code via GitHub + Zenodo DOI, workflow as Jupyter Notebook, data anonymised because the original is confidential:

> "Research data and code supporting this publication will be available via a GitHub repository including a reproducible example. This will be linked to a DOI generated through Zenodo. The computational workflow supporting the location-allocation work in the spopt library will be available as a Jupyter Notebook. The original data we are using is confidential data from UCL IOE ... A sample data set will be provided with anonymised and randomised data which can be used to demonstrate the usefulness of the app and library developments."

**This is the template for the archipelagic model's open-science packaging** — and the anonymised-sample release is the pattern for handling confidential fiscal microdata.

## Why PuLP is the right default for this vault

*(External knowledge — verify against PuLP docs before the paper.)*

| Property | Value for the federal model |
|---|---|
| Pure Python, pip-installable | No licence server, no Gurobi/CPLEX cost — matters for replicability rule in [[Federation Research/Translating Political Constraints to Algorithmic Rules]] |
| LP **and** MILP | Covers both the transfer formula (LP) and the facility-siting layer (MILP) |
| Multiple solver backends | CBC default; can call Gurobi/CPLEX if available |
| Model-as-code | The formula *is* a legible artefact, auditable line by line |

**Alternative commercial solvers in the corpus:** Gurobi (`gurobipy` — van Willigen 2023; Bearman et al. 2023), FICO Xpress (Yao 2023 timetabling), LINGO 19 (Luna Rojas & Flores de la Mota 2022), MATLAB `cplexlp` (Ishimatsu et al. 2013). For a replicable public formula, PuLP+CBC is the corpus's own defensible choice — fast enough at realistic instance sizes and free.

## How an LP model looks in PuLP — the corpus-derived skeleton

The p-median formulation from Bearman et al. (2023) is the shape of any PuLP model:

> "Minimise Σ_i Σ_j c_ij X_ij (1) Subject to: Σ_j X_ij = 1, for all i in I (2); Σ_i X_ij <= b_j, for all j in J (3); Σ_i X_ij = b_j, when p_j = 1 (4); X_ij <= Y_j, for all j in J (5)" with "X_ij = 1, if student i is assigned to school j; 0, otherwise. Y_j = 1, if school j is selected; 0, otherwise."

In PuLP structure: `LpProblem` (objective `Minimize`), `LpVariable.dicts` for `X_ij`/`Y_j` with `cat='Binary'`, `prob +=` for objective and each constraint, `solve(PULP_CBC_CMD())`. The **constraint list is the legislable part** — the code mirrors Yao's hard/soft rule ([[Modeling Federal Constraints & Penalties]]): hard rules become `prob +=` constraints, soft rules become penalty terms in the objective expression.

## What PuLP does *not* cover (honest limits)

- **No network-flow specialization.** For large single-commodity transshipment, network simplex is far faster (see [[Network Flow Algorithms]] — Goldberg–Tardos–Tarjan; Swanson & Woolsey on special structure). PuLP/CBC treats the flow LP as a general LP.
- **No multi-objective support.** Pareto frontiers (Luna Rojas & Flores de la Mota 2022) require either weighted sums — which is exactly the α-weight in the synthesis formula `T_i = α·Need + (1-α)·CapacityGap − Effort` — or repeated runs.
- **Not a graph library.** Graph construction needs NetworkX — which is **absent from this corpus** (see [[Graph Modeling with NetworkX]]).

## Resource-allocation models in this corpus, by tool

| Application | Tool | Source |
|---|---|---|
| Capacitated p-median (school placement) | PuLP/CBC inside spopt | Bearman et al. 2023 |
| Multi-commodity location-allocation | Gurobi (`gurobipy`) + custom GA | van Willigen 2023 |
| University timetabling | FICO Xpress | Yao 2023 |
| Day-care multiobjective location | LINGO 19.0 | Luna Rojas & Flores de la Mota 2022 |
| Space logistics MCNF | MATLAB `cplexlp` | Ishimatsu et al. 2013 |
| Assignment problem (metal workshop) | Hungarian algorithm (no solver) | Mitiku 2025 |

## Action items before the paper

1. Build the small PuLP prototype of `T_i` allocation (LP with Israel & Lund preprocessor weights — [[Modeling Federal Constraints & Penalties]]).
2. Verify PuLP API details (external — not in corpus).
3. Benchmark CBC solve time on a synthetic archipelagic instance from [[Synthetic Data Generation]].

## Related notes
- [[Spatial and Location-Allocation Models]] — the p-median application
- [[Modeling Federal Constraints & Penalties]] — what goes in the constraint list
- [[Synthetic Data Generation]] — test instances for the PuLP model
