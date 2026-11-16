---
title: FSD Current Detection Logic and Integration in Legacy Core and CMP
author: Gal Sahar
origin: Confluence, CATS space, page 4349263873
url: https://g2rs.atlassian.net/wiki/spaces/CATS/pages/4349263873/FSD+Current+Detection+Logic+and+Integration+in+Legacy+Core+and+CMP
page_updated: 2026-10-15
evidence_date: 2026-10-14
captured: 2026-11-16, pasted by Adi Geva from the Confluence page view
capture_notes: Confluence UI chrome (top bar, sidebar, reactions, "Related content" sidebar list) removed. Page body kept as pasted. Code and flow blocks re-fenced as code; table cells re-joined into rows. Diagrams, links and macros not captured.
---

# FSD Current Detection Logic and Integration in Legacy Core and CMP

By Gal Sahar. Updated Oct 15.

## Summary

Front Site Detection (FSD) assesses whether a merchant website may misrepresent the business behind it. The current implementation is the Suspectra service. It combines website content, WHOIS data, search results, LLM-extracted features, and CatBoost models to return a suspected-front-site finding with explanatory evidence.

There are two integration paths: legacy Core / MerchantView uses HTTP, while Core Merchant Pipeline (CMP) uses a Kafka worker. Both invoke the same analysis service. FSD needs crawled content; the full analysis endpoint does not crawl a website from a URL alone.

Evidence date: October 14, 2026. This page describes inspected source and deployment configuration. It does not establish the running cluster state, measured throughput, current accuracy, or final client-visible rendering. Suspectra source was inspected at revision a735ed0d3de3192f41af0fc94ca9195cab552cc0; legacy adapter source at 45b447fa81f6fa749f5d7842ac860dfb5107abb1. Production configuration inspected during the investigation referenced the Suspectra image suffix a735ed0.

## 1. The two pipeline integrations

| Area | Legacy Core / MerchantView | CMP |
|---|---|---|
| Trigger | FrontSite classifier worker after crawling / classification | Content-text Kafka message after text extraction |
| Enablement | Environment wrapper flag AND client front-site flag; skips OFFLINE or EMPTY_TEXT crawl results | Conditional processing flag front_site_detection, default false |
| Service boundary | HTTP POST /predict | Suspectra worker in SERVICE_MODE=kafka |
| Website content | Inline HTML and extracted homepage text | S3 paths to HTML and optional extracted text |
| Client and language | Supplied by the legacy caller | Preserved in the outer message if present, but not forwarded into the internal analysis request |
| Returned destination | Findings and text evidence merged into the legacy classification object and crawl results | Original scan message enriched with findings and published to the findings topic |
| Shared engine | AnalysisService.analyze(..., PipelineType.PIPELINE) | Same |

### Legacy flow

```
Legacy crawl and classification
  → Check environment flag, client flag, and crawl eligibility
  → Construct website-content payload
  → Suspectra POST /predict
  → Convert response to classifier findings and text evidence
  → Merge with existing classifier findings and crawl results
  → Continue the legacy scan pipeline
```

The caller supplies domain, account ID, language, homepage HTML, joined homepage text, homepage URL, special-page text, and selected existing finding IDs. The finding-ID selection defaults to 176 and 64 and is configurable. The active analysis path does not use these existing findings to change the model prediction.

The HTTP wrapper catches call failures and returns an empty response list, allowing the surrounding pipeline to continue. A missing FSD finding can therefore reflect a skipped or failed invocation.

Sources: legacy caller, HTTP wrapper, finding assembly.

### CMP flow

```
Crawl and text extraction
  → core-prod-fast-onboarding-content-text
  → Suspectra checks front_site_detection
  → Fetch HTML and optional text from S3
  → Construct internal analysis request
  → Run shared analysis service
  → Append findings to scan message
  → core-prod-fast-onboarding-findings
```

The configured production dead-letter topic is core-prod-fast-onboarding-content-text-dlt. This overrides the source default ending in -dlq.

Sources: CMP handler, CMP processor, production CMP settings.

## 2. Inputs and outputs

### HTTP input

POST /predict accepts one website's content:

```json
{
  "domain": "example.com",
  "main_page_url": "https://example.com",
  "main_page_html": "<html>...</html>",
  "main_page_text": "Extracted homepage text",
  "special_pages_content_text": "",
  "relevant_findings": [],
  "accountId": "client-account",
  "language": "en"
}
```

