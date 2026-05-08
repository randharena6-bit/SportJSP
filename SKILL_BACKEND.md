---
name: backend-pro-max
description: "Backend development intelligence for scalable APIs and services. Includes 40+ architectural patterns, 99 API design guidelines, 57 database optimization rules, 25 security best practices, 30 caching strategies, and 20 deployment patterns across 8 technology stacks (Node.js/Express, Java/Spring Boot, Python/FastAPI, Go, PHP/Laravel, C#/.NET, Ruby on Rails, Rust). Actions: design, implement, review, optimize, secure, test, deploy, scale, refactor backend systems. Systems: REST APIs, GraphQL, microservices, monoliths, serverless, event-driven. Elements: authentication, authorization, caching, rate limiting, logging, monitoring, queuing, search. Patterns: MVC, layered architecture, clean architecture, CQRS, event sourcing, saga pattern. Topics: database design, API versioning, security, performance, scalability, testing, CI/CD, observability."
---

# Backend Pro Max - Development Intelligence

Comprehensive backend development guide for building scalable, secure, and maintainable APIs and services. Contains 40+ architectural patterns, 99 API design guidelines, 57 database optimization rules, 25 security best practices, and 30 caching strategies across 8 technology stacks.

## When to Apply

This Skill should be used when the task involves **API design, database architecture, server logic, security implementation, performance optimization, or backend infrastructure**.

### Must Use

This Skill must be invoked in the following situations:

- Designing new APIs (REST, GraphQL, WebSocket, gRPC)
- Creating or refactoring database schemas and queries
- Implementing authentication/authorization systems
- Setting up caching strategies and rate limiting
- Reviewing backend code for security vulnerabilities
- Designing microservices or service decomposition
- Optimizing database performance and query efficiency
- Implementing event-driven architecture or message queues
- Setting up logging, monitoring, and observability
- Building ETL pipelines or background job processing

### Recommended

This Skill is recommended in the following situations:

- API response times feel "slow" but root cause is unclear
- Database queries taking longer than expected
- Need to choose between SQL vs NoSQL, monolith vs microservices
- Reviewing code for security best practices
- Pre-production security audit and hardening
- Scaling backend to handle increased load
- Migrating between technology stacks or databases

### Skip

This Skill is not needed in the following situations:

- Pure frontend/UI development without API changes
- Infrastructure-only work (Terraform, pure networking)
- Static website deployment without backend logic
- Documentation-only updates
- Non-technical project management tasks

**Decision criteria**: If the task changes how data is **stored, processed, transmitted, or secured**, this Skill should be used.

## Rule Categories by Priority

| Priority | Category | Impact | Domain | Key Checks (Must Have) | Anti-Patterns (Avoid) |
|----------|----------|--------|--------|------------------------|------------------------|
| 1 | Security | CRITICAL | `security` | Input validation, SQL injection prevention, XSS protection, CSRF tokens, rate limiting | Plain text passwords, no input sanitization, missing auth on endpoints |
| 2 | Data Integrity | CRITICAL | `database` | Transactions, foreign key constraints, optimistic locking, audit trails | No constraints, lost updates, race conditions, missing soft deletes |
| 3 | API Design | HIGH | `api` | REST conventions, versioning, pagination, idempotency, HTTP status codes | Inconsistent naming, no versioning, giant payloads, no rate limits |
| 4 | Performance | HIGH | `performance` | Query optimization, indexing, N+1 prevention, caching strategy, connection pooling | Full table scans, N+1 queries, no caching, memory leaks |
| 5 | Scalability | HIGH | `scalability` | Stateless design, horizontal scaling, async processing, circuit breakers | Session affinity, blocking operations, no backpressure handling |
| 6 | Observability | MEDIUM | `monitoring` | Structured logging, metrics, distributed tracing, health checks | No logs, no monitoring, silent failures, missing alerts |
| 7 | Maintainability | MEDIUM | `code` | Clean architecture, SOLID principles, DRY, meaningful naming | Spaghetti code, god classes, tight coupling, magic numbers |
| 8 | Testing | MEDIUM | `testing` | Unit tests, integration tests, contract tests, load testing | No tests, flaky tests, testing implementation not behavior |
| 9 | DevOps | MEDIUM | `devops` | CI/CD, infrastructure as code, blue-green deployments, rollback | Manual deployments, no environment parity, no rollback plan |
| 10 | Documentation | LOW | `docs` | API documentation (OpenAPI), architecture decision records (ADRs), README | Undocumented APIs, missing setup instructions |

