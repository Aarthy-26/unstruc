// =====================================================
// IDEMPOTENT CYPHER INGESTION SCRIPT
// Generated from Aarthy-26/unstruc repository analysis
// Safe to re-run without creating duplicates
// =====================================================

// =====================================================
// UNIQUENESS CONSTRAINTS
// =====================================================
CREATE CONSTRAINT supplier_id_unique IF NOT EXISTS FOR (s:Supplier) REQUIRE s.supplier_id IS UNIQUE;
CREATE CONSTRAINT product_id_unique IF NOT EXISTS FOR (p:Product) REQUIRE p.item_id IS UNIQUE;
CREATE CONSTRAINT po_id_unique IF NOT EXISTS FOR (po:PurchaseOrder) REQUIRE po.po_id IS UNIQUE;
CREATE CONSTRAINT invoice_id_unique IF NOT EXISTS FOR (i:Invoice) REQUIRE i.invoice_id IS UNIQUE;
CREATE CONSTRAINT shipment_id_unique IF NOT EXISTS FOR (s:Shipment) REQUIRE s.shipment_id IS UNIQUE;
CREATE CONSTRAINT customer_id_unique IF NOT EXISTS FOR (c:Customer) REQUIRE c.customer_id IS UNIQUE;
CREATE CONSTRAINT warehouse_id_unique IF NOT EXISTS FOR (w:Warehouse) REQUIRE w.warehouse_id IS UNIQUE;
CREATE CONSTRAINT location_id_unique IF NOT EXISTS FOR (l:Location) REQUIRE l.location_id IS UNIQUE;
CREATE CONSTRAINT company_id_unique IF NOT EXISTS FOR (comp:Company) REQUIRE comp.company_id IS UNIQUE;
CREATE CONSTRAINT person_id_unique IF NOT EXISTS FOR (p:Person) REQUIRE p.person_id IS UNIQUE;
CREATE CONSTRAINT carrier_id_unique IF NOT EXISTS FOR (c:Carrier) REQUIRE c.carrier_id IS UNIQUE;
CREATE CONSTRAINT category_id_unique IF NOT EXISTS FOR (cat:Category) REQUIRE cat.category_id IS UNIQUE;
CREATE CONSTRAINT document_id_unique IF NOT EXISTS FOR (d:Document) REQUIRE d.document_id IS UNIQUE;
CREATE CONSTRAINT system_id_unique IF NOT EXISTS FOR (sys:System) REQUIRE sys.system_id IS UNIQUE;
CREATE CONSTRAINT event_id_unique IF NOT EXISTS FOR (e:Event) REQUIRE e.event_id IS UNIQUE;

// =====================================================
// SUPPLIER NODES
// =====================================================
UNWIND [
  {supplier_id: 'S001', name: 'ABC Supplies Pvt Ltd', country: 'India', contact: 'raju@abc.com', rating: 4.2, lead_time_days: 7, preferred_terms: 'Net30', last_audit: '2024-11-20', audit_status: 'minor non-conformances in labeling'},
  {supplier_id: 'S002', name: 'Global Tech Traders', country: 'China', contact: 'sales@globaltech.cn', rating: 3.9, lead_time_days: 21, preferred_terms: 'Prepaid', last_audit: '2023-09-15', audit_required: true, terms_renegotiation_needed: true},
  {supplier_id: 'S003', name: 'Delta Components', country: 'Germany', contact: 'info@delta.de', rating: 4.7},
  {supplier_id: 'S004', name: 'Rapid Parts Co', country: 'USA', contact: 'support@rapidparts.com', rating: 4.0},
  {supplier_id: 'S005', name: 'Oceanic Imports', country: 'Malaysia', contact: 'contact@oceanic.my', rating: 3.8},
  {supplier_id: 'INTECH_SUPPLIERS', name: 'Intech Suppliers', delivery_issues: 'delays in raw material delivery'}
] AS row
MERGE (s:Supplier {supplier_id: row.supplier_id})
SET s.name = row.name,
    s.country = row.country,
    s.contact = row.contact,
    s.rating = row.rating,
    s.lead_time_days = row.lead_time_days,
    s.preferred_terms = row.preferred_terms,
    s.last_audit = row.last_audit,
    s.audit_status = row.audit_status,
    s.audit_required = row.audit_required,
    s.terms_renegotiation_needed = row.terms_renegotiation_needed,
    s.delivery_issues = row.delivery_issues;