The first six fields are required by the request model. accountId defaults to "unknown"; language is optional. The model also accepts homepage HTML as a list, taking its first item, and special-page content as a dictionary of lists, flattening it to text.

The HTTP endpoint validates / normalizes the domain against the homepage URL and skips configured social/platform domains with a neutral result. CMP currently does not call that same validation function.

### CMP input

The required message fields are request_id, url, and url_meta.raw_html_path. url_meta.content_text_path is optional.

```json
{
  "request_id": "scan-request-id",
  "url": "https://example.com",
  "url_meta": {
    "raw_html_path": "s3://bucket/homepage.html",
    "content_text_path": "s3://bucket/homepage.txt"
  }
}
```

Other scan fields are allowed and passed through. This example shows the content contract; FSD enablement is additionally required in the scan flags.

### Analysis output

The HTTP response is a list:

```json
[
  {
    "finding_sub_type": 389,
    "score": 80,
    "evidence_text": "Explanation of suspicious indicators",
    "evidence_url": "https://example.com"
  }
]
```

The score is an outcome code, not a calibrated probability. Subtype 389 represents a suspected front-site result; other analysis outcomes use subtype 1012.

| Score | Meaning |
|---|---|
| 80 | Suspected front site after threshold and business filters |
| 70 | Below the category's model threshold |
| 12 | Parked-page early exit |
| 4 | Category excluded from positive detection |
| 3 | Unknown or missing business category |
| 2 | Above-threshold prediction suppressed by business filters |
| 1 | Processing error |
| 0 | Neutral result, such as empty HTML in CMP or domain validation in HTTP |

CMP adds finding_type: 18, classifier_origin: 40, and culture: "N/A" to each finding, then appends it to the existing findings array.

Absence of a suspected finding does not establish legitimacy: the website may have been skipped, excluded, insufficiently enriched, filtered, or affected by a processing failure.

Sources: request models, API handling, CMP output mapping, score definitions.

## 3. Shared detection logic

Parked-page check. An LLM evaluates domain and homepage text. A positive parked-page result returns score 12 and bypasses the remaining stages.

WHOIS enrichment. Retrieves registration information and derives days since creation / update, registration period, and a one-year-registration indicator.

Search enrichment. Makes two Google SERP queries: the quoted domain, and the domain restricted to social / reputation sites. Nimble requests ten results per query; Bright Data is attempted if Nimble fails.

Feature extraction. An LLM combines up to 50,000 characters of homepage text, search results, and social links extracted from HTML. It generates business category, transaction indicators, reputation and footprint signals, content inconsistencies, and other categorical features.

Model inference. Selects the applicable CatBoost ensemble, averages its predictions, and compares against the category threshold.

Business filtering. Suppresses excluded categories and certain above-threshold predictions.

Evidence. Generates an additional LLM explanation for suspected results; non-suspected results use the analysis summary or a fallback.

Archive and return. Attempts to save inputs and enriched analysis to S3, then returns the finding list.

The LLM client specifies Amazon Nova Pro through AWS Bedrock. Extractors execute sequentially, although the two SERP queries execute concurrently. Extractor exceptions are logged and processing can continue with incomplete features.

Sources: analysis service, feature extraction, search fallback, LLM client.

## 4. Models, thresholds, and exclusions

There are six trained CatBoost models in two groups of three. Model One serves physical retail. Model Two serves other mapped categories. Each group contains High Recall, Balanced, and High Precision variants; their predicted front-site probabilities receive equal weight.

For example, predictions of 0.78, 0.66, and 0.57 average to 0.67. The implementation rounds the average to two decimal places before comparing it with the threshold. This is probability averaging, not a majority vote on three binary decisions.

| Category eligible for positive detection | Ensemble | Threshold |
|---|---|---|
| PHYSICAL_RETAIL | Model One | 0.65 |
| HIGH_RISK_DIGITAL_B2B | Model Two | 0.66 |
| PASSIVE_DIGITAL_GOOD | Model Two | 0.86 |
| PAYMENT_PAGE_ONLY | Model Two | 0.65 |

Professional services, offline commercial services, regulated/restricted businesses, and insufficient-data categories are mapped but explicitly excluded, returning score 4 after inference. OTHER_DEFINED_BUSINESS and SOFTWARE_SERVICE are also listed for exclusion but are absent from the routing map, so they reach the unknown-category return first (score 3).

