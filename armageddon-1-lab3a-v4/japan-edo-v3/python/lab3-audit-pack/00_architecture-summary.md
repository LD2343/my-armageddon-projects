*This document provides a high-level architectural overview and compliance context for the evidence contained in this audit pack.*
 
**1. System purpose**

This system is a globally accessible web application designed to serve users in multiple regions while ensuring that all regulated personal health information (PHI) is stored and processed exclusively within Japan.

**2. High-Level architecture**

- Global edge: CloudFront
- Application layer: ALB + EC2 (Tokyo, São Paulo)
- Data layer: RDS (Tokyo only)
- Network boundary: Transit Gateway (controlled peering)
- Global edge: CloudFront (routing only; no PHI cached)

**3. Data residency statement**

All databases containing PHI are deployed solely in the Tokyo region (ap-northeast-1). No database replicas, backups, or persistent storage containing PHI exist outside Japan. Cross-region access from São Paulo is limited to application-layer network calls via a restricted Transit Gateway corridor.

**4. Compliance intent**

The architecture is intentionally designed to meet APPI data residency requirements while still supporting global user access and regional application execution.

**5. How to read the rest of the pack**

- 01_data-residency-proof.txt: Database location and storage controls
- 02_edge-proof-cloudfront.txt: Edge routing and cache behavior
- 03_waf-proof.txt: Application-layer protections
- 04_cloudtrail-change-proof.txt: Change auditing and traceability
- 05_network-corridor-proof.txt: Cross-region network controls