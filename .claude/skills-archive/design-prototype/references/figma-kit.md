# Figma Design-Kit Patterns — design-prototype

How to import and use the design kit. Read when running `/design-prototype`. Kit file
key from `domains/<domain>/config.json` (tools.figma).

## Import the kit (via Figma MCP)
Pull the kit's: components + variants, states, and tokens (color, type, spacing,
radius, elevation). This is the allowed vocabulary — nothing outside it exists.

## Build the inventory first
Before rendering anything, produce an inventory:
- Every component + its variants and states.
- Every token, with its exact value.
Render ONLY from this inventory. An element not traceable to the inventory is an
invention -> gap, not a substitution.

## Fidelity
- Use exact token values — never approximate a color/spacing/font/radius.
- Match layout to the kit's frames pixel-for-pixel.
- A value the kit doesn't define is a GAP for the PM, not a default.

## Gap discipline
Anything not covered by the kit OR the requirements -> `prototype/gaps.md`, with
the specific question the PM must answer. Never guess copy, states, navigation,
defaults, or ordering.

## Verify
Delegate to `verify` before delivery: confirm every rendered element traces to a
real kit component and no value/behavior was introduced from outside a source.
