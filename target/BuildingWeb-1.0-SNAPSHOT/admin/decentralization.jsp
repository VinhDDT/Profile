<%-- 
    Document   : decentralization
    Created on : May 2, 2025, 5:19:20 PM
    Author     : Kiều Hoàng Mạnh Khang - ce180749 
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            nav ul {

                display: flex;
                list-style: none;
            }
            nav ul li {
                margin: 10px;
                display: flex;
                list-style: none;
            }

        </style>
    </head>
    <body>
        <div>Phân Quyền Cho: <td>${user.employees.fullName}</td></div>

        <table border="1">

            <tbody>

                <tr>

                    <td>
                        <form method="post" action="Decentralization">
                            <input type="hidden" value="${user.userId}" name="idHiden" > 
                            <select name="roleId">
                                <option <c:if  test="${user.role.roleName eq 'Quản lý' }">selected </c:if>  value="2">Quản lý</option>
                                <option <c:if test="${user.role.roleName eq 'Lễ tân' }">selected </c:if>  value="3">Lễ tân</option>
                                <option <c:if test="${user.role.roleName eq 'Nhân viên kỹ thuật'}">selected </c:if>  value="4">Nhân viên kỹ thuật</option>
                                <option <c:if test="${user.role.roleName eq 'Nhân viên dọn phòng'}"> selected</c:if> value="5">Nhân viên dọn phòng</option>
                            </select>
                            <button name="submit" style="submit" value="success" >Save</button>
                        </form>
                    </td> 
                </tr>            



            </tbody>

        </table>


    </body>
</html>