## Quick Reference

### 1. Security (CRITICAL)

- `input-validation` - Validate and sanitize ALL user inputs (never trust client)
- `sql-injection` - Use parameterized queries/ORM; never concatenate SQL strings
- `xss-protection` - Escape output, use Content Security Policy (CSP)
- `csrf-tokens` - Implement CSRF protection for state-changing operations
- `rate-limiting` - Apply rate limits per IP/user (e.g., 100 req/min default)
- `authentication` - Use JWT, OAuth 2.0, or session-based auth; never roll your own crypto
- `authorization` - Implement RBAC/ABAC; verify permissions on every request
- `password-security` - Hash with bcrypt/Argon2 (not MD5/SHA1); min 12 chars
- `encryption` - Encrypt sensitive data at rest (AES-256) and in transit (TLS 1.3)
- `secrets-management` - Never hardcode secrets; use vaults (HashiCorp Vault, AWS Secrets Manager)
- `dependency-scanning` - Regularly scan for vulnerable dependencies (Snyk, Dependabot)
- `security-headers` - Use HSTS, X-Frame-Options, X-Content-Type-Options
- `cors-policy` - Configure CORS explicitly; avoid `*` in production
- `file-upload-security` - Validate file types, scan for malware, store outside web root
- `api-key-security` - Rotate keys regularly, use separate keys per environment

### 2. Data Integrity (CRITICAL)

- `acid-transactions` - Use transactions for multi-step operations
- `foreign-key-constraints` - Enforce referential integrity at database level
- `optimistic-locking` - Use version numbers to prevent lost updates
- `soft-deletes` - Never hard delete; use `deleted_at` timestamp
- `audit-trail` - Log who changed what and when (created_by, updated_by, timestamps)
- `data-validation` - Validate at application AND database level
- `unique-constraints` - Enforce uniqueness in DB, not just application
- `cascade-rules` - Define ON DELETE/UPDATE behavior explicitly
- `normalization` - 3NF for OLTP; denormalize selectively for read performance
- `null-handling` - Be explicit about NULL vs empty string vs default value

### 3. API Design (HIGH)

- `rest-conventions` - Use proper HTTP methods (GET, POST, PUT, PATCH, DELETE)
- `http-status-codes` - Return appropriate codes (200, 201, 400, 401, 403, 404, 409, 422, 500)
- `resource-naming` - Use plural nouns (/users, /orders), kebab-case
- `api-versioning` - Version in URL (/v1/users) or header (Accept-Version: v1)
- `pagination` - Always paginate lists (limit/offset or cursor-based)
- `idempotency` - POST should be idempotent with Idempotency-Key header
- `content-negotiation` - Support JSON (default), optionally XML/MsgPack
- `error-format` - Consistent error format: { "error": { "code": "...", "message": "...", "details": [...] } }
- `field-selection` - Support ?fields=id,name,email to reduce payload
- `filtering` - Support query parameters: ?status=active&created_after=2024-01-01
- `sorting` - Support ?sort=-created_at (minus for descending)
- `embedding` - Support ?embed=comments,author for related data
- `rate-limit-headers` - Return X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset
- `api-documentation` - Document with OpenAPI 3.0; use Swagger UI
- `backward-compatibility` - Never break existing clients; deprecate gracefully

### 4. Performance (HIGH)

