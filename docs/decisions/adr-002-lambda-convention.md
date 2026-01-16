# ADR-002: Convention Over Configuration para Imágenes

**Status**: ACCEPTED

**Context**:
Lambda necesita escribir URL de thumbnail en RDS. Esto requiere:
- Lambda en VPC (sin internet)
- NAT Gateway ($32 USD/mes)
- Total: Presupuesto reventado

**Decision**:
Lambda NO escribe en DB. Backend construye URLs por convención:
- Original: `s3://.../original/{image_key}`
- Thumbnail: `s3://.../thumbnails/{image_key}` (mismo nombre)

**Consequences**:
**Pros**:
- Costo $0 (Lambda sin VPC)
- Desacoplamiento (Lambda stateless)
- Idempotente (regenerar thumbnails sin DB)

**Contras**:
- Requiere convención documentada
- No puedes tener múltiples thumbnails con nombres diferentes

**References**:
- [12-Factor App: Build, Release, Run](https://12factor.net/build-release-run)
- AWS Lambda Best Practices
