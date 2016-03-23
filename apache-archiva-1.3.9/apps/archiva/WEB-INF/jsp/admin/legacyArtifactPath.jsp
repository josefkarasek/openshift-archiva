<%--
  ~ Licensed to the Apache Software Foundation (ASF) under one
  ~ or more contributor license agreements.  See the NOTICE file
  ~ distributed with this work for additional information
  ~ regarding copyright ownership.  The ASF licenses this file
  ~ to you under the Apache License, Version 2.0 (the
  ~ "License"); you may not use this file except in compliance
  ~ with the License.  You may obtain a copy of the License at
  ~
  ~   http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
  --%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="redback" uri="http://plexus.codehaus.org/redback/taglib-1.0" %>
<%@ taglib prefix="archiva"   uri="/WEB-INF/taglib.tld" %>

<html>
<head>
  <title>Administration - Legacy Support</title>
  <s:head/>
</head>

<body>

<h1>Administration - Legacy Artifact Path Resolution</h1>

<div id="contentArea">

<%-- changed the structure of displaying errorMessages & actionMessages in order for them to be escaped. --%>
<s:if test="hasActionErrors()">
      <ul>
      <s:iterator value="actionErrors">
          <li><span class="errorMessage"><s:property escape="true" /></span></li>
      </s:iterator>
      </ul>
  </s:if>
  <s:if test="hasActionMessages()">
      <ul>
      <s:iterator value="actionMessages">
          <li><span class="actionMessage"><s:property escape="true" /></span></li>
      </s:iterator>
      </ul>
  </s:if>

<div class="admin">
<div class="controls">
  <redback:ifAuthorized permission="archiva-manage-configuration">
    <s:url id="addLegacyArtifactPathUrl" action="addLegacyArtifactPath"/>
    <s:a href="%{addLegacyArtifactPathUrl}">
      <img src="<c:url value="/images/icons/create.png" />" alt="" width="16" height="16"/>
      Add
    </s:a>
  </redback:ifAuthorized>
</div>
<h2>Path Mappings</h2>

<c:choose>
<c:when test="${empty (legacyArtifactPaths)}">
  <%-- No paths. --%>
  <p><strong>There are no legacy artifact paths configured yet.</strong></p>
</c:when>
<c:otherwise>
  <%-- Display the paths. --%>

<c:forEach items="${legacyArtifactPaths}" var="legacyArtifactPath" varStatus="i">
<c:choose>
  <c:when test='${(i.index)%2 eq 0}'>
    <c:set var="rowColor" value="dark" scope="page"/>
  </c:when>
  <c:otherwise>
    <c:set var="rowColor" value="lite" scope="page"/>
  </c:otherwise>
</c:choose>

<div class="legacyArtifactPath ${rowColor}">
    
<div class="controls">
    <%-- TODO: make some icons --%>
  <redback:ifAnyAuthorized permissions="archiva-manage-configuration">
    <s:token/>
    <s:url id="deleteLegacyArtifactPath" encode="true" action="deleteLegacyArtifactPath">
      <s:param name="path" value="%{#attr.legacyArtifactPath.path}"/>
      <s:param name="struts.token.name">token</s:param>
      <s:param name="token"><s:property value="token"/></s:param>
    </s:url>
    <s:a href="%{deleteLegacyArtifactPath}">
      <img src="<c:url value="/images/icons/delete.gif" />" alt="" width="16" height="16"/>
      Delete
    </s:a>
  </redback:ifAnyAuthorized>
</div>

<%-- used c:out in displaying EL's so that they would be escaped --%>
<table class="infoTable">
<tr>
  <th>Path</th>
  <td>
    <code><c:out value="${legacyArtifactPath.path}" /></code>
  </td>
</tr>
<tr>
  <th>Artifact</th>
  <td>
    <code><c:out value="${legacyArtifactPath.artifact}" /></code>
  </td>
</tr>
</table>

</div>
</c:forEach>

</c:otherwise>
</c:choose>



</div>

</div>

</body>
</html>