- `query-optimization` - SELECT only needed columns; avoid SELECT *
- `database-indexing` - Index foreign keys, search fields, sort columns
- `n-plus-one` - Use eager loading (JOINs) or data loader pattern
- `caching-strategy` - Cache at multiple levels: CDN, application, database query
- `connection-pooling` - Use connection pools (min: 5, max: 20 typical)
- `lazy-loading` - Load heavy data only when needed
- `async-processing` - Use queues for slow operations (emails, reports)
- `pagination` - Never return unbounded result sets
- `compression` - Enable gzip/brotli for API responses > 1KB
- `json-serialization` - Use fast JSON libraries (Jackson, simdjson, sonic)
- `database-pagination` - Use keyset pagination for large datasets (faster than OFFSET)
- `query-caching` - Cache frequent queries with Redis/Memcached (TTL: 60s typical)
- `read-replicas` - Route read queries to replicas for read-heavy workloads
- `batch-operations` - Support bulk inserts/updates (max 1000 items per batch)
- `streaming` - Use streaming for large data exports (avoid loading all in memory)

### 5. Scalability (HIGH)

- `stateless-design` - Store no session state in app servers (use Redis/database)
- `horizontal-scaling` - Design to scale out (add instances) not just up (bigger server)
- `async-queues` - Use message queues (RabbitMQ, SQS, Pub/Sub) for background work
- `circuit-breaker` - Implement circuit breakers for external service calls
- `bulkhead-pattern` - Isolate failures (separate thread pools per dependency)
- `backpressure` - Handle overload gracefully (queue, reject, or shed load)
- `database-sharding` - Shard by tenant_id or hash of primary key for massive scale
- `cqrs-pattern` - Separate read and write models for complex domains
- `event-sourcing` - Store events as source of truth for audit-heavy systems
- `saga-pattern` - Use sagas for distributed transactions across services
- `caching-cdn` - Use CDN for static assets and cacheable API responses
- `read-heavy-optimization` - Cache aggressively; use materialized views
- `write-heavy-optimization` - Use write-behind caching; async persistence
- `auto-scaling` - Configure auto-scaling based on CPU/memory/queue depth

### 6. Observability (MEDIUM)

- `structured-logging` - Use JSON logs with correlation IDs; avoid plain text
- `log-levels` - ERROR: 5%, WARN: 15%, INFO: 30%, DEBUG: 50% (production uses INFO+)
- `distributed-tracing` - Use OpenTelemetry/Jaeger to trace requests across services
- `metrics-collection` - Collect RED metrics (Rate, Errors, Duration)
- `health-checks` - Implement /health, /ready, /alive endpoints
- `alerting-rules` - Alert on error rate > 1%, latency p99 > 500ms, queue depth > 1000
- `dashboards` - Create Grafana dashboards for key metrics
- `log-aggregation` - Centralize logs (ELK stack, Splunk, Datadog)
- `error-tracking` - Use Sentry/Bugsnag for automatic error reporting
- `performance-profiling` - Profile CPU/memory regularly; use APM tools (New Relic, Dynatrace)
- `request-correlation` - Pass correlation_id through all service calls
- `audit-logging` - Log security events: login attempts, permission changes, data access

### 7. Maintainability (MEDIUM)

- `clean-architecture` - Separate concerns: Controllers → Services → Repositories → Models
- `dependency-injection` - Use DI containers; avoid static/singleton anti-patterns
- `solid-principles` - Follow SOLID (Single Responsibility, Open/Closed, etc.)
- `dry-principle` - Don't Repeat Yourself; extract common logic
- `meaningful-names` - Use descriptive variable/function names (getUserById, not getU)
- `function-size` - Keep functions under 50 lines; single responsibility
- `file-organization` - Group by feature, not by type (users/controller.js, users/service.js)
- `configuration-management` - Externalize config; use environment variables, config files
- `database-migrations` - Use migration tools (Flyway, Alembic, Prisma Migrate); never modify schema manually
- `api-contracts` - Define and version API contracts explicitly
- `code-reviews` - Require peer review for all production code
- `static-analysis` - Use linters (ESLint, SonarQube) and type checkers (TypeScript, mypy)
- `technical-debt` - Track tech debt; allocate 20% of sprint to reduction

### 8. Testing (MEDIUM)

