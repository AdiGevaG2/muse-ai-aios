import fs from 'node:fs/promises';
import path from 'node:path';
import { Presentation, PresentationFile } from '/Users/adig/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/@oai/artifact-tool/dist/artifact_tool.mjs';
import { finalizePresentation } from '/Users/adig/.codex/plugins/cache/openai-primary-runtime/presentations/26.1015.12040/skills/presentations/container_tools/artifact_tool_utils.mjs';

const root='/Users/adig/vsCode/muse-ai-os/outputs/nab-roadmap';
const skill='/Users/adig/.codex/plugins/cache/openai-primary-runtime/presentations/26.1015.12040/skills/presentations';
const repo='/Users/adig/vsCode/code-repos-git/unified-platform-new/marketview-portal';
const p=Presentation.create({slideSize:{width:1280,height:720}});
p.theme.defaultFont='Inter';
const C={navy:'#09193D',blue:'#1447E6',light:'#EEF1FF',ink:'#181D27',muted:'#535862',line:'#D5D7DA',white:'#FFFFFF',green:'#067647',amber:'#B54708'};
const board='https://everc.monday.com/boards/18424866954';
const mix='https://mixpanel.com/project/2040581/view/187351/app/boards#id=11594386';
const logo=await fs.readFile(repo+'/src/resources/assets/images/g2-logo.svg');
const notesBase=`Evidence checked 18 October 2026. Monday: ${board}. Board Q4 group is named "Q4 - end of Feb.27". Use February 2027 as the board planning horizon, not December 2026. PRD ETA is not a delivery date. No release or NAB production entitlement was verified. Code inspection is read-only and uses the local develop checkout at ${repo}, HEAD d778d729 dated 11 June 2026, including current working tree files. Local code may lag the board or contain uncommitted work. G2RS branding: original g2-logo.svg from that checkout, colors from g2rs-design-system/src/tokens/tokens.css, Inter from design-system/tokens/typography.json.`;
function box(s,x,y,w,h,fill){return s.shapes.add({geometry:'rect',position:{left:x,top:y,width:w,height:h},fill,line:{fill:'none',width:0}});}
function text(s,txt,x,y,w,h,size=26,color=C.ink,bold=false){const t=box(s,x,y,w,h,'none');t.text=txt;t.text.style={typeface:'Inter',fontSize:size,color,bold};return t;}
function line(s,x,y,w,color=C.line){box(s,x,y,w,1,color);}
function base(title,num,sub=''){const s=p.slides.add();s.background.fill=C.white;s.images.add({blob:logo.buffer.slice(logo.byteOffset,logo.byteOffset+logo.byteLength),contentType:'image/svg+xml',alt:'G2 Risk Solutions',position:{left:72,top:36,width:144,height:36},fit:'contain'});text(s,title,72,112,1136,62,43,C.navy,true);if(sub)text(s,sub,72,182,1136,38,20,C.muted);line(s,72,655,1136);text(s,'NAB roadmap   /   18 October 2026',72,670,900,25,14,C.muted);text(s,String(num).padStart(2,'0'),1160,670,48,25,14,C.muted);s.speakerNotes.text=notesBase;return s;}
function foot(s,t){text(s,t,72,607,1136,37,16,C.muted);}
function table(s,values,widths,top=240,rowH=65){const tb=s.tables.add({rows:values.length,columns:values[0].length,left:72,top,width:1136,height:values.length*rowH,columnWidths:widths,values});tb.borders.assign({fill:C.white,width:0});for(let r=0;r<values.length;r++){tb.rows[r].height=rowH;for(let c=0;c<values[0].length;c++){let cell=tb.getCell(r,c);cell.fill=r===0?C.navy:(r%2?C.light:C.white);cell.text.style={typeface:'Inter',fontSize:r===0?18:21,bold:r===0||c===0,color:r===0?C.white:C.ink};}}return tb;}

