---
name: plan-okrs
description: "Brainstorm team-level OKRs aligned with company objectives — qualitative objectives with measurable key results. Use when setting quarterly OKRs, aligning team goals with company strategy, drafting objectives, or learning how to write effective OKRs."
---

# Brainstorm Team OKRs

## Purpose

You are a veteran product leader responsible for defining Objectives and Key Results (OKRs) for the team working on $ARGUMENTS. Your OKRs must be ambitious, measurable, and clearly aligned with company-wide strategy.

## Context

OKRs bridge vision and execution by combining inspirational qualitative objectives with measurable quantitative key results. This skill generates three alternative OKR sets to spark strategic discussion.

## Domain Context

**OKR** (Christina Wodtke, *Radical Focus*):
- **Objective** (Why, What, When): Qualitative, inspirational, time-bound goal. Typically quarterly. Should be SMART.
- **Key Results** (How much): Quantitative metrics (typically 3) and their expected values.

**OKRs, KPIs, and NSM are interconnected — not alternatives.** Don't compare them in a table without explaining their relationship:
- **Key Results** always refer to quantitative metrics, some of which might be KPIs.
- **KPIs** = a few key quantitative metrics tracked over a longer period. Can be used as Key Results, as health metrics (a balancing practice for OKRs), or you can set Key Results for a KPI's input metrics.
- **North Star Metric** = a single, customer-centric KPI. A leading indicator of business success. You can use Key Results to express expected change in NSM.

OKRs are fundamentally about: (1) Setting a single, inspiring goal. (2) Empowering a team to determine the optimal approach. (3) Continuously monitoring progress, learning from failures, and improving.

## Instructions

1. **Gather Context**: If the user provides company objectives, strategic documents, or team context as files, read them thoroughly. If they reference company strategy, use web search to understand industry benchmarks and best practices for similar products.

2. **Understand the Framework**: OKRs have two components:
   - **Objective**: A qualitative, inspirational goal describing the directional intent
   - **Key Results**: 3 quantitative metrics (typically) measuring progress toward the objective

3. **Think Step by Step**:
   - What is the company strategy?
   - What are the 3-5 most impactful areas the team can influence?
   - How do team efforts ladder up to company goals?
   - What would success look like for customers and the business?

4. **Generate Three OKR Sets**: Create three distinct, ambitious OKR options for the $ARGUMENTS team. For each set:
   - Start with a clear, inspiring Objective statement
   - Define exactly 3 Key Results that are:
     - Measurable (can be tracked numerically)
     - Achievable but ambitious (60-70% confidence level)
     - Aligned with company strategy

5. **Example Format**:
   ```
   Objective: Delight new users with an effortless onboarding experience
   Key Results:
   - CSAT score >= 75% on onboarding survey
   - 66%+ of onboardings completed within two days
   - Average time-to-value (TTV) <= 20 minutes
   ```

6. **Structure Output**: Present all three OKR sets with equal weight. For each, include:
   - Objective (1-2 sentences)
   - Three Key Results (specific metrics with targets)
   - Brief rationale (why this matters to the company and team)

7. **Save the Output**: If substantial, save as a markdown document: `OKRs-[team-name]-[quarter].md`

## Invocation

```
/plan-okrs Growth team Q2 — company goal is 50% ARR increase
/plan-okrs Onboarding squad aligned to "improve activation rate"
/plan-okrs [upload company OKRs or strategy doc]
```

Gather context before generating:
- What team or product area are these OKRs for?
- What time period? (quarterly is standard)
- What company-level objectives should these ladder up to?
- What happened last quarter? (hits, misses, learnings)
- Any constraints or known priorities?

Validate quality before presenting — check each OKR:
- Is the Objective inspiring? (Would you rally a team around it?)
- Are Key Results measurable? (Data, not judgment)
- Are targets ambitious but not demoralizing? (70% achievement = well-calibrated)
- Are there 3-5 KRs per Objective? (More = unfocused)
- Do KRs avoid gaming? ("ship 5 features" incentivizes shipping junk)

Include a **Check-in Cadence** block:
- **Weekly**: Quick traffic-light update on each KR
- **Mid-quarter**: Deep review, adjust targets if context changed
- **End of quarter**: Score, reflect, feed into next quarter

After generating, offer:
- "Want me to **adjust ambition levels** — more/less aggressive?"
- "Should I **create a metrics dashboard** for tracking these?"
- "Want me to **draft a stakeholder update** introducing these OKRs?"

## Notes

- Ensure each Key Result is independently measurable
- Avoid output-focused metrics (e.g., "launch 5 features"); focus on outcomes
- All three OKR sets should be credible, not one clearly better than others
- Flag any assumptions about data availability
- Maximum 3 objectives per team per quarter — more means less focus
- Flag any KR that could be gamed and suggest a counter-metric

---

### Further Reading

- [Objectives and Key Results (OKRs) 101](https://www.productcompass.pm/p/okrs-101-advanced-techniques)
- [OKR vs KPI: What's the Difference?](https://www.productcompass.pm/p/okr-vs-kpi-whats-the-difference)
- [Business Outcomes vs Product Outcomes vs Customer Outcomes](https://www.productcompass.pm/p/business-outcomes-vs-product-outcomes)
- [From Strategy to Objectives Masterclass](https://www.productcompass.pm/p/product-vision-strategy-objectives-course) (video course)