- `unit-tests` - Test business logic in isolation; target 70%+ coverage
- `integration-tests` - Test database queries, external service calls
- `api-contract-tests` - Verify API matches OpenAPI spec
- `load-testing` - Test with realistic load (k6, Artillery, JMeter)
- `chaos-engineering` - Test failure scenarios (Chaos Monkey, Gremlin)
- `test-data` - Use factories, not fixtures; reset state between tests
- `mocking` - Mock external dependencies; verify contract adherence
- `ci-testing` - Run tests on every commit; block merge on failure
- `e2e-testing` - Critical path testing (signup → login → purchase)
- `security-testing` - Run OWASP ZAP, Burp Suite for security testing
- `mutation-testing` - Verify test quality with mutation testing (optional)

### 9. DevOps (MEDIUM)

- `ci-cd` - Automate build, test, deploy pipeline
- `infrastructure-as-code` - Use Terraform/CloudFormation/Pulumi
- `containerization` - Use Docker for consistent environments
- `orchestration` - Use Kubernetes/Docker Compose for container management
- `blue-green-deployment` - Deploy to green, switch traffic, keep blue as rollback
- `feature-flags` - Use LaunchDarkly/Optimizely for gradual rollouts
- `database-migrations` - Run migrations before app deployment
- `zero-downtime` - Use rolling updates; handle in-flight requests
- `rollback-strategy` - Keep previous version ready; automate rollback
- `environment-parity` - Keep dev, staging, prod as similar as possible
- `secrets-management` - Inject secrets at runtime; rotate regularly
- `backup-strategy` - Automated backups; test restore procedures monthly
- `disaster-recovery` - Document RTO/RPO; practice DR drills quarterly

### 10. Documentation (LOW)

- `api-docs` - OpenAPI/Swagger for all endpoints
- `readme` - Clear setup instructions, architecture overview
- `adrs` - Architecture Decision Records for significant choices
- `runbooks` - Operational procedures: deployment, incident response, rollback
- `code-comments` - Explain WHY, not WHAT; self-documenting code preferred
- `diagrams` - C4 diagrams for system architecture (Context, Containers, Components, Code)
- `changelog` - Maintain CHANGELOG.md (Keep a Changelog format)
- `api-examples` - Provide curl examples for common operations

## How to Use

Search specific domains using the CLI tool below.

---

## Prerequisites

Check if Node.js and npm are installed:

```bash
node --version && npm --version
```

If not installed:

**macOS:**
```bash
brew install node
```

**Ubuntu/Debian:**
```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
```

**Windows:**
```powershell
winget install OpenJS.NodeJS
```

---

## How to Use This Skill

Use this skill when the user requests any of the following:

| Scenario | Trigger Examples | Start From |
|----------|-----------------|------------|
| **New API/Endpoint** | "Create a REST API for orders", "Add user authentication" | Step 1 → Step 2 (API design) |
| **Database Design** | "Design schema for e-commerce", "Optimize slow queries" | Step 1 → Step 3 (DB design) |
| **Security Review** | "Review API for vulnerabilities", "Add rate limiting" | Quick Reference §1 |
| **Performance Issue** | "API is too slow", "Database timeout" | Step 3 (performance) |
| **Architecture Refactor** | "Split monolith to microservices", "Implement CQRS" | Step 2 (architecture) |
| **Authentication** | "Add JWT auth", "Implement OAuth" | Quick Reference §1 |
| **Testing** | "Add tests for API", "Set up load testing" | Quick Reference §8 |
| **Deployment** | "Set up CI/CD", "Deploy to AWS" | Quick Reference §9 |

Follow this workflow:

### Step 1: Analyze Requirements

Extract key information from user request:
- **System type**: REST API, GraphQL, gRPC, WebSocket, message queue, batch processing
- **Expected load**: Requests per second, concurrent users, data volume
- **Data requirements**: Relational (ACID), document (flexible), time-series, graph, search
- **Scale**: Startup (single server), growth (vertical scaling), enterprise (horizontal/distributed)
- **Stack**: Node.js, Java, Python, Go, .NET, PHP, Ruby, Rust
- **Security needs**: Public API, internal, financial/health data (high compliance)

### Step 2: Generate Architecture Design (REQUIRED)

**Always start with `--architecture`** to get comprehensive recommendations:

```bash
python3 skills/backend-pro-max/scripts/search.py "e-commerce api high-traffic" --architecture -p "ShopAPI"
```

