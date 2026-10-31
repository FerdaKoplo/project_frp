# What is LP, Why is That Matter

> Source basis: `journals/algorithm/` — MIT 15.053 Tutorial 1 (Spring 2013); M373 *Linear programming – the basic ideas* (Open University); lpnotes310 (MIT 18.310, Goemans); AIMMS *Linear Programming Tricks* (Ch. 6); Vielma 2015 (MILP formulation techniques). See [[Summary of the Algorithmic Approach]].
## Definition

**MIT 15.053** gives the formal definition and the three components:

> "Formally, we use the term 'linear programming (LP)' to refer to an optimization problem in which the objective function is linear and each constraint is a linear inequality or equality." (slide 3)

> "Each optimization problem consists of three elements:
> • decision variables: describe our choices that are under our control;
> • objective function: describes a criterion that we wish to minimize (e.g., cost) or maximize (e.g., profit);
> • constraints: describe the limitations that restrict our choices for decision variables." (slide 3)

Non-negativity is part of the formulation, not an afterthought:

> "In most problems, the decision variables are required to be nonnegative, and this should be explicitly included in the formulation." (MIT 15.053, slide 9)

The complete worked LP from the same tutorial:

> "max z = 25x + 30y s.t. 50x + 24y ≤ 2400, 30x + 33y ≤ 2100, x ≥ 0, y ≥ 0." (MIT 15.053, slide 10)

## Why LP matters

MIT's two part answer:

> "LP has attracted most of its attention in optimization during the last six decades for two main reasons: Applicability: There are many real-world applications that can be modeled as linear programming; Solvability: There are theoretically and practically efficient techniques for solving large-scale problems." (MIT 15.053, slide 2)

**AIMMS** adds the practical corollary :

> "Since the fastest and most powerful solution methods are those for linear programming models, it is often advisable to use this format instead of solving a nonlinear or integer programming model where possible." (AIMMS, ch. 6, p. 63)

## Standard vs canonical — a naming trap

The two corpora use the same two words for opposite forms. **M373**: standard form is `Ax ⩽ b, x ≥ 0`, canonical form is `Ax = b`. **lpnotes310 (Goemans)**: canonical form is `Ax ⩽ b`, standard form is `Ax = b`. M373 flags the conflict itself:

> "Somewhat confusingly, the standard form is referred to as the canonical form in some texts." (M373, p. 16)

Reading either source, check which convention is in force before translating a formulation.
## Why formulation quality decides solvability

**Vielma (2015)** is the corpus's argument that *how* you write the LP matters as much as the model class:

> "A wide range of problems can be modeled as Mixed Integer Linear Programming (MIP) problems using standard formulation techniques. However, in some cases the resulting MIP can be either too weak or too large to be effectively solved by state of the art solvers."

An archipelagic federation with hundreds of islands, multiple tiers, and a multi-year horizon is exactly such a large-scale instance. Connects to [[Algorithmic Bottlenecks and NP-Hard Problems]].

## Reformulation tricks — the AIMMS toolkit

AIMMS ch. 6 catalogs the standard moves that keep a model linear:

- **Free variables**: split `x = x⁺ − x⁻`, both non-negative; then `|x| = x⁺ + x⁻`. (p. 64)
- **Minimax objective**: introduce `z` with `Σ_j c_kj x_j ≤ z ∀k` — the same epigraph trick that converts a worst-case fairness objective into linear constraints. (p. 66)
- **Fractional objective** (Charnes–Cooper): substitute `y_j = t·x_j` — relevant to ratio-based transfer efficiency measures. (p. 67, after Charnes & Cooper 1962)
- **Range constraints**: one constraint with both upper and lower bounds. (p. 68)
- **Chance constraints**: `Pr[Σ_j a_j x_j ≤ B] ≥ 1 − α` — "a linear probabilistic constraint or a linear chance-constraint… α is a specified constant fraction, typically denoting the maximum error that is allowed." (p. 71; first published by Charnes & Cooper 1959)

The chance-constraint move is the one that connects LP to the vault's uncertainty thread — see [[Modeling Federal Constraints & Penalties]] and [[Synthetic Data Generation]].

## LP within this vault

| Note | Role of LP |
|---|---|
| [[Spatial and Location-Allocation Models]] | p-median / MCLP / fixed-charge models are LPs or MILPs |
| [[Network Flow Algorithms]] | min-cost flow is an LP with combinatorial structure |
| [[Resource Allocation with PuLP]] | PuLP + CBC is the corpus's own open LP/MILP stack |
| [[Modeling Federal Constraints & Penalties]] | transfer formula is an LP; penalties are linear terms |
| [[Operations Research vs Machine Learning]] | LP is the OR side of the comparison |
| [[Graph Modeling with NetworkX]] | graph structure feeds the LP's constraint matrix |

LP's specific virtue is **auditability**: the model is a short list of linear identities that a non-specialist can read. The simplex method's geometry — hill-climbing along vertices — is the intuitive reason it solves reliably at scale. **M373** makes the point that the naive alternative is hopeless:

> enumerating vertices is a non-starter — a small instance already has on the order of 7×10⁹ basis systems to consider (M373, §7.3e)

The tractability is why the archipelagic model should stay linear wherever the politics allow it, every nonlinearity is a cost in solver time and in public legibility.
## Related notes
- [[Resource Allocation with PuLP]] — implementation surface
- [[Mixed-Integer Linear Programming]] — LP + integrality
- [[Algorithmic Bottlenecks and NP-Hard Problems]] — the large-scale reading
- [[Modeling Federal Constraints & Penalties]] — hard vs soft constraint logic
