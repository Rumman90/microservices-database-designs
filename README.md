# Microservices Database Designs (SQL Server)

This repo contains example database designs for typical microservices:

- `company-service`
- `user-service`
- `course-service`

Each service has:
- Its **own database**
- **Isolated schema**
- Common conventions:
  - `BIGINT IDENTITY` primary keys
  - Soft delete: `IsDeleted`, `DeletedAt`, `DeletedBy` (with filtered unique indexes where needed)
  - Audit fields: `CreatedAt`, `CreatedBy`, `UpdatedAt`, `UpdatedBy`
  - UTC timestamps using `SYSUTCDATETIME()`

> These scripts are written for **SQL Server (T-SQL)** and are meant as learning and reference material, not production-ready drop-ins.

---

## 1. Company Service

**Purpose:** Store companies and their branches.

**Key design points:**
- `Companies` is the root entity  
- `CompanyBranches` is a child entity with `CompanyId` FK  
- Soft delete on both tables  
- Indexes on foreign keys + frequently filtered columns  

---

## 2. User Service

**Purpose:** Manage users and roles.

**Key design points:**
- `Users` has basic profile + status  
- `Roles` is a lookup with audit + soft delete  
- `UserRoles` is a many-to-many bridge table  
- Filtered unique indexes on `Email`, `Roles.Name`, and `(UserId, RoleId)`  

---

## 3. Course Service

**Purpose:** Store courses and their lectures.

**Key design points:**
- `Courses` main entity  
- `Lectures` linked to `CourseId`  
- `Position` column for ordering lectures  
- Filtered unique index on `Slug` and on `(CourseId, Position)` for per-course ordering  

---

## How to Use

1. Create three databases in SQL Server:

```sql
CREATE DATABASE CompanyServiceDb;
CREATE DATABASE UserServiceDb;
CREATE DATABASE CourseServiceDb;
```

2. Run each folder's `01_create_*_tables.sql`  
3. Then run `02_seed_*_data.sql`

You can extend this repo with:
- More services (billing, notifications, orders)
- Migration tools (Flyway / Liquibase)
- Stored procedures with dynamic JSON
