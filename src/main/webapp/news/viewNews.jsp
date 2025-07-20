<%-- 
    Document   : viewNews
    Created on : 15-Jun-2025, 20:35:09
    Author     : dodan
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>News</title>
        <style>
            * {
                box-sizing: border-box;
            }

            body {
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: white;
                color: black;
            }

            h1 {
                text-align: center;
                padding: 40px 20px;
                background: white;
                color: black;
                font-size: 36px;
                margin: 0;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            .error-message {
                text-align: center;
                color: red;
                font-size: 18px;
                margin-top: 30px;
                font-weight: bold;
            }

            .news-container {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
                gap: 30px;
                padding: 40px 5%;
                max-width: 1400px;
                margin: auto;
            }

            .news-card {
                background-color: #ffffff;
                border-radius: 12px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
                overflow: hidden;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                height: 100%;
                transition: transform 0.25s ease, box-shadow 0.25s ease;
                border-left: 5px solid #1a237e;
            }

            .news-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 12px 25px rgba(26, 35, 126, 0.25);
            }

            .news-card img {
                width: 100%;
                height: 200px;
                object-fit: cover;
                border-bottom: 1px solid #eee;
            }

            .news-title {
                font-size: 20px;
                font-weight: bold;
                color: #1a237e;
                margin: 16px 16px 8px;
                min-height: 50px;
            }

            .news-summary {
                font-size: 15px;
                color: #444;
                margin: 0 16px 12px;
                line-height: 1.5;
            }

            .news-view {
                font-size: 14px;
                color: #666;
                margin: 0 16px 4px;
            }

            .news-meta {
                font-size: 13px;
                color: #888;
                margin: 8px 16px 16px;
                border-top: 1px solid #eee;
                padding-top: 10px;
            }

            a {
                text-decoration: none;
                color: inherit;
                display: block;
                height: 100%;
            }

            .back-button {
                top: -40px;
                left: 20px;
                width: 80px;
                background-color: #1a73e8;
                color: white;
                padding: 8px 12px;
                border-radius: 5px;
                font-size: 14px;
                text-decoration: none;
                display: inline-block;
            }
            .back-button:hover {
                background-color: #0c53b0;
            }


            @media (max-width: 768px) {
                h1 {
                    font-size: 28px;
                    padding: 30px 15px;
                }

                .news-title {
                    font-size: 18px;
                }

                .news-summary {
                    font-size: 14px;
                }
            }
        </style>
    </head>
    <body>
        <%@include file="../header/header.jsp"%> 
        <br><br><br>
        <a href="javascript:history.back()" class="back-button">← Back</a>

        <h1>Latest News</h1>

        <!-- Hiển thị thông báo lỗi nếu có -->
        <c:if test="${not empty message}">
            <script>
                alert("${message}");
                window.location.href = "<c:url value='/Index' />";
            </script>
        </c:if>

        <!-- Hiển thị danh sách tin tức nếu có dữ liệu -->
        <c:if test="${not empty newsList}">
            <div class="news-container">
                <c:forEach items="${newsList}" var="news"> 
                    <a href="ViewNewsDetail?id=${news.newsID}">
                        <div class="news-card">
                            <img src="${news.imageURL}" alt="Ảnh tin tức">
                            <div class="news-title">${news.title}</div>
                            <div class="news-summary">${news.summary}</div>
                            <div class="news-view">👁️ ${news.viewcount} Viewcount</div>
                            <div class="news-meta">🗓️ Posted Date: ${news.datePosted}</div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </c:if>
    </body>
</html>


