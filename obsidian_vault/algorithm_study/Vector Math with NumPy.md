
> **Status: corpus-WEAK topic.** NumPy appears in exactly one corpus file — Bearman et al. (2023), listed in the Python stack. Vector *mathematics* is pervasive (transposes, gradients, inner products) but always on paper, never as NumPy code. This note documents the corpus's vector math and marks NumPy implementation as **external knowledge requiring verification**.

## The corpus's only NumPy mention

**Bearman et al. (2023)** — the p-median spopt case study:

> "The work is currently being undertaken in Python, making use of the pandas, geopandas, NumPy, gurobipy, spopt, filelock, pyarrow, pyrate-limiter, and requests libraries."

NumPy is part of the working scientist's default stack here — data handling around the solver, not a modelling star in its own right.

## The vector math the corpus actually does

Every formulation in this vault is vector algebra written down. Four examples:

**1. The LP objective as an inner product** — Goemans (2015, MIT 18.310A):

> "Linear Programming deals with the problem of optimizing a linear objective function subject to linear equality and inequality constraints on the decision variables."

And in canonical form: "Max z = c^T x subject to (P) Ax <= b, x >= 0" — a vector `x` of decisions, matrix `A` of constraint coefficients, vectors `b`/`c` of limits and prices. `c^T x` is the inner product that turns the decision vector into a scalar cost. **In NumPy this is `c @ x` — one operation, and the whole objective is evaluated.**

**2. The dual LP** — Goemans again:

> "Given a linear program (P) in canonical form Max z = c^T x subject to (P) Ax <= b, x >= 0 we define its dual linear program (D) as Min w = b^T y subject to (D) A^T y >= c, y >= 0."

The dual vector `y` is the vector of **shadow prices** — the multiplier on each constraint. In federal terms (Trdlička & Hanzálek's dual decomposition), `y` is precisely what the centre broadcasts to provinces so they can optimize locally: **the vector structure of fiscal coordination.** See [[Network Flow Algorithms]].

**3. The MILP standard form** — Ling, Wang & Wang (AAAI-24):

> "A standard MILP takes the form of min_x {c^T x | Ax <= b, x_j in Z, for all j in I}"

Same inner-product objective; integrality restricted to a subset of indices.

**4. Multi-objective vectors and Pareto dominance** — Luna Rojas & Flores de la Mota (2022):

> "Minimize F(x) = [F_1(x), F_2(x), ..., F_k(x)]^T, x in R^n (16) subject to g_i(x) <= 0, i = 1,...,l (17); h_i(x) = 0, i = 1,...,m (18)"

The objective is now a **vector-valued function**; Pareto optimality compares such vectors coordinate-wise. No single scalar `c^T x` exists until weights are chosen — which is the political step (see [[Federation Research/Tradeoff With The Federation Resources Planning]]).

## The federal model as vector math

The synthesis formula from [[Federation Research/Translating Political Constraints to Algorithmic Rules]]:

```
T_i = α · Need(i) + (1-α) · CapacityGap(i) − Effort(i)
```

is, vectorized over all provinces:

```
T = α · need + (1-α) · (cap_std − cap) − effort
  subject to  Σ T_i = Pool,   T_i >= 0
```

Five NumPy operations on province-index vectors (`need`, `cap`, `effort`) — the entire transfer computation. **This is why vector math matters here: the federal formula is a small vector expression, and NumPy makes it a one-liner whose every step is auditable.** Numerical fairness (equal treatment of equal provinces) follows automatically from elementwise operations.

## Where NumPy sits in the toolchain *(external knowledge — verify)*

| Layer | Tool | Corpus support |
|---|---|---|
| Data | pandas / geopandas (spatial) | Bearman et al. 2023 stack |
| Vector math | **NumPy** | Bearman et al. 2023 (stack mention only) |
| Graph construction | NetworkX | **ABSENT** — see [[Graph Modeling with NetworkX]] |
| Optimization | PuLP/CBC, gurobipy, spopt | Bearman et al. 2023; van Willigen 2023 |
| Reproducible workflow | Jupyter Notebook | Bearman et al. 2023 |

## What the paper needs NumPy to do (honest scope)

Only four things:

1. **Vectorized formula evaluation** — `T = α*need + (1-α)*(cap_std-cap) - effort` across provinces
2. **Matrix/vector construction of LP inputs** — building `A`, `b`, `c` for PuLP from province data
3. **Distance computation** — van Willigen's Euclidean distances (`np.linalg.norm`) for the cost matrix `c_ij`
4. **Descriptive statistics across instances** — dispersion, per-capita ratios, coefficient of variation (as in Anisyah et al.'s archipelagic-province analysis)

No heavy numerical linear algebra is required — the solvers handle that internally. **NumPy's role is formula transparency, not computational power.**

## Numerical caution from the corpus

**Open University M373** flags the relevant failure mode, and it applies directly to vector arithmetic on fiscal data:

> "It is desirable to avoid very large or very small coefficients in the constraints. This is partly because the simplex method ... involves solving systems of linear equations based on the linear constraints, and we have seen in Unit I.3 how badly scaled systems can lead to poor numerical solutions."

And **Israel & Lund (1999)**: "Selecting arbitrarily large values, potentially resulting in a large range in the unit cost coefficients, also may induce scaling problems in some optimization algorithms."

When need/capacity/effort indicators have wildly different magnitudes (budget in billions, effort in percent), **normalization before combination is not optional** — or the formula silently amplifies whichever index has the biggest scale. Corroborated by two independent corpus sources.

## Related notes
- [[Resource Allocation with PuLP]] — where the vectors become a solved model
- [[Operations Research vs Machine Learning]] — surrogate models also live on NumPy
- [[Synthetic Data Generation]] — the vectors need values
- [[Modeling Federal Constraints & Penalties]] — scaling dangers in penalty coefficients
