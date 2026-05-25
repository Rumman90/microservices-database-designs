# Microservices Database Designs

This repo contains a few simple SQL Server database designs for common
microservices. I made it as a reference for how separate services can own their
own database tables without sharing one big schema.

- `company-service`
- `user-service`
- `course-service`

Each folder has a create script and a seed script. The services are intentionally
separate, so there are no cross-database foreign keys.

> These scripts are written for SQL Server T-SQL. They are meant for practice
> and reference, not as production-ready migrations.

## Architecture

See [docs/architecture.md](docs/architecture.md) for the diagrams and the main
schema conventions used across the services.

---

## Services

### Company Service

Stores companies and their branches.

Main points:
- `Companies` is the root table
- `CompanyBranches` belongs to a company through `CompanyId`
- Both tables support soft delete
- There are indexes for common filters and lookups

---

### User Service

Stores users, roles, and role assignments.

Main points:
- `Users` stores basic profile and account status fields
- `Roles` is a small lookup table
- `UserRoles` handles the many-to-many relationship
- Filtered unique indexes keep active emails and role names unique

---

### Course Service

Stores courses and their lectures.

Main points:
- `Courses` is the main table
- `Lectures` belongs to a course through `CourseId`
- `Position` controls lecture order inside a course
- Filtered unique indexes protect course slugs and lecture ordering

---

## How to Use

1. Create the three service databases:

```sql
CREATE DATABASE CompanyServiceDb;
CREATE DATABASE UserServiceDb;
CREATE DATABASE CourseServiceDb;
```

2. Run each service's schema script:

```text
company-service/01_create_company_tables.sql
user-service/01_create_user_tables.sql
course-service/01_create_course_tables.sql
```

3. Run each service's seed script:

```text
company-service/02_seed_company_data.sql
user-service/02_seed_user_data.sql
course-service/02_seed_course_data.sql
```

## Repository Layout

```text
.
|-- company-service
|   |-- 01_create_company_tables.sql
|   `-- 02_seed_company_data.sql
|-- course-service
|   |-- 01_create_course_tables.sql
|   `-- 02_seed_course_data.sql
|-- docs
|   `-- architecture.md
|-- user-service
|   |-- 01_create_user_tables.sql
|   `-- 02_seed_user_data.sql
`-- README.md
```

## Possible Extensions

- More services (billing, notifications, orders)
- Migration tools (Flyway / Liquibase)
- Stored procedures or views for service-owned read models
- Docker Compose for local SQL Server setup
- CI checks that run the scripts against a disposable database