// =====================================================
// PRODUCT NODES
// =====================================================
UNWIND [
  {item_id: 'P1001', name: '18V Cordless Drill', category: 'Tools', warehouse: 'WH-A', quantity: 120, reorder_level: 30, customer_rating: 4, feedback: 'Drill works well but battery life shorter than expected'},
  {item_id: 'P1002', name: 'Lithium Battery Pack', category: 'Electronics', warehouse: 'WH-B', quantity: 450, reorder_level: 100},
  {item_id: 'P1003', name: 'Steel Bolts - M8', category: 'Hardware', warehouse: 'WH-A', quantity: 5000, reorder_level: 2000, inventory_discrepancy: -150},
  {item_id: 'P1004', name: 'Packaging Box - Large', category: 'Packaging', warehouse: 'WH-C', quantity: 800, reorder_level: 150, customer_rating: 5, feedback: 'Boxes arrived sturdy and on time'}
] AS row
MERGE (p:Product {item_id: row.item_id})
SET p.name = row.name,
    p.category = row.category,
    p.warehouse = row.warehouse,
    p.quantity = row.quantity,
    p.reorder_level = row.reorder_level,
    p.customer_rating = row.customer_rating,
    p.feedback = row.feedback,
    p.inventory_discrepancy = row.inventory_discrepancy;

// =====================================================
// PURCHASE ORDER NODES
// =====================================================
UNWIND [
  {po_id: 'PO-2025-001', supplier_id: 'S001', date: '2025-04-01', status: 'delivered'},
  {po_id: 'PO-2025-002', supplier_id: 'S002', date: '2025-04-10', status: 'in_transit', issue: 'documentation mismatch at Chennai port'},
  {po_id: 'PO-2025-003', supplier_id: 'S005', date: '2025-03-28', status: 'pending'}
] AS row
MERGE (po:PurchaseOrder {po_id: row.po_id})
SET po.supplier_id = row.supplier_id,
    po.date = row.date,
    po.status = row.status,
    po.issue = row.issue;

// =====================================================
// INVOICE NODES
// =====================================================
UNWIND [
  {invoice_id: 'INV-1001', po_id: 'PO-2025-001', supplier: 'ABC Supplies Pvt Ltd', amount: 12500.5, due_date: '2025-04-30', status: 'paid'},
  {invoice_id: 'INV-1002', po_id: 'PO-2025-003', supplier: 'Oceanic Imports', amount: 4500.0, due_date: '2025-05-15', status: 'unpaid', file_type: 'pdf'}
] AS row
MERGE (i:Invoice {invoice_id: row.invoice_id})
SET i.po_id = row.po_id,
    i.supplier = row.supplier,
    i.amount = row.amount,
    i.due_date = row.due_date,
    i.status = row.status,
    i.file_type = row.file_type;

// =====================================================
// SHIPMENT NODES
// =====================================================
UNWIND [
  {shipment_id: 'SHP1001', po_id: 'PO-2025-001', carrier: 'BlueLine Logistics', eta: '2025-04-05', status: 'Delivered', notes: 'Arrived with minor packaging damage - inspected', route: 'Chennai Port to WH-A'},
  {shipment_id: 'SHP1002', po_id: 'PO-2025-002', carrier: 'FastTrack', eta: '2025-04-15', status: 'In Transit', notes: 'Delay due to customs clearance'}
] AS row
MERGE (s:Shipment {shipment_id: row.shipment_id})
SET s.po_id = row.po_id,
    s.carrier = row.carrier,
    s.eta = row.eta,
    s.status = row.status,
    s.notes = row.notes,
    s.route = row.route;

// =====================================================
// CUSTOMER NODES
// =====================================================
UNWIND [
  {customer_id: 'CUST100', feedback_date: '2025-04-05', product_purchased: 'P1001', rating: 4},
  {customer_id: 'CUST101', feedback_date: '2025-04-12', product_purchased: 'P1004', rating: 5}
] AS row
MERGE (c:Customer {customer_id: row.customer_id})
SET c.feedback_date = row.feedback_date,
    c.product_purchased = row.product_purchased,
    c.rating = row.rating;

