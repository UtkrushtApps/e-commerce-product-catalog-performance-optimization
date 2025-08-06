from fastapi import APIRouter, HTTPException, Query
from typing import List, Optional
from app.database import get_db_conn, release_db_conn
from app.schemas.schemas import Product, ProductsResponse

router = APIRouter()

@router.get("/products", response_model=ProductsResponse)
def list_products(
    category_id: Optional[int] = Query(None),
    brand_id: Optional[int] = Query(None)
):
    conn = get_db_conn()
    try:
        cur = conn.cursor()
        # Inefficient query: causes sequential scan, no index on filter columns
        base_sql = """
            SELECT p.id, p.name, c.name, b.name, p.price
            FROM products p
            JOIN categories c ON c.id = p.category_id
            JOIN brands b ON b.id = p.brand_id
        """
        filters = []
        params = []
        if category_id is not None:
            filters.append("p.category_id = %s")
            params.append(category_id)
        if brand_id is not None:
            filters.append("p.brand_id = %s")
            params.append(brand_id)
        if filters:
            base_sql += " WHERE " + " AND ".join(filters)
        base_sql += " ORDER BY p.id"
        cur.execute(base_sql, params)
        products = [
            Product(
                id=row[0], name=row[1], category=row[2], brand=row[3], price=row[4]
            ) for row in cur.fetchall()
        ]
        return ProductsResponse(products=products)
    finally:
        release_db_conn(conn)
