// Generated Cypher Query from graph_data.json
// Source: graph_data/graph_data.json
// Generation Date: 2024-12-19
// Description: Creates a comprehensive supply chain management graph with suppliers, products, warehouses, customers, purchase orders, invoices, shipments, and their relationships

// Create Suppliers
CREATE (:Supplier {id: 'S001', name: 'ABC Supplies Pvt Ltd', country: 'India', contact: 'raju@abc.com', rating: 4.2, lead_time_days: 7, preferred_terms: 'Net30', last_audit: '2024-11-20'})
CREATE (:Supplier {id: 'S002', name: 'Global Tech Traders', country: 'China', contact: 'sales@globaltech.cn', rating: 3.9, lead_time_days: 21, preferred_terms: 'Prepaid', last_audit: '2023-09-15'})
CREATE (:Supplier {id: 'S003', name: 'Delta Components', country: 'Germany', contact: 'info@delta.de', rating: 4.7})
CREATE (:Supplier {id: 'S004', name: 'Rapid Parts Co', country: 'USA', contact: 'support@rapidparts.com', rating: 4.0})
CREATE (:Supplier {id: 'S005', name: 'Oceanic Imports', country: 'Malaysia', contact: 'contact@oceanic.my', rating: 3.8})

// Create Products
CREATE (:Product {id: 'P1001', name: '18V Cordless Drill', category: 'Tools', warehouse: 'WH-A', qty: 120, reorder_level: 30})
CREATE (:Product {id: 'P1002', name: 'Lithium Battery Pack', category: 'Electronics', warehouse: 'WH-B', qty: 450, reorder_level: 100})
CREATE (:Product {id: 'P1003', name: 'Steel Bolts - M8', category: 'Hardware', warehouse: 'WH-A', qty: 5000, reorder_level: 2000})
CREATE (:Product {id: 'P1004', name: 'Packaging Box - Large', category: 'Packaging', warehouse: 'WH-C', qty: 800, reorder_level: 150})

// Create Warehouses
CREATE (:Warehouse {id: 'WH-A', name: 'Warehouse A'})
CREATE (:Warehouse {id: 'WH-B', name: 'Warehouse B'})
CREATE (:Warehouse {id: 'WH-C', name: 'Warehouse C'})

// Create Customers
CREATE (:Customer {id: 'CUST100', customer_id: 'CUST100'})
CREATE (:Customer {id: 'CUST101', customer_id: 'CUST101'})

// Create Purchase Orders
CREATE (:PurchaseOrder {id: 'PO-2025-001', po_id: 'PO-2025-001', supplier_id: 'S001', date: '2025-04-01', status: 'delivered'})
CREATE (:PurchaseOrder {id: 'PO-2025-002', po_id: 'PO-2025-002', supplier_id: 'S002', date: '2025-04-10', status: 'in_transit'})
CREATE (:PurchaseOrder {id: 'PO-2025-003', po_id: 'PO-2025-003', supplier_id: 'S005', date: '2025-03-28', status: 'pending'})

// Create Invoices
CREATE (:Invoice {id: 'INV-1001', invoice_id: 'INV-1001', po_id: 'PO-2025-001', supplier: 'ABC Supplies Pvt Ltd', amount: 12500.5, due_date: '2025-04-30', status: 'paid'})
CREATE (:Invoice {id: 'INV-1002', invoice_id: 'INV-1002', po_id: 'PO-2025-003', supplier: 'Oceanic Imports', amount: 4500.0, due_date: '2025-05-15', status: 'unpaid'})

// Create Shipments
CREATE (:Shipment {id: 'SHP1001', shipment_id: 'SHP1001', po_id: 'PO-2025-001', carrier: 'BlueLine Logistics', eta: '2025-04-05', status: 'Delivered', notes: 'Arrived with minor packaging damage - inspected'})
CREATE (:Shipment {id: 'SHP1002', shipment_id: 'SHP1002', po_id: 'PO-2025-002', carrier: 'FastTrack', eta: '2025-04-15', status: 'In Transit', notes: 'Delay due to customs clearance.'})

// Create Carriers
CREATE (:Carrier {id: 'BlueLine_Logistics', name: 'BlueLine Logistics'})
CREATE (:Carrier {id: 'FastTrack', name: 'FastTrack'})

// Create Locations
CREATE (:Location {id: 'Chennai_Port', name: 'Chennai Port', type: 'Port'})

// Create Countries
CREATE (:Country {id: 'India', name: 'India'})
CREATE (:Country {id: 'China', name: 'China'})
CREATE (:Country {id: 'Germany', name: 'Germany'})
CREATE (:Country {id: 'USA', name: 'USA'})
CREATE (:Country {id: 'Malaysia', name: 'Malaysia'})

// Create Audit Reports
CREATE (:AuditReport {id: 'Audit_2024_Q4', period: '2024 Q4', summary: 'S001 minor non-conformances in labeling'})