For otherwise eligible predictions above threshold:

- Missing all four WHOIS date features suppresses the finding.
- When both transaction fields are present, the site must have can_transact_money_immediately = YES, and its viability tier must not be MICRO_VALUE, INSUFFICIENT_DATA, or NOT_APPLICABLE.
- If either transaction field is absent, that transaction check is skipped.

The regular pipeline response exposes the outcome code, not raw model probability or category. The separate POST /predict_from_features endpoint returns a prediction object containing raw_prob and category, and bypasses upstream content extraction. POST /predict_parked_page provides the parked-page check separately.

Sources: ensemble implementation, predictor and filters, threshold file.

## 5. Persistence and scaling

Normal completed analyses attempt to save under:

```
s3://golden-data-currency-{environment}/front-site/{date}/{domain}_{timestamp}.json
```

The record contains the input, extracted features, prediction, and evidence. Save failures are logged without failing the finding response. Parked-page and other early exits bypass this archive, so archive counts alone do not measure all processed requests.

| Deployment | Scaling trigger | Configured production range | Timing |
|---|---|---|---|
| HTTP service | Prometheus count of available legacy classifier-front-site-priority replicas, multiplied by 0.5, across configured namespaces | 1–100 pods | 20-second polling; 120-second cooldown |
| CMP worker | Kafka lag on core-prod-fast-onboarding-content-text; lag threshold 10 | 1–100 pods | 30-second polling; 120-second cooldown |

The HTTP image starts four API worker processes per pod. These settings do not establish measured concurrency or throughput. CMP effective parallelism depends on topic partitions and consumer behavior; idle consumers are disabled in the scaling configuration.

Sources: archive writer, shared deployment values, HTTP production values, CMP production values, KEDA template.

## 6. Implementation gaps identified

These are static code findings. Their impact on production accuracy and the date each became active have not been measured.

| Finding | Current behavior and implication |
|---|---|
| Transaction feature name mismatch | Prompt outputs can_transact_money_immediately; trained-model feature lists expect can_transact_money_immediately_flag. The inspected path has no rename, so that model feature receives the missing-value fallback. The business filter reads the non-suffixed field. |
| Special-page content unused | Feature extraction always supplies "No special pages available," including when the HTTP caller sends special-page content. |
| CMP input context omitted | Internal analysis uses empty special-page text and relevant findings, account defaults to unknown, and language is not forwarded. |
| Empty homepage text accepted in CMP | HTML can be present while the optional extracted-text input is empty. The feature prompt then receives "No homepage text available"; the active pipeline does not derive homepage text from HTML. |
| Domain validation differs | HTTP calls domain validation / normalization; CMP directly invokes the shared analysis service. |
| Degraded extraction can look like a normal result | Extraction exceptions can lead to predictions with missing data or an unknown category instead of a top-level error. |
| HTTP metrics can hide error-coded findings | The endpoint can return score 1 in a normal response list; the metrics wrapper treats that returned list as success. |
| Delivery beyond the service needs verification | Legacy code merges findings and CMP publishes them, but final ingestion, client-specific filtering, and UI presentation were not traced end to end. |

Sources: feature extractor, feature prompt, model feature list, metrics.

## 7. Reported reduction in finding volume

A reported comparison fell from approximately 50 to 5 findings per 10,000 sites (0.5% to 0.05%), beginning roughly September 23–30, 2026. The samples came from diff clients, population, and all via legacy pipeline. No root cause has been confirmed.

The first comparison should count, for a healthy and affected batch:

- Sites submitted, FSD-enabled, and actually processed [V] - We didn't get -0-
- Completed results by outcome code, including missing / pending results.
- Suspected subtype 389 findings emitted by Suspectra.
- Corresponding findings ingested and visible to the client.
- Homepage-text coverage, WHOIS-date coverage, category distribution, enrichment errors, and deployed versions.

This separates reduced execution coverage, input degradation, decision suppression, and downstream loss. Replay previously flagged sites using retained inputs and enrichment data to isolate model / code changes from changed website data. Do not attribute the drop to the static defects above without a before/after comparison.

## Related documentation

- Suspect in Action — Authenticity FSD
- FSD User Guide / Operational Playbook
- Core X API — Legacy MV Alignment with Instant OB
- WebID Current Functionality and Integration with Atlas
