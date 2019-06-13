using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ShoppingCart
/// </summary>
public class ShoppingCart {
    public int ID { get; set; }
    public string Name { get; set; }
    public int Price { get; set; }
    public int Count { get; set; }
    public string ImageFileName { get; set; }
}

public class ShoppingCartUtility {
    public List<ShoppingCart> GetShoppingCartList(Dictionary<int, int> mapping, List<Product> prodList) {
        var query = from prod in prodList
                    select new ShoppingCart() {
                        ID = prod.Id,
                        Name = prod.Name,
                        Price = prod.Price,
                        ImageFileName = (prod.ImageFileName == "") ? "default.png" : prod.ImageFileName,
                        Count = mapping[prod.Id]
                    };

        return query.ToList();
    }
}