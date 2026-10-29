# Translating Political Constraints to Algorithmic Rules

> Source basis: Haque et al. 2026 Box 11; Simandjuntak 2018; Al-Samarrai & Lewis 2021; Ter-Minassian 1997; Simonov n.d.; OECD 2013; Allain-Dupré 2020. See [[corpus_profile]].

The final operation: turn the political constraints documented across this vault into **transfer formulas that a government can actually run**. Formula design is not technical aftermath — it is where political economy either gets encoded or excluded.

## The core insight: formulas are frozen politics

Every formula is a political settlement written in numbers.

- **Indonesia DAU** weights (population, land area, waters) decide who wins (Simandjuntak 2018; Al-Samarrai & Lewis 2021)
- **Sudan FFAMC** criteria reward own-revenue surplus — the formula *encodes* the politics of rewarding strong states
- **Philippines IRA** (50/25/25) ignores cost dispersion — the formula encodes the politics of simplicity over equity
- **Pakistan NFC** formula lacks "meaningful incentives for provincial revenue effort or service delivery performance" — encoding the politics of dependency (Haque et al. 2026)

**Haque et al. (2026) Box 9** states the general problem:

> "higher levels of government have strong reasons to retain control over fiscal resources... control over money enables the mobilization and maintenance of political support... predictability, strict rule-based allocation, and strong oversight can reduce discretion, contradicting political imperatives."

## The template: Pakistan Box 11 as canonical algorithm

Box 11 is the corpus's most complete translation of politics into a replicable algorithm:

> "The design of a fiscal equalization program for Pakistan must be simple, objective, transparent, easy to understand, and based on publicly available data verified by federal and provincial authorities. Any official or private citizen must be able to easily duplicate calculations done by the NFC Secretariat."

Its proposed two-component structure:

1. **Fiscal capacity equalization** — equalize the *ability to raise revenue*
2. **Fiscal need equalization** — equalize the *cost of delivering services*

The discipline: **inputs must be publicly verifiable and the computation replicable by any citizen.** Complexity is a failure mode, not sophistication — see [[Systemic Risks & Failure Modes in Developing Federations]] F3.

## The architecture: differentiation without fragmentation

**Simonov** states the design principle for heterogeneous regions:

> "The proposed three-level architecture combines a common federal accountability core, profile-specific modules, and project-level adaptive coordination. Its central principle is that policy unity should rest on common rules of justification, measurement, and review, whereas instruments and additional indicators should reflect the diagnosed regional problem. Under these conditions, differentiation is not a concession to fragmentation. It is a mechanism for substantive equality, institutional learning, and politically accountable federal governance."

The **common core / regional modules** split is exactly what an archipelagic federation needs: one national accountability rulebook; archipelagic modules carrying cost-of-provision, connectivity, and dispersion indicators.

> "A formally uniform policy instrument may create dissimilar incentives and may distribute benefits and costs among different constituencies. Regional heterogeneity is therefore not merely an external condition to be corrected after a policy is designed; it is part of the policy problem itself."

## The constraints (from politics) → the rules (in the formula)

| Political constraint (evidence) | Algorithmic translation |
|---|---|
| Elite capture of complex formulas (Sudan FFAMC) | Simplicity + full replicability (Haque Box 11) |
| Mainland bias via population/land weights (Indonesia DAU) | **Cost-of-provision index** including connectivity, dispersion, climate exposure |
| Transfer dependence crowding out local effort (Indonesia, Pakistan) | Equalization cap < 100% of spending; own-revenue effort term in formula |
| Fixed-pool zero-sum resistance (Simandjuntak 2012 simulation) | Grow the pool with revenue growth; phase in weights; compensate terrestrial losers transparently |
| Veto players reversing reform (Karapin 2020) | Constitutional entrenchment of formula; OECD-style verifiable contracts across tiers |
| Fragmentation of tax base (Pakistan 18th Amendment; Nigeria) | Uniform base definition + harmonized administration, rates differentiated narrowly |
| Volatility pushed down the chain (Pakistan §5.2.1) | Multi-year transfer ceilings published in advance; formula-based (not ad hoc) releases |

## OECD conditionality rules

**OECD (2013)** on how rules bind across tiers:

> "Conditionalities should be evidence-based, observable, allowing for process and ex post verification. Any enforcement mechanisms must be credible, taking due account of the political and institutional realities of the situation."

> "To overcome fragmented structures and to clarify the assignment of responsibilities across levels of governments, contracts need to be not only credible, but verifiable commitments."

**Allain-Dupré (2020)** on managing coordination cost: "clarity in the assignment and objectives, trust, the establishment of adequate incentives, contractual arrangements, arbitration mechanisms, can help limit the costs and maximise the benefits of coordination."

## The resulting algorithm (synthesis)

For an archipelagic federation, the literature converges on this structure:

```
T_i = α · Need(i) + (1-α) · CapacityGap(i) − Effort(i)

  Need(i)      = f(population, dispersion_index, connectivity_cost, climate_exposure)
  CapacityGap  = standard_fiscal_capacity − own_revenue_capacity(i)
  Effort(i)    = own_revenue collection rate (rewards local effort)
  α            = legislated weight, entrenched constitutionally
  Pool         = fixed share of national revenue growth (not fixed nominal pool)
```

Design rules: all inputs publicly verifiable; any citizen can replicate the calculation; weights legislated; asymmetric archipelagic modules apply only where dispersion/connectivity diagnostics warrant them (Simonov architecture).

## Relation to this vault

This note is the **synthesis point**: it applies [[Mechanisms of Federal Resource Distribution]] under the conditions of [[How Federation Resources Planning Affected Archipelagos Nation]], respecting [[Tradeoff With The Federation Resources Planning]] and guarding against [[Systemic Risks & Failure Modes in Developing Federations]] to raise the [[Chance of Economic Development With Federation Resources Planning]].