// Create Meetings
CREATE (:Meeting {id: 'Meeting_2025_04_07', date: '2025-04-07', topic: 'vendor consolidation and lead-time improvements'})

// Create Systems
CREATE (:System {id: 'Inventory_Sync_System', name: 'Inventory Sync System', function: 'routine inventory synchronization'})

// Create Payment Terms
CREATE (:PaymentTerms {id: 'Net30', terms: 'Net30'})
CREATE (:PaymentTerms {id: 'Prepaid', terms: 'Prepaid'})

// Create Processes
CREATE (:Process {id: 'Routine_Sync', name: 'Routine Sync', type: 'inventory synchronization'})

// Create Relationships

// Supplier audit relationships
MATCH (s:Supplier {id: 'S001'}), (a:AuditReport {id: 'Audit_2024_Q4'})
CREATE (s)-[:HAS_AUDIT_FINDING {finding: 'minor non-conformances in labeling'}]->(a)

// Customer rating relationships
MATCH (c:Customer {id: 'CUST100'}), (p:Product {id: 'P1001'})
CREATE (c)-[:RATED {rating: 4, comment: 'Drill works well but battery life shorter than expected.', date: '2025-04-05'}]->(p)

MATCH (c:Customer {id: 'CUST101'}), (p:Product {id: 'P1004'})
CREATE (c)-[:RATED {rating: 5, comment: 'Boxes arrived sturdy and on time.', date: '2025-04-12'}]->(p)

// Product storage relationships
MATCH (p:Product {id: 'P1001'}), (w:Warehouse {id: 'WH-A'})
CREATE (p)-[:STORED_IN {quantity: 120}]->(w)

MATCH (p:Product {id: 'P1002'}), (w:Warehouse {id: 'WH-B'})
CREATE (p)-[:STORED_IN {quantity: 450}]->(w)

MATCH (p:Product {id: 'P1003'}), (w:Warehouse {id: 'WH-A'})
CREATE (p)-[:STORED_IN {quantity: 5000}]->(w)

MATCH (p:Product {id: 'P1004'}), (w:Warehouse {id: 'WH-C'})
CREATE (p)-[:STORED_IN {quantity: 800}]->(w)

// Invoice relationships
MATCH (i:Invoice {id: 'INV-1001'}), (po:PurchaseOrder {id: 'PO-2025-001'})
CREATE (i)-[:REFERENCES {amount: 12500.5}]->(po)

MATCH (i:Invoice {id: 'INV-1001'}), (s:Supplier {id: 'S001'})
CREATE (i)-[:FROM_SUPPLIER {status: 'paid'}]->(s)

MATCH (i:Invoice {id: 'INV-1002'}), (po:PurchaseOrder {id: 'PO-2025-003'})
CREATE (i)-[:REFERENCES {amount: 4500.0}]->(po)

MATCH (i:Invoice {id: 'INV-1002'}), (s:Supplier {id: 'S005'})
CREATE (i)-[:FROM_SUPPLIER {status: 'unpaid'}]->(s)

// Warehouse discrepancy relationships
MATCH (w:Warehouse {id: 'WH-A'}), (p:Product {id: 'P1003'})
CREATE (w)-[:HAS_DISCREPANCY {discrepancy: '-150 units', date: '2025-04-02'}]->(p)

// Purchase order delay relationships
MATCH (po:PurchaseOrder {id: 'PO-2025-002'}), (l:Location {id: 'Chennai_Port'})
CREATE (po)-[:DELAYED_AT {reason: 'documentation mismatch', date: '2025-04-11'}]->(l)

// Product relocation relationships
MATCH (p:Product {id: 'P1002'}), (w:Warehouse {id: 'WH-B'})
CREATE (p)-[:RELOCATED_FROM {reason: 'temp spike', date: '2025-04-20'}]->(w)

// Meeting action relationships
MATCH (m:Meeting {id: 'Meeting_2025_04_07'}), (s:Supplier {id: 'S001'})
CREATE (m)-[:ACTION_RENEGOTIATE {action: 'renegotiate terms'}]->(s)

MATCH (m:Meeting {id: 'Meeting_2025_04_07'}), (s:Supplier {id: 'S002'})
CREATE (m)-[:ACTION_AUDIT {action: 'audit S002'}]->(s)

// Purchase order supplier relationships
MATCH (po:PurchaseOrder {id: 'PO-2025-001'}), (s:Supplier {id: 'S001'})
CREATE (po)-[:FROM_SUPPLIER {date: '2025-04-01', status: 'delivered'}]->(s)

MATCH (po:PurchaseOrder {id: 'PO-2025-002'}), (s:Supplier {id: 'S002'})
CREATE (po)-[:FROM_SUPPLIER {date: '2025-04-10', status: 'in_transit'}]->(s)

MATCH (po:PurchaseOrder {id: 'PO-2025-003'}), (s:Supplier {id: 'S005'})
CREATE (po)-[:FROM_SUPPLIER {date: '2025-03-28', status: 'pending'}]->(s)

