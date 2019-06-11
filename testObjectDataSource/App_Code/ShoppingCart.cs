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
    public List<ShoppingCart> GetShoppingCartList(Dictionary<int, int> mapping, List<Prod> prodList) {
        var query = from prod in prodList
                    select new ShoppingCart() {
                        ID = prod.id,
                        Name = prod.name,
                        Price = prod.price,
                        ImageFileName = (prod.img == "") ? "default.png" : prod.img,
                        Count = mapping[prod.id]
                    };

        return query.ToList();
    }
}