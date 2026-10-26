# Legacy → Target Architecture Patterns — atlas

Concept-level mapping between the legacy Grails monolith (`mvserver`) /
first-gen Spring Boot (`merv-*`) and the target platform (`mlrc-*`), and
between the legacy Angular UI (`merchantviewui`) and the target React UI
(`marketview-portal`). Use this to translate legacy behavior into target-
platform terms during `/target-platform`, not to invent target behavior — confirm
against the actual `mlrc-*` source before asserting a pattern holds for a
specific feature.

## Backend: Grails → Spring Boot
| Legacy concept | Target equivalent |
|---|---|
| Grails `@Controller` (Groovy) | Spring Boot `@RestController` (Java) |
| Grails `def service` injection | Spring `@Autowired` / constructor injection |
| Grails `Domain` class (`grails-app/domain/`) | JPA `@Entity` (`shared/` module) |
| Grails `static constraints {}` | Bean validation annotations (`@NotNull`, `@Size`, ...) |
| Grails `static hasMany` / `belongsTo` | JPA `@OneToMany` / `@ManyToOne` |
| Grails `Service` (`grails-app/services/`) | `@Service` class in `service/` |
| Grails `render json:` | `ResponseEntity<T>` from controller |
| Grails `params.get('id')` | `@PathVariable String id` |
| Grails `request.JSON` | `@RequestBody CreateXxxRequest request` |
| Grails `UrlMappings.groovy` | `@RequestMapping` / `@GetMapping` etc. |
| GORM dynamic finders (`Merchant.findByX`) | Spring Data JPA repository methods / `@Query` |
| Domain rendered directly as JSON (anti-pattern) | MapStruct `@Mapper` (entity ↔ DTO) |
| `try/catch` + `render status: 500` | `@RestControllerAdvice` + `@ExceptionHandler` |
| Grails integration test (Spock, `*Test.groovy`) | `@SpringBootTest` + `*IT.java` |
| `MerchantViewServerAPI/grails-app/controllers/v4/` | `mlrc-*/api/src/main/java/.../controller/` |
| `MerchantViewServerAPI/grails-app/services/` | `mlrc-*/api/src/main/java/.../service/impl/` |
| `merv-global-services` pattern | `mlrc-*` pattern — same layers, cleaner module boundaries |

Path examples for a controller/service/entity/repository/mapper/validation/
error-handling walkthrough: see the original code samples folded from
`architecture-mapping.md` if a concrete before/after is needed for a specific
capability — ask the domain PM if the full code-level examples should be
restored here; kept out of this index to stay lean per repo convention.

## Frontend: Angular → React
| Legacy Angular (`merchantviewui`) | Target React (`marketview-portal`) |
|---|---|
| `@Component({ selector: '...' })` | `function MyComponent(props)` |
| `@Injectable() Service` | Custom hook `useXxx()` or `api-clients/` |
| `HttpClient.get<T>(url)` | `fetch(url)` or generated API client |
| `ngOnInit()` | `useEffect(() => {}, [])` |
| `@Input()` | Props |
| `@Output()` | Callback props |
| `*ngIf` | `{condition && <Component />}` |
| `*ngFor` | `.map()` |
| `BehaviorSubject<T>` | `useState<T>` / `useReducer` |
| `RouterModule` | React Router |
| Angular service DI | Context API or React Query |

## How to use this during reverse-engineering
- `/legacy-analyze` on `mvserver`/`merv-*`/`merchantviewui` produces the
  behavioral spec in legacy terms.
- `/target-platform` uses this table to locate the target-platform file that
  should carry the equivalent behavior, then verifies against the actual
  `mlrc-*`/`marketview-portal` source — this table is a starting map, not a
  substitute for reading the target code.
- Full repo → feature path index: `repo-feature-map.md`.