// Purchase order item relationships
MATCH (po:PurchaseOrder {id: 'PO-2025-001'}), (p:Product {id: 'P1001'})
CREATE (po)-[:CONTAINS_ITEM {quantity: 50}]->(p)

MATCH (po:PurchaseOrder {id: 'PO-2025-001'}), (p:Product {id: 'P1003'})
CREATE (po)-[:CONTAINS_ITEM {quantity: 2000}]->(p)

MATCH (po:PurchaseOrder {id: 'PO-2025-002'}), (p:Product {id: 'P1002'})
CREATE (po)-[:CONTAINS_ITEM {quantity: 300}]->(p)

MATCH (po:PurchaseOrder {id: 'PO-2025-003'}), (p:Product {id: 'P1004'})
CREATE (po)-[:CONTAINS_ITEM {quantity: 500}]->(p)

// Shipment location relationships
MATCH (s:Shipment {id: 'SHP1001'}), (l:Location {id: 'Chennai_Port'})
CREATE (s)-[:ARRIVED_AT {timestamp: '2025-04-02T08:00:00'}]->(l)

MATCH (s:Shipment {id: 'SHP1001'}), (w:Warehouse {id: 'WH-A'})
CREATE (s)-[:DELIVERED_TO {timestamp: '2025-04-03T14:00:00'}]->(w)

MATCH (s:Shipment {id: 'SHP1002'}), (l:Location {id: 'Chennai_Port'})
CREATE (s)-[:IN_TRANSIT_FROM {status: 'Customs Hold', timestamp: '2025-04-12T09:00:00'}]->(l)

// Shipment fulfillment relationships
MATCH (s:Shipment {id: 'SHP1001'}), (po:PurchaseOrder {id: 'PO-2025-001'})
CREATE (s)-[:FULFILLS {status: 'Delivered'}]->(po)

MATCH (s:Shipment {id: 'SHP1002'}), (po:PurchaseOrder {id: 'PO-2025-002'})
CREATE (s)-[:FULFILLS {status: 'In Transit'}]->(po)

// Shipment carrier relationships
MATCH (s:Shipment {id: 'SHP1001'}), (c:Carrier {id: 'BlueLine_Logistics'})
CREATE (s)-[:CARRIED_BY]->(c)

MATCH (s:Shipment {id: 'SHP1002'}), (c:Carrier {id: 'FastTrack'})
CREATE (s)-[:CARRIED_BY]->(c)

// Supplier payment terms relationships
MATCH (s:Supplier {id: 'S001'}), (pt:PaymentTerms {id: 'Net30'})
CREATE (s)-[:HAS_PAYMENT_TERMS {lead_time_days: 7}]->(pt)

MATCH (s:Supplier {id: 'S002'}), (pt:PaymentTerms {id: 'Prepaid'})
CREATE (s)-[:HAS_PAYMENT_TERMS {lead_time_days: 21}]->(pt)

// Supplier location relationships
MATCH (s:Supplier {id: 'S001'}), (c:Country {id: 'India'})
CREATE (s)-[:LOCATED_IN {contact: 'raju@abc.com'}]->(c)

MATCH (s:Supplier {id: 'S002'}), (c:Country {id: 'China'})
CREATE (s)-[:LOCATED_IN {contact: 'sales@globaltech.cn'}]->(c)

MATCH (s:Supplier {id: 'S003'}), (c:Country {id: 'Germany'})
CREATE (s)-[:LOCATED_IN {contact: 'info@delta.de'}]->(c)

MATCH (s:Supplier {id: 'S004'}), (c:Country {id: 'USA'})
CREATE (s)-[:LOCATED_IN {contact: 'support@rapidparts.com'}]->(c)

MATCH (s:Supplier {id: 'S005'}), (c:Country {id: 'Malaysia'})
CREATE (s)-[:LOCATED_IN {contact: 'contact@oceanic.my'}]->(c)

// System process relationships
MATCH (sys:System {id: 'Inventory_Sync_System'}), (p:Process {id: 'Routine_Sync'})
CREATE (sys)-[:PERFORMS {frequency: 'routine', type: 'inventory synchronization'}]->(p)

// Create indexes for better performance
CREATE INDEX supplier_id_index IF NOT EXISTS FOR (s:Supplier) ON (s.id)
CREATE INDEX product_id_index IF NOT EXISTS FOR (p:Product) ON (p.id)
CREATE INDEX warehouse_id_index IF NOT EXISTS FOR (w:Warehouse) ON (w.id)
CREATE INDEX customer_id_index IF NOT EXISTS FOR (c:Customer) ON (c.id)
CREATE INDEX po_id_index IF NOT EXISTS FOR (po:PurchaseOrder) ON (po.id)
CREATE INDEX invoice_id_index IF NOT EXISTS FOR (i:Invoice) ON (i.id)
CREATE INDEX shipment_id_index IF NOT EXISTS FOR (s:Shipment) ON (s.id)