<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    public static string GetFileName(object obj) {
        if (obj == null) {
            return "style=\"background-image:url('../img/default.png')\"";
        } else {
            return $"style=\"background-image:url('../img/{obj}')\"";
        }
    }

    protected void Button1_Click(object sender, EventArgs e) {

    }

    protected void Page_Load(object sender, EventArgs e) {

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="flexColumnStart">
        <div class="cover flexRowStart">
            <div class="coverImg"></div>
            <div class="coverInfo flexColumnBetween">
                <h3>Tom Clancy's Rainbow Six® Siege</h3>
                <br />
                <h4>Purchase Now</h4>
            </div>
        </div>

        <div class="w3-container w3-text-grey" id="jeans">
            <p>8 items</p>
        </div>

        <div class="prodListForm">
        </div>

        <%--      <asp:Repeater ID="Repeater1" runat="server" DataSourceID="ObjectDataSource1">
            <HeaderTemplate>
                <div class="prodListForm">
            </HeaderTemplate>
            <ItemTemplate>

                <div class="w3-container prodItem">
                    <div class="prodItemImg" <%# GetFileName(Eval("ImageFileName")) %>>
                        <div class="buy-now-hover" style="width: 100%; height: 100%">
                            <a class="w3-button w3-black" href='<%# Eval("Id" , "/ProductDetail.aspx?id={0}")%>'>Buy now <i class="fa fa-shopping-cart"></i>
                            </a>
                        </div>
                    </div>
                    <p>
                        <%# Eval("Name") %><br>
                        <b>$<%# Eval("Price") %></b>
                    </p>
                </div>

            </ItemTemplate>
            <FooterTemplate>
                </div>
            </FooterTemplate>

        </asp:Repeater>

        <asp:ObjectDataSource runat="server" ID="ObjectDataSource1" SelectMethod="GetAllProd" TypeName="ProdUtility"></asp:ObjectDataSource>
        --%>
    </div>
    <ul id="myUL">
    </ul>
    <script>

        //$(function () {

        //    $.ajax({
        //        type: 'POST',
        //        url: '/WebService.asmx/GetMembers',
        //        contentType: "application/json;charset=utf-8",
        //        success: function (data) {

        //            $(data.d).each(function (index, item) {

        //                $("#myUL").append(`
        //                    <li class="w3-bar">
        //                        <span onclick="this.parentElement.style.display='none'" class="w3-bar-item w3-button w3-white w3-xlarge w3-right">×</span>
        //                        <img src="img_avatar5.png" class="w3-bar-item w3-circle w3-hide-small" style="width: 85px"/>
        //                        <div class="w3-bar-item">
        //                            <span class="w3-large">${item.Name}</span><br/>
        //                            <span>Web Designer ${item.ID}</span>
        //                        </div>
        //                    </li>`);

        //            });
        //        }
        //    });
        //});


        function GetFileNameAJAX(obj) {
            if (obj == null) {
                return "default.png";
            } else {
                return `${obj}`;
            }
        }

        $(function () {

            $.ajax({
                type: 'POST',
                url: '/WebService.asmx/GetAllProd',
                contentType: "application/json;charset=utf-8",
                success: function (data) {

                    $(data.d).each(function (index, item) {

                        $(".prodListForm").append(
                            `<div class="w3-container prodItem">` +
                            `   <div class="prodItemImg" style="background-image:url('../img/${GetFileNameAJAX(item.ImageFileName)}')"` +
                            `   </div>` +
                            `   <div class="buy-now-hover" style="width: 100%; height: 100%">`+

                            `       <a class="w3-button w3-black" href='/ProductDetail.aspx?id=${item.Id}'>`+
                            `           Buy now <i class="fa fa-shopping-cart"></i>` +
                            `       </a>` +

                            `   </div>`+
                            `</div>` +
                            `   <p>` +
                            `      ${item.Name}<br>` +
                            `      <b>$${item.Price}</b>` +
                            `   </p>` +
                            `</div>`

                            //`<div class="w3-container prodItem">` +
                            //`<div class="prodItemImg" ${GetFileName(item.ImageFileName)}>` +
                            //`<div class="buy-now-hover" style="width: 100%; height: 100%">` +
                            //`<a class="w3-button w3-black" href='#'>` +
                            //`Buy now <i class="fa fa-shopping-cart"></i>` +
                            //`</a>` +
                            //`</div>` +
                            //`</div>` +
                            //`<p>` +
                            //`${item.Name}<br></p>` +
                            //`</div>`
                        );

                    });
                }
            });
        });
    </script>

</asp:Content>