This command:
1. Searches domains in parallel (pattern, database, security, scalability)
2. Applies reasoning rules from `backend-reasoning.csv` to select best matches
3. Returns complete architecture: patterns, data flow, security, deployment
4. Includes anti-patterns to avoid

**Example:**
```bash
python3 skills/backend-pro-max/scripts/search.py "microservices event-driven saga" --architecture -p "OrderService"
```

### Step 2b: Persist Design System

To save the architecture for **hierarchical retrieval across sessions**, add `--persist`:

```bash
python3 skills/backend-pro-max/scripts/search.py "<query>" --architecture --persist -p "Project Name"
```

This creates:
- `architecture/MASTER.md` — Global Source of Truth with all architectural rules
- `architecture/services/` — Folder for service-specific designs

**With service-specific design:**
```bash
python3 skills/backend-pro-max/scripts/search.py "<query>" --architecture --persist -p "Project Name" --service "payment"
```

This also creates:
- `architecture/services/payment.md` — Service-specific design

### Step 3: Supplement with Detailed Searches (as needed)

After getting the architecture, use domain searches to get additional details:

```bash
python3 skills/backend-pro-max/scripts/search.py "<keyword>" --domain <domain> [-n <max_results>]
```

**When to use detailed searches:**

| Need | Domain | Example |
|------|--------|---------|
| Database patterns | `database` | `--domain database "postgresql partitioning"` |
| API design patterns | `api` | `--domain api "graphql federation versioning"` |
| Security guidelines | `security` | `--domain security "jwt oauth rbac"` |
| Performance tuning | `performance` | `--domain performance "redis caching query optimization"` |
| Scalability patterns | `scalability` | `--domain scalability "sharding replication"` |
| Testing strategies | `testing` | `--domain testing "unit integration contract"` |
| DevOps practices | `devops` | `--domain devops "docker kubernetes cicd"` |
| Queue/Messaging | `messaging` | `--domain messaging "kafka rabbitmq event-sourcing"` |
| Stack-specific | `node` `java` `python` `go` | `--domain node "express middleware error-handling"` |

### Step 4: Stack Guidelines

Get implementation-specific best practices for your technology:

```bash
python3 skills/backend-pro-max/scripts/search.py "<keyword>" --stack <stack>
```

**Available stacks:**

| Stack | Focus |
|-------|-------|
| `node` | Express, NestJS, Fastify, type safety |
| `java` | Spring Boot, Jakarta EE, reactive |
| `python` | FastAPI, Django, Flask, async |
| `go` | Gin, Echo, standard library |
| `dotnet` | .NET Core, Entity Framework |
| `php` | Laravel, Symfony |
| `ruby` | Ruby on Rails |
| `rust` | Actix, Axum, Rocket |

---

## Search Reference

### Available Domains

| Domain | Use For | Example Keywords |
|--------|---------|------------------|
| `architecture` | System patterns, structural decisions | microservices, monolith, event-driven, serverless |
| `api` | REST, GraphQL, gRPC, WebSocket design | rest, graphql, versioning, pagination, rate-limit |
| `database` | SQL, NoSQL, optimization, design | postgresql, mongodb, indexing, sharding |
| `security` | Authentication, authorization, threats | jwt, oauth, rbac, sql-injection, xss |
| `performance` | Caching, optimization, profiling | redis, query-optimization, connection-pool |
| `scalability` | Scaling patterns, resilience | load-balancing, circuit-breaker, saga |
| `testing` | Test strategies, tools | unit-test, integration-test, load-test |
| `devops` | CI/CD, containers, deployment | docker, kubernetes, terraform, monitoring |
| `messaging` | Message queues, event streaming | kafka, rabbitmq, sqs, pub-sub |
| `node` `java` `python` `go` `dotnet` `php` `ruby` `rust` | Stack-specific patterns | express, spring-boot, fastapi, gin |

---

## Example Workflow

**User request:** "Build an order processing API with payment integration."