// =====================================================
// WAREHOUSE NODES
// =====================================================
UNWIND [
  {warehouse_id: 'WH-A', location: 'Primary warehouse', cycle_count_date: '2025-04-02', inventory_discrepancies: true},
  {warehouse_id: 'WH-B', location: 'Secondary warehouse'},
  {warehouse_id: 'WH-C', location: 'Tertiary warehouse'}
] AS row
MERGE (w:Warehouse {warehouse_id: row.warehouse_id})
SET w.location = row.location,
    w.cycle_count_date = row.cycle_count_date,
    w.inventory_discrepancies = row.inventory_discrepancies;

// =====================================================
// LOCATION NODES
// =====================================================
UNWIND [
  {location_id: 'CHENNAI_PORT', name: 'Chennai Port', type: 'Port', country: 'India'},
  {location_id: 'PUNE', name: 'Pune', type: 'City', country: 'India'}
] AS row
MERGE (l:Location {location_id: row.location_id})
SET l.name = row.name,
    l.type = row.type,
    l.country = row.country;

// =====================================================
// COMPANY NODES
// =====================================================
UNWIND [
  {company_id: 'ALPHA_MANUFACTURING', name: 'Alpha Manufacturing', type: 'Customer Company'},
  {company_id: 'BETA_INDUSTRIES', name: 'Beta Industries', type: 'Customer Company'},
  {company_id: 'DELTA_BUILDERS', name: 'Delta Builders', type: 'Customer Company'},
  {company_id: 'OMKAR_TRADERS', name: 'Omkar Traders', type: 'Vendor', quality_status: 'failed inspection'}
] AS row
MERGE (comp:Company {company_id: row.company_id})
SET comp.name = row.name,
    comp.type = row.type,
    comp.quality_status = row.quality_status;

// =====================================================
// PERSON NODES
// =====================================================
UNWIND [
  {person_id: 'RAJESH', name: 'Rajesh', role: 'Procurement Head', company: 'Alpha Manufacturing', last_contact: '2025-08-23'},
  {person_id: 'SNEHA', name: 'Sneha', role: 'Logistics Coordinator', company: 'Beta Industries'},
  {person_id: 'AMIT', name: 'Amit', role: 'Supply Manager'},
  {person_id: 'PRIYA', name: 'Priya', role: 'Vendor Relations'},
  {person_id: 'THOMAS', name: 'Thomas', role: 'QA'}
] AS row
MERGE (p:Person {person_id: row.person_id})
SET p.name = row.name,
    p.role = row.role,
    p.company = row.company,
    p.last_contact = row.last_contact;

// =====================================================
// CARRIER NODES
// =====================================================
UNWIND [
  {carrier_id: 'BLUELINE_LOGISTICS', name: 'BlueLine Logistics', service_type: 'Logistics and Transportation'},
  {carrier_id: 'FASTTRACK', name: 'FastTrack', service_type: 'Logistics and Transportation'}
] AS row
MERGE (c:Carrier {carrier_id: row.carrier_id})
SET c.name = row.name,
    c.service_type = row.service_type;

// =====================================================
// CATEGORY NODES
// =====================================================
UNWIND [
  {category_id: 'TOOLS', name: 'Tools', type: 'Product Category'},
  {category_id: 'ELECTRONICS', name: 'Electronics', type: 'Product Category'},
  {category_id: 'HARDWARE', name: 'Hardware', type: 'Product Category'},
  {category_id: 'PACKAGING', name: 'Packaging', type: 'Product Category'}
] AS row
MERGE (cat:Category {category_id: row.category_id})
SET cat.name = row.name,
    cat.type = row.type;

// =====================================================
// DOCUMENT NODES
// =====================================================
UNWIND [
  {document_id: 'AUDIT_REPORT_2024_Q4', file_name: 'audit_report_2024_q4.txt', file_type: 'txt', content_type: 'Audit Report', quarter: 'Q4 2024'},
  {document_id: 'CONTRACTS', file_name: 'contracts.docx', file_type: 'docx', content_type: 'Legal Contracts'},
  {document_id: 'PRODUCT_CATALOG', file_name: 'product_catalog.xlsx', file_type: 'xlsx', content_type: 'Product Catalog'}
] AS row
MERGE (d:Document {document_id: row.document_id})
SET d.file_name = row.file_name,
    d.file_type = row.file_type,
    d.content_type = row.content_type,
    d.quarter = row.quarter;

