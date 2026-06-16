# GraphQL E-commerce API

A custom PHP GraphQL API powering the [Roto Store](https://github.com/MohamedBediwe/Roto-store) e-commerce application. Built from scratch with `webonyx/graphql-php`, it handles product listings, user authentication with JWT, and order management backed by a MySQL database.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Language | PHP 8.2 |
| GraphQL | webonyx/graphql-php ^15 |
| Auth | firebase/php-jwt ^6 |
| Environment | vlucas/phpdotenv ^5 |
| Database | MySQL / MariaDB |
| Dependency Manager | Composer |

---

## Project Structure

```
graphql-ecomerce-api/
├── Config/
│   ├── Database.php        # PDO connection with custom query() helper
│   ├── JwtManager.php      # JWT encode/decode logic
│   ├── ErrorHandler.php    # Centralized error handling
│   └── Validator.php       # Input validation helpers
├── graphql/
│   ├── types/
│   │   ├── UserType.php
│   │   ├── ProductType.php
│   │   ├── OrderType.php
│   │   ├── OrderedProductType.php
│   │   ├── StatusEnumType.php
│   │   ├── QueryType.php       # Root query (singleton)
│   │   └── MutationType.php    # Root mutation (singleton)
│   └── resolvers/
│       ├── UserResolver.php
│       ├── ProductsResolver.php
│       └── OrderResolver.php
├── middleware/             # JWT auth middleware
├── public/                # Static assets / uploaded images
├── index.php              # Entry point — CORS, routing, GraphQL execution
├── schema.php             # Schema assembly
├── graphql.php            # (alternate entry / playground)
├── graphql.sql            # Full database dump with seed data
└── .htaccess              # URL rewriting
```

---

## Database Schema

Three tables, with `orders.user_id` as a foreign key to `users.id`.

### `users`
| Column | Type | Notes |
|---|---|---|
| `id` | INT AUTO_INCREMENT | Primary key |
| `email` | VARCHAR(255) | Unique |
| `name` | VARCHAR(255) | |
| `password` | VARCHAR(255) | bcrypt hashed |

### `products`
| Column | Type | Notes |
|---|---|---|
| `id` | INT AUTO_INCREMENT | Primary key |
| `title` | VARCHAR(255) | |
| `price` | DECIMAL(10,2) | |
| `quantity` | INT | Stock count |
| `image` | VARCHAR(255) | URL (e.g. `http://localhost/images/sofa.jpeg`) |
| `description` | TEXT | |
| `company` | VARCHAR(255) | Brand name |
| `colors` | JSON | Array of hex strings, e.g. `["#FFF","#000"]` |
| `category` | VARCHAR(255) | e.g. Chairs, Sofas, Beds, Tables, Kids |
| `featured` | TINYINT(1) | |
| `shipping` | SMALLINT | `1` = free shipping |

### `orders`
| Column | Type | Notes |
|---|---|---|
| `order_id` | INT AUTO_INCREMENT | Primary key |
| `user_id` | INT | FK → users.id |
| `ordered_products` | JSON (LONGTEXT) | Array of product snapshots |
| `total` | FLOAT | Order total |
| `status` | ENUM | `pending`, `shipped`, `delivered`, `cancelled` |
| `address` | VARCHAR(255) | |
| `name` | VARCHAR(255) | Recipient name |
| `numItemsInCart` | INT | Total item count |
| `created_at` | DATETIME | Defaults to current timestamp |

Each item in `ordered_products` is stored as a JSON snapshot:
```json
{
  "productID": 1,
  "amount": 2,
  "cartID": "1#FFF",
  "company": "IKEA",
  "image": "http://localhost/images/stuhl.webp",
  "price": 99.99,
  "productColor": "#FFF",
  "title": "Stuhl"
}
```

---

## GraphQL API

**Endpoint:** `POST /index.php`  
**Content-Type:** `application/json`

All requests use a standard JSON body:
```json
{
  "query": "...",
  "variables": {}
}
```

### Queries

#### `products` — fetch product list with optional filters
```graphql
query {
  products(
    category: "Sofas"
    company: "IKEA"
    price: 200
    shipping: true
    search: "sofa"
    order: "low"   # a-z | z-a | low | high
  ) {
    id
    title
    price
    image
    company
    colors
    category
    shipping
    featured
  }
}
```

#### `product` — fetch a single product by ID
```graphql
query {
  product(id: 1) {
    id
    title
    price
    description
    colors
  }
}
```

#### `orders` — fetch orders for the authenticated user (requires JWT)
```graphql
query {
  orders {
    order_id
    total
    status
    address
    name
    numItemsInCart
    created_at
    ordered_products {
      productID
      title
      price
      amount
      image
    }
  }
}
```
> Pass JWT in the `Authorization: Bearer <token>` header.

---

### Mutations

#### `login` — authenticate a user
```graphql
mutation {
  login(email: "user@example.com", password: "secret") {
    token
    user {
      id
      name
      email
    }
  }
}
```

#### `register` — create a new user
```graphql
mutation {
  register(name: "John", email: "john@example.com", password: "secret") {
    token
    user {
      id
      name
      email
    }
  }
}
```

#### `createOrder` — place an order (requires JWT)
```graphql
mutation {
  createOrder(
    ordered_products: "[{...}]"
    total: 199.99
    address: "Alexandria, Egypt"
    name: "Mohamed"
    numItemsInCart: 2
  ) {
    order_id
    status
    created_at
  }
}
```

---

## Setup

### Prerequisites

- PHP 8.1+
- Composer
- MySQL / MariaDB
- Apache (with `mod_rewrite` enabled) or any PHP-capable web server

### Installation

```bash
# Clone the repository
git clone https://github.com/MohamedBediwe/graphql-ecomerce-api.git
cd graphql-ecomerce-api

# Install PHP dependencies
composer install
```

### Environment Variables

Create a `.env` file in the root directory:

```env
DB_HOST=localhost
DB_NAME=graphql
DB_USER=root
DB_PASSWORD=your_password
JWT_SECRET=your_jwt_secret_key
```

### Database Setup

Import the included SQL dump to seed the database with tables and sample data:

```bash
mysql -u root -p graphql < graphql.sql
```

Or import it via phpMyAdmin.

### Image Storage

Product images are stored at `http://localhost/images/<filename>` by default. Update the `image` column values in the `products` table to match your server's public path if deploying to a live environment.

---

## CORS & Deployment

The API is configured to allow all origins in `index.php`:

```php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
```

The `.htaccess` file handles URL rewriting for clean routing. This API is deployed on **InfinityFree** shared hosting.

> **Note for mixed-content:** If your frontend is on HTTPS and the API is on HTTP, browsers will block requests. A Firebase Functions proxy can bridge this.

---

## Related

- **Frontend (Roto Store):** [github.com/MohamedBediwe/Roto-store](https://github.com/MohamedBediwe/Roto-store)
- **Live Demo:** [roto-store.vercel.app](https://roto-store.vercel.app)

---

## Author

**Mohamed Bediwe** — Junior Full-Stack Developer  
[GitHub](https://github.com/MohamedBediwe) · [Portfolio](https://mohamedbediwe.github.io/Portfolio)

---

## License

This project is open source and available under the [MIT License](LICENSE).
