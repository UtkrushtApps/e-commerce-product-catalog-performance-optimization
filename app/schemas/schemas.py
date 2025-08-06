from pydantic import BaseModel
from typing import List

class Product(BaseModel):
    id: int
    name: str
    category: str
    brand: str
    price: float

class ProductsResponse(BaseModel):
    products: List[Product]
