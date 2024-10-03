class Product{
	int? id;
	String? name;
	String? brand;
	String? price;
  
	productMap() {
		var mapping = Map<String, dynamic>();
		mapping['id'] = id ?? null;
		mapping['name'] = name!;
		mapping['brand'] = brand!;
		mapping['price'] = price!;
		return mapping;
	  }
} 