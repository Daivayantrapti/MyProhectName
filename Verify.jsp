<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%!
  private String escapeHtml(String value) {
    return value.replace("&", "&amp;")
        .replace("<", "&lt;")
        .replace(">", "&gt;")
        .replace("\"", "&quot;")
        .replace("'", "&#x27;");
  }
%>
<%
  if (!"POST".equalsIgnoreCase(request.getMethod())) {
    response.sendRedirect("test.html");
    return;
  }

  String name = request.getParameter("name");
  String email = request.getParameter("email");
  String summary = request.getParameter("summary");

  name = name == null ? "" : name.trim();
  email = email == null ? "" : email.trim();
  summary = summary == null ? "" : summary;

  boolean validName = !name.isEmpty()
      && name.length() < 10
      && Character.isUpperCase(name.charAt(0));
  boolean validEmail = email.matches("(?i)^[^\\s@]+@gmail\\.com$");
  boolean validSummary = !summary.trim().isEmpty();

  if (!validName || !validEmail || !validSummary) {
    response.sendRedirect("test.html?error=invalid");
    return;
  }
%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Preparing your result | Clear Choices</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <main class="page-shell">
    <section class="card">
      <p class="eyebrow">Details verified</p>
      <h1>Your result is ready.</h1>
      <p class="intro">Taking you to your submitted summary…</p>
      <div id="verified-data"
           data-name="<%= escapeHtml(name) %>"
           data-email="<%= escapeHtml(email) %>">
        <textarea id="verified-summary" hidden><%= escapeHtml(summary) %></textarea>
      </div>
      <noscript>Enable JavaScript in this browser tab to view your result.</noscript>
    </section>
  </main>
  <script>
    const data = document.getElementById("verified-data");
    const summary = document.getElementById("verified-summary").value;
    sessionStorage.setItem("clearChoicesSubmission", JSON.stringify({
      name: data.dataset.name,
      email: data.dataset.email,
      summary
    }));
    window.location.replace("display.html");
  </script>
</body>
</html>
