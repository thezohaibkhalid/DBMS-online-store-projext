-- Shopkeepers table
CREATE TABLE Shopkeepers (
    shopkeeper_id INT PRIMARY KEY,
    shop_name VARCHAR(255),
    owner_name VARCHAR(255),
    contact_number VARCHAR(20),
    CNIC VARCHAR(15),
    shop_address VARCHAR(255),
    shop_distance FLOAT,
    shop_type VARCHAR(50),
    latitude FLOAT,
    longitude FLOAT,
    warehouse_id INT,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id)
);

-- Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    shopkeeper_id INT,
    order_date DATE,
    delivery_date DATE,
    total_amount DECIMAL(10,2),
    status_id INT,
    FOREIGN KEY (shopkeeper_id) REFERENCES Shopkeepers(shopkeeper_id),
    FOREIGN KEY (status_id) REFERENCES OrderStatus(status_id)
);

-- Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    category_id INT,
    supplier_id INT,
    price DECIMAL(10,2),
    discount DECIMAL(5,2),
    rating DECIMAL(3,2),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

-- Categories table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

-- Suppliers table
CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(255),
    contact_number VARCHAR(20),
    address VARCHAR(255),
    email VARCHAR(100)
);

-- Warehouses table
CREATE TABLE Warehouses (
    warehouse_id INT PRIMARY KEY,
    warehouse_name VARCHAR(255),
    location VARCHAR(255),
    latitude FLOAT,
    longitude FLOAT
);

-- WarehouseStaff table
CREATE TABLE WarehouseStaff (
    staff_id INT PRIMARY KEY,
    warehouse_id INT,
    staff_name VARCHAR(255),
    role_id INT,
    email VARCHAR(100),
    hire_date DATE,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id),
    FOREIGN KEY (role_id) REFERENCES StaffRoles(role_id)
);

-- Vehicles table
CREATE TABLE Vehicles (
    vehicle_id INT PRIMARY KEY,
    vehicle_type VARCHAR(100),
    vehicle_number VARCHAR(20),
    warehouse_id INT,
    capacity INT,
    condition VARCHAR(100),
    availability_status BOOLEAN,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id)
);

-- Notifications table
CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY,
    warehouse_id INT,
    manager_id INT,
    notification_text TEXT,
    created_at TIMESTAMP,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id),
    FOREIGN KEY (manager_id) REFERENCES WarehouseStaff(staff_id)
);

-- Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    contact_number VARCHAR(20),
    address VARCHAR(255),
    email VARCHAR(100)
);

-- UserCredentials table
CREATE TABLE UserCredentials (
    user_id INT PRIMARY KEY,
    username VARCHAR(100),
    password VARCHAR(255),
    role_id INT,
    FOREIGN KEY (role_id) REFERENCES UserRoles(role_id)
);

-- UserRoles table
CREATE TABLE UserRoles (
    role_id INT PRIMARY KEY,
    role_name VARCHAR(100)
);

-- WarehouseInventory table
CREATE TABLE WarehouseInventory (
    inventory_id INT PRIMARY KEY,
    warehouse_id INT,
    product_id INT,
    quantity INT,
    status VARCHAR(50),
    last_update_date DATE,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Delivery table
CREATE TABLE Delivery (
    delivery_id INT PRIMARY KEY,
    order_id INT,
    vehicle_id INT,
    delivery_date DATE,
    delivery_time TIME,
    status VARCHAR(50),
    driver_id INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id),
    FOREIGN KEY (driver_id) REFERENCES WarehouseStaff(staff_id)
);

-- Payments table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    amount DECIMAL(10,2),
    transaction_id VARCHAR(100),
    payment_status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Promotions table
CREATE TABLE Promotions (
    promotion_id INT PRIMARY KEY,
    promotion_name VARCHAR(255),
    discount_percentage DECIMAL(5,2),
    start_date DATE,
    end_date DATE,
    promotion_type VARCHAR(100),
    terms_and_conditions TEXT
);

-- OrderItems table
CREATE TABLE OrderItems (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    total_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Feedback table
CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY,
    order_id INT,
    rating DECIMAL(3,2),
    comments TEXT,
    feedback_date DATE,
    response_status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- DeliveryRoutes table
CREATE TABLE DeliveryRoutes (
    route_id INT PRIMARY KEY,
    warehouse_id INT,
    delivery_area VARCHAR(255),
    distance FLOAT,
    special_offer BOOLEAN,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id)
);

-- DeliveryCharges table
CREATE TABLE DeliveryCharges (
    charge_id INT PRIMARY KEY,
    route_id INT,
    charge_amount DECIMAL(10,2),
    special_offer_discount DECIMAL(5,2),
    FOREIGN KEY (route_id) REFERENCES DeliveryRoutes(route_id)
);

-- StaffRoles table
CREATE TABLE StaffRoles (
    staff_role_id INT PRIMARY KEY,
    role_name VARCHAR(100)
);

-- Staff table
CREATE TABLE Staff (
    staff_id INT PRIMARY KEY,
    staff_name VARCHAR(255),
    staff_role_id INT,
    warehouse_id INT,
    email VARCHAR(100),
    hire_date DATE,
    FOREIGN KEY (staff_role_id) REFERENCES StaffRoles(staff_role_id),
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id)
);

-- OrderStatus table
CREATE TABLE OrderStatus (
    status_id INT PRIMARY KEY,
    status_name VARCHAR(100)
);

-- OrderStatusHistory table
CREATE TABLE OrderStatusHistory (
    history_id INT PRIMARY KEY,
    order_id INT,
    status_id INT,
    status_date TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (status_id) REFERENCES OrderStatus(status_id)
);

-- ProductReviews table
CREATE TABLE ProductReviews (
    review_id INT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    review_text TEXT,
    rating DECIMAL(3,2),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- CustomerOrders table
CREATE TABLE CustomerOrders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    delivery_date DATE,
    total_amount DECIMAL(10,2),
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (status_id) REFERENCES OrderStatus(status_id)
);

-- WarehouseSupervisors table
CREATE TABLE WarehouseSupervisors (
    supervisor_id INT PRIMARY KEY,
    warehouse_id INT,
    supervisor_name VARCHAR(255),
    contact_number VARCHAR(20),
    department VARCHAR(100),
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id)
);

-- WarehouseNotifications table
CREATE TABLE WarehouseNotifications (
    notification_id INT PRIMARY KEY,
    warehouse_id INT,
    manager_id INT,
    notification_text TEXT,
    created_at TIMESTAMP,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id),
    FOREIGN KEY (manager_id) REFERENCES WarehouseStaff(staff_id)
);

-- WarehouseCategories table
CREATE TABLE WarehouseCategories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

-- WarehouseInventoryLogs table
CREATE TABLE WarehouseInventoryLogs (
    log_id INT PRIMARY KEY,
    inventory_id INT,
    log_date TIMESTAMP,
    action VARCHAR(100),
    quantity_changed INT,
    FOREIGN KEY (inventory_id) REFERENCES WarehouseInventory(inventory_id)
);
