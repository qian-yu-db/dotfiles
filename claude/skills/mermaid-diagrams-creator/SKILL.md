---
name: mermaid-diagrams-creator
description: Create clean, well-structured Mermaid diagrams for flowcharts, sequence diagrams, class diagrams, ER diagrams, state diagrams, and architecture visuals. Use when the user asks to create diagrams, visualize workflows, model systems, document APIs, show data relationships, or generate architecture documentation. Handles syntax nuances, layout optimization, and common pitfalls across all Mermaid diagram types.
---

# Mermaid Diagrams Skill

Create Mermaid diagrams that render correctly and communicate clearly. Mermaid files (`.mermaid`) render as visual artifacts in Claude.

## Workflow

1. Identify the best diagram type for the request
2. Generate clean Mermaid syntax following the patterns below
3. Save as `.mermaid` file to `/mnt/user-data/outputs/`

## Diagram Type Selection

| Request Type | Diagram | Direction |
|-------------|---------|-----------|
| Processes, decisions, workflows | `flowchart` | TB or LR |
| API calls, service interactions, time-ordered events | `sequenceDiagram` | (implicit LR) |
| OOP structures, data models, inheritance | `classDiagram` | TB |
| Database schemas, entity relationships | `erDiagram` | (auto) |
| Object lifecycles, FSMs | `stateDiagram-v2` | TB or LR |
| Project timelines, schedules | `gantt` | (implicit LR) |
| Git branches, commits | `gitGraph` | LR |
| Hierarchical data, org charts | `flowchart` with subgraphs | TB |

## Quick Syntax Reference

### Flowchart
```mermaid
flowchart TB
    A[Start] --> B{Decision?}
    B -->|Yes| C[Action 1]
    B -->|No| D[Action 2]
    C --> E[End]
    D --> E
```

Node shapes: `[rect]` `(rounded)` `{diamond}` `([stadium])` `[[subroutine]]` `[(database)]` `((circle))` `>flag]` `{{hexagon}}`

### Sequence Diagram
```mermaid
sequenceDiagram
    participant U as User
    participant S as Server
    participant D as Database
    
    U->>S: POST /api/data
    activate S
    S->>D: INSERT query
    D-->>S: Success
    S-->>U: 201 Created
    deactivate S
```

Arrows: `->>` (solid async), `-->>` (dotted response), `--)` (async no arrow), `-x` (lost message)

### Class Diagram
```mermaid
classDiagram
    class User {
        +String name
        +String email
        +login() bool
        +logout() void
    }
    class Admin {
        +List~Permission~ permissions
        +grantAccess(User) void
    }
    User <|-- Admin : extends
    User "1" --> "*" Order : places
```

Relations: `<|--` (inheritance), `*--` (composition), `o--` (aggregation), `-->` (association), `..>` (dependency)

### ER Diagram
```mermaid
erDiagram
    USER ||--o{ ORDER : places
    ORDER ||--|{ LINE_ITEM : contains
    PRODUCT ||--o{ LINE_ITEM : "ordered in"
    
    USER {
        int id PK
        string email UK
        string name
    }
    ORDER {
        int id PK
        int user_id FK
        date created_at
    }
```

Cardinality: `||` (one), `o|` (zero or one), `}|` (one or more), `}o` (zero or more)

### State Diagram
```mermaid
stateDiagram-v2
    [*] --> Idle
    Idle --> Processing : submit
    Processing --> Success : complete
    Processing --> Failed : error
    Failed --> Idle : retry
    Success --> [*]
```

### Gantt Chart
```mermaid
gantt
    title Project Timeline
    dateFormat YYYY-MM-DD
    section Phase 1
        Task A :a1, 2024-01-01, 30d
        Task B :after a1, 20d
    section Phase 2
        Task C :2024-02-15, 25d
```

## Best Practices

**Node IDs**: Use meaningful names (`userService`, `validateInput`) not single letters (`A`, `B`).

**Labels**: Keep under 40 characters. Use `<br>` for line breaks in longer text.

**Direction**: Use `TB` (top-bottom) for hierarchies, `LR` (left-right) for sequences/timelines.

**Subgraphs**: Group related nodes to improve readability:
```mermaid
flowchart TB
    subgraph Frontend
        UI[Web UI]
        Mobile[Mobile App]
    end
    subgraph Backend
        API[API Gateway]
        Auth[Auth Service]
    end
    UI --> API
    Mobile --> API
    API --> Auth
```

**Styling**: Apply sparingly for emphasis:
```mermaid
flowchart LR
    A --> B --> C
    style B fill:#f96,stroke:#333
    linkStyle 1 stroke:#f00,stroke-width:2px
```

## Common Pitfalls

| Issue | Problem | Solution |
|-------|---------|----------|
| Special chars in labels | `(`, `)`, `[`, `]` break parsing | Wrap in quotes: `A["processData()"]` |
| Colons in labels | Interpreted as styling | Escape: `A["Key: Value"]` |
| Long node names | Diagram becomes unreadable | Use short IDs with descriptive labels: `db[(Database)]` |
| Too many nodes | Cluttered, hard to follow | Split into multiple diagrams or use subgraphs |
| Missing quotes | Spaces in labels fail | Always quote multi-word labels |
| Arrow syntax mixing | Different diagrams use different arrows | Check diagram type (flowchart uses `-->`, sequence uses `->>`) |

## Output

Save diagrams to `/mnt/user-data/outputs/diagram-name.mermaid` for rendering.

For detailed syntax reference and advanced patterns, see [references/syntax-guide.md](references/syntax-guide.md).
