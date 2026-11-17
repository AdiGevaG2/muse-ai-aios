import csv, sys, collections

d = sys.argv[1]
cats = {}
with open(f"{d}/categories.csv") as f:
    r = csv.reader(f); next(r)
    for row in r:
        if row and row[0]:
            cats[int(float(row[0]))] = (row[1], row[2])

auto = collections.Counter(); manual = collections.Counter()
with open(f"{d}/mv_fst_90d.csv") as f:
    r = csv.reader(f); next(r)
    for row in r:
        if not row or not row[0]:
            continue
        fst = int(float(row[0])); n = int(float(row[2] or 0))
        (manual if row[1] == "Yes" else auto)[fst] += n

seen = set(auto) | set(manual)
print("catalog categories:", len(cats), "| categories with MV findings (90d):", len(seen))
print("auto-only:", sum(1 for c in seen if auto[c] and not manual[c]),
      "| both:", sum(1 for c in seen if auto[c] and manual[c]),
      "| manual-only:", sum(1 for c in seen if manual[c] and not auto[c]))
print("total findings auto:", sum(auto.values()), "manual:", sum(manual.values()))
print("seen but not in catalog:", sorted(seen - set(cats))[:40])

out = f"{d}/mv_category_activity_90d.csv"
with open(out, "w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["category_id", "name", "category_type", "mv_auto_findings_90d", "mv_manual_findings_90d", "status"])
    for c in sorted(set(cats) | seen):
        name, typ = cats.get(c, ("?", "?"))
        a, m = auto[c], manual[c]
        status = "auto" if a else ("manual-only" if m else "none")
        w.writerow([c, name, typ, a, m, status])

bytype = collections.defaultdict(lambda: collections.Counter())
for c, (name, typ) in cats.items():
    s = "auto" if auto[c] else ("manual-only" if manual[c] else "none")
    bytype[typ][s] += 1
print("\nby category type (catalog): type | auto | manual-only | none")
for typ, cnt in sorted(bytype.items(), key=lambda x: -sum(x[1].values())):
    print(f"{typ} | {cnt['auto']} | {cnt['manual-only']} | {cnt['none']}")

print("\nspot checks:")
for c in [59, 61, 76, 165, 186, 187, 188, 189, 197, 235, 1010, 1011, 1021, 1100, 1101, 1102, 1103]:
    print(c, cats.get(c, ("?", "?"))[0], "auto", auto[c], "manual", manual[c])

print("\nmanual-only categories:")
for c in sorted(c for c in seen if manual[c] and not auto[c]):
    print(c, cats.get(c, ("?",))[0], manual[c])