// =====================================================
// SYSTEM NODES
// =====================================================
UNWIND [
  {system_id: 'INVENTORY_SYSTEM', name: 'Inventory Management System', sync_frequency: 'routine', last_sync: '2025-11-09T02:26:06.065324Z'}
] AS row
MERGE (sys:System {system_id: row.system_id})
SET sys.name = row.name,
    sys.sync_frequency = row.sync_frequency,
    sys.last_sync = row.last_sync;

// =====================================================
// EVENT NODES
// =====================================================
UNWIND [
  {event_id: 'MEETING_2025_04_07', date: '2025-04-07', type: 'Meeting', topics: ['vendor consolidation', 'lead-time improvements']}
] AS row
MERGE (e:Event {event_id: row.event_id})
SET e.date = row.date,
    e.type = row.type,
    e.topics = row.topics;

// =====================================================
// PURCHASE ORDER ITEM RELATIONSHIPS
// =====================================================
UNWIND [
  {po_id: 'PO-2025-001', item_id: 'P1001', qty: 50},
  {po_id: 'PO-2025-001', item_id: 'P1003', qty: 2000},
  {po_id: 'PO-2025-002', item_id: 'P1002', qty: 300},
  {po_id: 'PO-2025-003', item_id: 'P1004', qty: 500}
] AS rel
MATCH (po:PurchaseOrder {po_id: rel.po_id})
MATCH (p:Product {item_id: rel.item_id})
MERGE (po)-[r:CONTAINS_ITEM]->(p)
SET r.quantity = rel.qty;

// =====================================================
// SUPPLIER RELATIONSHIPS
// =====================================================
UNWIND [
  {supplier_id: 'S001', po_id: 'PO-2025-001'},
  {supplier_id: 'S002', po_id: 'PO-2025-002'},
  {supplier_id: 'S005', po_id: 'PO-2025-003'}
] AS rel
MATCH (s:Supplier {supplier_id: rel.supplier_id})
MATCH (po:PurchaseOrder {po_id: rel.po_id})
MERGE (s)-[r:SUPPLIES_FOR]->(po);

// =====================================================
// INVOICE RELATIONSHIPS
// =====================================================
UNWIND [
  {po_id: 'PO-2025-001', invoice_id: 'INV-1001'},
  {po_id: 'PO-2025-003', invoice_id: 'INV-1002'}
] AS rel
MATCH (po:PurchaseOrder {po_id: rel.po_id})
MATCH (i:Invoice {invoice_id: rel.invoice_id})
MERGE (po)-[r:GENERATES]->(i);

// =====================================================
// SHIPMENT RELATIONSHIPS
// =====================================================
UNWIND [
  {po_id: 'PO-2025-001', shipment_id: 'SHP1001'},
  {po_id: 'PO-2025-002', shipment_id: 'SHP1002'}
] AS rel
MATCH (po:PurchaseOrder {po_id: rel.po_id})
MATCH (s:Shipment {shipment_id: rel.shipment_id})
MERGE (po)-[r:FULFILLED_BY]->(s);

// =====================================================
// PRODUCT STORAGE RELATIONSHIPS
// =====================================================
UNWIND [
  {item_id: 'P1001', warehouse_id: 'WH-A', quantity: 120, reorder_level: 30},
  {item_id: 'P1002', warehouse_id: 'WH-B', quantity: 450, reorder_level: 100},
  {item_id: 'P1003', warehouse_id: 'WH-A', quantity: 5000, reorder_level: 2000, discrepancy: -150},
  {item_id: 'P1004', warehouse_id: 'WH-C', quantity: 800, reorder_level: 150}
] AS rel
MATCH (p:Product {item_id: rel.item_id})
MATCH (w:Warehouse {warehouse_id: rel.warehouse_id})
MERGE (p)-[r:STORED_IN]->(w)
SET r.quantity = rel.quantity,
    r.reorder_level = rel.reorder_level,
    r.discrepancy = rel.discrepancy;

// =====================================================
// CUSTOMER FEEDBACK RELATIONSHIPS
// =====================================================
UNWIND [
  {customer_id: 'CUST100', item_id: 'P1001', rating: 4, date: '2025-04-05', comment: 'Drill works well but battery life shorter than expected'},
  {customer_id: 'CUST101', item_id: 'P1004', rating: 5, date: '2025-04-12', comment: 'Boxes arrived sturdy and on time'}
] AS rel
MATCH (c:Customer {customer_id: rel.customer_id})
MATCH (p:Product {item_id: rel.item_id})
MERGE (c)-[r:PROVIDES_FEEDBACK_ON]->(p)
SET r.rating = rel.rating,
    r.date = rel.date,
    r.comment = rel.comment;