### Step 1: Analyze Requirements
- System type: REST API + message queue for async processing
- Expected load: 1000 orders/minute, 10K concurrent users
- Data requirements: Relational (orders, payments), event log (audit)
- Scale: Growth stage (need horizontal scaling)
- Stack: Node.js (team expertise)
- Security: Financial data (PCI DSS compliance needed)

### Step 2: Generate Architecture

```bash
python3 skills/backend-pro-max/scripts/search.py "order processing payment async queue" --architecture -p "OrderService"
```

**Output:** Complete architecture with API design, database schema, security patterns, deployment strategy.

### Step 3: Supplement with Detailed Searches

```bash
# Database design for orders
python3 skills/backend-pro-max/scripts/search.py "postgresql order table design" --domain database

# Payment security requirements
python3 skills/backend-pro-max/scripts/search.py "payment pci-dss tokenization" --domain security

# Queue implementation
python3 skills/backend-pro-max/scripts/search.py "bullmq redis queue pattern" --domain node

# API design patterns
python3 skills/backend-pro-max/scripts/search.py "webhook idempotency retry" --domain api
```

### Step 4: Stack Guidelines

```bash
python3 skills/backend-pro-max/scripts/search.py "error-handling validation middleware" --stack node
```

**Then:** Implement the design following the architecture and patterns.

---

## Output Formats

The `--architecture` flag supports two output formats:

```bash
# ASCII box (default) - best for terminal display
python3 skills/backend-pro-max/scripts/search.py "microservices" --architecture

# Markdown - best for documentation
python3 skills/backend-pro-max/scripts/search.py "microservices" --architecture -f markdown
```

---

## Tips for Better Results

### Query Strategy

- Use **multi-dimensional keywords** — combine pattern + scale + concern: `"event-driven microservices high-throughput observability"` not just `"api"`
- Try different keywords for the same need: `"queue retry"` → `"async processing"` → `"background jobs"`
- Use `--architecture` first for full recommendations, then `--domain` to deep-dive specific areas
- Always add `--stack <stack>` for implementation-specific guidance

### Common Sticking Points

| Problem | What to Do |
|---------|------------|
| Can't decide on architecture | Re-run `--architecture` with different keywords |
| Database performance issues | Quick Reference §4: `query-optimization` + `indexing` |
| Security vulnerabilities | Quick Reference §1: `input-validation` + `dependency-scanning` |
| Scaling bottlenecks | Quick Reference §5: `stateless-design` + `caching-strategy` |
| API contract disputes | `--domain api "versioning backward-compatibility"` |
| Testing gaps | `--domain testing "coverage integration contract"` |

---

## Decision Trees

### SQL vs NoSQL

```
Need ACID transactions? 
  YES → SQL (PostgreSQL, MySQL)
  NO  → Need complex relationships?
          YES → SQL
          NO  → Need flexible schema?
                  YES → Document (MongoDB)
                  NO  → Need high write throughput?
                          YES → Wide-column (Cassandra)
                          NO  → Need search?
                                  YES → Elasticsearch
                                  NO  → SQL is fine
```

### Monolith vs Microservices

```
Team size > 50 developers?
  YES → Microservices (bounded contexts)
  NO  → Different scaling needs per component?
          YES → Microservices
          NO  → Need independent deployment cadences?
                  YES → Microservices
                  NO  → Monolith (modular) is fine
```

### REST vs GraphQL

```
Multiple clients with different data needs?
  YES → GraphQL
  NO  → Mobile/limited bandwidth critical?
          YES → GraphQL (field selection)
          NO  → Complex nested resources?
                  YES → GraphQL
                  NO  → REST is simpler
```

---

## Integration Checklist

Before calling a system "production-ready":

- [ ] Security: Input validation, auth, rate limiting, secrets management
- [ ] Database: Migrations, indexes, connection pooling, backup strategy
- [ ] API: Versioning, pagination, error handling, rate limit headers
- [ ] Performance: Caching strategy, query optimization, async processing
- [ ] Observability: Logging, metrics, tracing, alerting, health checks
- [ ] Testing: Unit tests (70%+), integration tests, load tests
- [ ] DevOps: CI/CD, containerization, rollback plan, monitoring
- [ ] Documentation: API docs, runbooks, architecture diagrams