// 1. Cover
{
const s=base('NAB roadmap',1);text(s,'MerchantView today\nAtlas through Q4',72,240,1000,170,57,C.navy,true);
box(s,72,468,90,6,C.blue);text(s,'Q4 target: end of February 2027',72,505,1070,48,28,C.blue,true);
foot(s,'Planning horizon follows the Monday board');
s.speakerNotes.text+=`\nPurpose: explain NAB's observed MV work, developed Atlas capabilities, remaining Q3 scope, and NAB-tagged Q4 plans. Done means Monday marks the epic Done, not a deployment guarantee.`;
}
// 2. Actual usage
{
const s=base('NAB uses MV to review and action findings',2,'Observed customer activity over the last 3 months');
const metrics=[['1,696','Reviewer notes added'],['1,458','Evidence reviews'],['1,424','Status submissions']];
metrics.forEach(([n,l],i)=>{let x=72+i*390;text(s,n,x,262,350,88,66,C.blue,true);text(s,l,x,359,350,50,24,C.navy,true);});
line(s,72,443,1136);text(s,'Merchant operations',72,475,300,42,25,C.navy,true);text(s,'Bulk uploads\nUnderwriting starts\nMerchant deboarding',430,472,610,110,25);
foot(s,'77 bulk confirmations   /   52 underwriting submissions   /   182 deboarding submissions');
s.speakerNotes.text+=`\nSources: ${mix}; local outputs/nab-mv-usage/nab-mv-event-usage.csv. Dashboard filters Customer=NAB, Is Customer=True; rolling last 3 months, checked 18 October 2026. Counts match findings_grid_finding_log_note_add=1696, findings_grid_review_evidence=1458, findings_grid_status_apply=1424, add_merchant_bulk_confirm=77, PM_PV_underwriting_start_apply=52, portfolio_merchant_deboard_apply=182. Counts are recorded events, not unique cases or confirmed successful outcomes. Event descriptions are inferred from event names. Usage does not establish every MV capability or NAB requirement.`;
}
// 3. Developed scope
{
const s=base('Atlas has built the core monitoring workflow',3,'Monday marks 14 of 26 NAB Q3 items Done');
const groups=[['Merchant operations','Single and bulk merchant addition\nMonitoring controls and merchant status\nMerchant list and portfolio hierarchy'],['Finding review','Investigation and resolution\nMerchant and finding comments\nSnooze and reactivation'],['Investigation and reporting','Connected sites and graph\nMerchant risk summary and MMP reports\nInternal review and batch release']];
groups.forEach(([h,b],i)=>{let x=72+i*390;box(s,x,251,54,5,C.blue);text(s,h,x,281,352,80,28,C.navy,true);text(s,b,x,383,352,189,23);});
foot(s,'Board status: Done. Local code corroborates core flows. NAB production availability needs validation.');
s.speakerNotes.text+=`\nMonday NAB-tagged Q3 Done epics, all 14: Merchant Monitoring Controls; Merchant Risk Summary Report; Merchant List View Enhancements; Add Merchant & Finding Comments; Finding Investigation and Resolution; MMP Report; Snooze and Reactivate Risk Work; Platform Hierarchy - Organization/Portfolio/Merchant; Merchant Status; Add Bulk Merchant (Monitoring); Add Single Merchant (Monitoring); Connected Sites / Graph; Batch Release; Internal Finding Review. Counts exclude MCC Mismatch for PayPal in GO because its NAB field is empty. Code corroboration: src/features/merchantTab/services/merchantService.ts createMerchant, generateUploadUrl, searchPortfolioMerchants, listBulkUploads and results downloads; src/features/MerchantDetails/services/findingService.ts getFindingsByMerchant and updateFindingStatus; src/features/MerchantDetails/hooks/useUpdateFindingStatus.ts mutation and success/error handling; src/features/MerchantDetails/Drawer/tabs/EvidencePopup/EvidencePopup.tsx screenshot gallery and status selector; src/services/CommentService.ts get/post finding comments; src/services/ReportsService.ts list/create reports. The checked code is corroboration for those named core flows, not independent proof of all 14 epic completion claims.`;
}
// 4. Open scope, grouped without treating Q3 as completed
{
const s=base('Twelve NAB Q3 items remain open',4,'Existing roadmap scope that still needs completion');
table(s,[['Status','NAB scope'],['In development (7)','Analyst assignment, URL report, activity log\nPolicies MVP, UI, cross-product API, disputes'],['Ready for development (3)','Full MCC parity MVP, add-merchant wizard, WebID'],['Partially done (1)','User management'],['Dependency (1)','Billing report']],[350,786],237,70);
foot(s,'Q3 grouping does not mean delivered. Sprint labels and PRD dates do not establish release dates.');
s.speakerNotes.text+=`\nMonday NAB Q3 has 26 tagged epics: 14 Done, 7 In Progress - Dev, 3 Ready for Dev, 1 Partially Done, 1 Dependency. In Progress - Dev: Assign Analyst to Merchant; URL Level Report; Merchant & Finding Activity Log (aka Audit Trail); Policies - MVP; UI Enhancements; API - Cross Product; Finding Dispute and Reassessment (Q3). Ready for Dev: Full MCC Parity - MVP; Wizard for Add Merchant (Part of Onboarding UI/UX) - MVP; WebID (Q3). Partially Done: Users Management. Dependency: Billing Report. Separate Q3/Q4 entries for WebID and disputes represent separate board scope, not duplicate completed features. No completion date inferred.`;
}
// 5. Specific Q4 board scope
{
const s=base('Five NAB items target the end of Q4',5,'Board horizon: end of February 2027');
table(s,[['Planned scope','Current status','Team'],['Finding disputes and reassessment','In development','Rocket'],['WebID','Ready for development','Rocket'],['Identifier data mismatches','Product definition','Horizon'],['Client data migration','Status unset','Rocket'],['Website policy assessment','Product definition','Horizon']],[540,390,206],236,59);
foot(s,'All five carry the NAB flag. Delivery dates and migration readiness remain unconfirmed.');
s.speakerNotes.text+=`\nNAB view shows exactly five Q4 epic/workflows, all Must and NAB checked: Finding Dispute and Reassessment (Q4): In Progress - Dev, Rocket, PRD ETA Nov 2; WebID (Q4): Ready for Dev, Rocket, PRD ETA Oct 13; Mismatch of Identifier Data: In Progress - PM, Horizon, PRD ETA Oct 13; Client Data Migration: status unset, Rocket, PRD ETA empty; Website Policies (Website Compliance Assessment): In Progress - PM, Horizon, PRD ETA Nov 9. Product definition is a plain-language rendering of In Progress - PM. PRD dates intentionally omitted from timeline because they are not feature release dates. The slide expresses planned board scope, not a delivery commitment. Web Traffic and MCC Enhancements sit elsewhere in Q4 but have empty NAB fields, so they are not added to this NAB-specific commitment set.`;
}
// 6. Roadmap framing with explicit proposed acceptance
{
const s=base('NAB migration depends on workflow acceptance',6,'Planning sequence, subject to release and NAB validation');
const cols=[['TODAY','MerchantView','Review evidence\nRecord decisions and notes\nManage merchant portfolios'],['REMAINING Q3 SCOPE','Atlas workflow completion','Close the 12 open items\nValidate NAB workflows\nConfirm production access'],['Q4 TARGET: FEB 2027','Atlas migration scope','Deliver the five Q4 items\nValidate migrated data\nAgree the NAB cutover']];
cols.forEach(([label,h,b],i)=>{let x=72+i*390;box(s,x,252,350,5,i===2?C.blue:C.line);text(s,label,x,278,350,40,17,C.blue,true);text(s,h,x,335,350,96,30,C.navy,true);text(s,b,x,449,350,125,23);});
foot(s,'Proposed acceptance: evidence, decisions, notes and merchant records pass NAB review before cutover');
s.speakerNotes.text+=`\nPM synthesis, not additional Monday commitments: use current MV workflows as acceptance cases; complete and validate remaining NAB Q3 scope, then validate Q4 scope and data migration before an agreed cutover. No exact sequence between the five Q4 development items or month-level milestones is stated by the inspected board. The roadmap columns are a planning sequence and do not promise dates for the 12 open Q3 epics. Workflow acceptance and a cutover decision are proposed PM gates, not board-verified assigned tasks. Confirm deployment status, release schedule, owners, data migration coverage, and NAB sign-off before promising migration readiness. Source baseline: ${mix}, ${board}, and local source files cited on slide 3.`;
}