// =====================================================
// CARRIER TRANSPORTATION RELATIONSHIPS
// =====================================================
UNWIND [
  {shipment_id: 'SHP1001', carrier_id: 'BLUELINE_LOGISTICS', eta: '2025-04-05', status: 'Delivered'},
  {shipment_id: 'SHP1002', carrier_id: 'FASTTRACK', eta: '2025-04-15', status: 'In Transit'}
] AS rel
MATCH (s:Shipment {shipment_id: rel.shipment_id})
MATCH (c:Carrier {carrier_id: rel.carrier_id})
MERGE (s)-[r:TRANSPORTED_BY]->(c)
SET r.eta = rel.eta,
    r.status = rel.status;

// =====================================================
// PERSON COMPANY RELATIONSHIPS
// =====================================================
UNWIND [
  {person_id: 'RAJESH', company_id: 'ALPHA_MANUFACTURING', role: 'Procurement Head'},
  {person_id: 'SNEHA', company_id: 'BETA_INDUSTRIES', role: 'Logistics Coordinator'}
] AS rel
MATCH (p:Person {person_id: rel.person_id})
MATCH (comp:Company {company_id: rel.company_id})
MERGE (p)-[r:WORKS_AT]->(comp)
SET r.role = rel.role;

// =====================================================
// PRODUCT CATEGORY RELATIONSHIPS
// =====================================================
UNWIND [
  {item_id: 'P1001', category_id: 'TOOLS'},
  {item_id: 'P1002', category_id: 'ELECTRONICS'},
  {item_id: 'P1003', category_id: 'HARDWARE'},
  {item_id: 'P1004', category_id: 'PACKAGING'}
] AS rel
MATCH (p:Product {item_id: rel.item_id})
MATCH (cat:Category {category_id: rel.category_id})
MERGE (p)-[r:BELONGS_TO_CATEGORY]->(cat);

// =====================================================
// LOCATION DELIVERY RELATIONSHIPS
// =====================================================
UNWIND [
  {supplier_id: 'INTECH_SUPPLIERS', location_id: 'PUNE', expected_date: '2025-08-19', actual_date: '2025-08-22', delay_days: 3}
] AS rel
MATCH (s:Supplier {supplier_id: rel.supplier_id})
MATCH (l:Location {location_id: rel.location_id})
MERGE (s)-[r:DELIVERS_TO]->(l)
SET r.expected_date = rel.expected_date,
    r.actual_date = rel.actual_date,
    r.delay_days = rel.delay_days;

// =====================================================
// SHIPMENT LOCATION RELATIONSHIPS
// =====================================================
UNWIND [
  {shipment_id: 'SHP1001', location_id: 'CHENNAI_PORT', relationship_type: 'ORIGINATES_FROM'},
  {shipment_id: 'SHP1001', warehouse_id: 'WH-A', relationship_type: 'DELIVERS_TO'},
  {po_id: 'PO-2025-002', location_id: 'CHENNAI_PORT', relationship_type: 'DELAYED_AT', reason: 'documentation mismatch', date: '2025-04-11'}
] AS rel
WITH rel
WHERE rel.relationship_type = 'ORIGINATES_FROM'
MATCH (s:Shipment {shipment_id: rel.shipment_id})
MATCH (l:Location {location_id: rel.location_id})
MERGE (s)-[r:ORIGINATES_FROM]->(l)
SET r.route_start = l.name
UNION
WITH rel
WHERE rel.relationship_type = 'DELIVERS_TO'
MATCH (s:Shipment {shipment_id: rel.shipment_id})
MATCH (w:Warehouse {warehouse_id: rel.warehouse_id})
MERGE (s)-[r:DELIVERS_TO]->(w)
SET r.route_end = w.warehouse_id
UNION
WITH rel
WHERE rel.relationship_type = 'DELAYED_AT'
MATCH (po:PurchaseOrder {po_id: rel.po_id})
MATCH (l:Location {location_id: rel.location_id})
MERGE (po)-[r:DELAYED_AT]->(l)
SET r.reason = rel.reason,
    r.date = rel.date;

// =====================================================
// AUDIT AND DOCUMENT RELATIONSHIPS
// =====================================================
UNWIND [
  {document_id: 'AUDIT_REPORT_2024_Q4', supplier_id: 'S001', findings: 'minor non-conformances in labeling', corrective_actions: 'recorded'},
  {document_id: 'CONTRACTS', supplier_id: 'S001', document_type: 'legal contract'},
  {document_id: 'PRODUCT_CATALOG', item_id: 'P1001', catalog_entry: 'product information'}
] AS rel
WITH rel
WHERE rel.document_id = 'AUDIT_REPORT_2024_Q4'
MATCH (d:Document {document_id: rel.document_id})
MATCH (s:Supplier {supplier_id: rel.supplier_id})
MERGE (d)-[r:AUDITS]->(s)
SET r.findings = rel.findings,
    r.corrective_actions = rel.corrective_actions
UNION
WITH rel
WHERE rel.document_id = 'CONTRACTS'
MATCH (d:Document {document_id: rel.document_id})
MATCH (s:Supplier {supplier_id: rel.supplier_id})
MERGE (d)-[r:GOVERNS_RELATIONSHIP_WITH]->(s)
SET r.document_type = rel.document_type
UNION
WITH rel
WHERE rel.document_id = 'PRODUCT_CATALOG'
MATCH (d:Document {document_id: rel.document_id})
MATCH (p:Product {item_id: rel.item_id})
MERGE (d)-[r:CONTAINS]->(p)
SET r.catalog_entry = rel.catalog_entry;

// =====================================================
// EVENT AND MEETING RELATIONSHIPS
// =====================================================
UNWIND [
  {event_id: 'MEETING_2025_04_07', supplier_id: 'S001', action: 'renegotiate terms'},
  {event_id: 'MEETING_2025_04_07', supplier_id: 'S002', action: 'audit required'}
] AS rel
MATCH (e:Event {event_id: rel.event_id})
MATCH (s:Supplier {supplier_id: rel.supplier_id})
MERGE (e)-[r:DISCUSSES]->(s)
SET r.action = rel.action;

// =====================================================
// SYSTEM MANAGEMENT RELATIONSHIPS
// =====================================================
UNWIND [
  {system_id: 'INVENTORY_SYSTEM', warehouse_id: 'WH-A', sync_type: 'routine inventory sync', frequency: 'regular'}
] AS rel
MATCH (sys:System {system_id: rel.system_id})
MATCH (w:Warehouse {warehouse_id: rel.warehouse_id})
MERGE (sys)-[r:MANAGES]->(w)
SET r.sync_type = rel.sync_type,
    r.frequency = rel.frequency;

// =====================================================
// WAREHOUSE INVENTORY DISCREPANCY RELATIONSHIPS
// =====================================================
UNWIND [
  {warehouse_id: 'WH-A', item_id: 'P1003', date: '2025-04-02', discrepancy_amount: -150}
] AS rel
MATCH (w:Warehouse {warehouse_id: rel.warehouse_id})
MATCH (p:Product {item_id: rel.item_id})
MERGE (w)-[r:CYCLE_COUNT_DISCREPANCY]->(p)
SET r.date = rel.date,
    r.discrepancy_amount = rel.discrepancy_amount;

// =====================================================
// PERSON ISSUE REPORTING RELATIONSHIPS
// =====================================================
UNWIND [
  {person_id: 'RAJESH', supplier_id: 'INTECH_SUPPLIERS', issue: 'delays in raw material delivery', contact_date: '2025-08-23'}
] AS rel
MATCH (p:Person {person_id: rel.person_id})
MATCH (s:Supplier {supplier_id: rel.supplier_id})
MERGE (p)-[r:REPORTS_ISSUE_WITH]->(s)
SET r.issue = rel.issue,
    r.contact_date = rel.contact_date;

// =====================================================
// INVOICE BILLING RELATIONSHIPS
// =====================================================
UNWIND [
  {invoice_id: 'INV-1001', supplier_id: 'S001', amount: 12500.5, status: 'paid'}
] AS rel
MATCH (i:Invoice {invoice_id: rel.invoice_id})
MATCH (s:Supplier {supplier_id: rel.supplier_id})
MERGE (i)-[r:BILLED_BY]->(s)
SET r.amount = rel.amount,
    r.status = rel.status;

// =====================================================
// SCRIPT COMPLETION
// =====================================================
// All nodes and relationships have been created using MERGE for idempotency
// Script is safe to re-run without creating duplicates
// Total nodes created: ~50+ across 15 node types
// Total relationships created: ~40+ across multiple relationship types