await fs.mkdir(root+'/deliverables',{recursive:true});
await fs.mkdir(root+'/.build/previews',{recursive:true});
for(let i=0;i<p.slides.items.length;i++){const blob=await p.export({slide:p.slides.items[i],format:'png',scale:1});await fs.writeFile(root+`/.build/previews/slide-${i+1}.png`,new Uint8Array(await blob.arrayBuffer()));}
const draft=root+'/.build/draft.pptx';
await (await PresentationFile.exportPptx(p)).save(draft);
const final=root+'/deliverables/NAB-roadmap-Q4.pptx';
const result=await finalizePresentation({workspaceDir:root,candidatePath:draft,finalPath:final,pythonExecutable:'/Users/adig/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/bin/python3',integrityValidatorPath:skill+'/container_tools/inspect_presentation_package_integrity.py',layoutValidatorPath:skill+'/container_tools/inspect_presentation_layout_geometry.py',layoutArgs:['--expected-slide-size-emu','12192000,6858000','--validate-heading-fit','--require-native-table-slide','4','--require-native-table-slide','5'],fontPolicy:{basis:'design',families:['Inter']},requiredNativeTableOwnerSlides:[4,5],explicitTotalSlideCount:6,verifyArtifactToolImport:true,receiptPath:root+'/.build/validation.json'});
console.log(JSON.stringify(result));
