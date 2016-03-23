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
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="redback" uri="http://plexus.codehaus.org/redback/taglib-1.0" %>
<%@ taglib prefix="archiva"   uri="/WEB-INF/taglib.tld" %>

<html>
<head>
<title>Administration - Database</title>
<s:head />
</head>

<body>

<h1>Administration - Database</h1>

<div id="contentArea">

<s:actionerror /> 
<s:actionmessage /> 

<c:url var="iconDeleteUrl" value="/images/icons/delete.gif" /> 
<c:url var="iconCreateUrl" value="/images/icons/create.png" /> 
   
<div class="admin">

<h2>Database - Unprocessed Artifacts Scanning</h2>

  <s:form method="post" action="database_updateSchedule"
             namespace="/admin" validate="false" theme="simple">
    <s:token/>
    <table>
      <s:textfield name="cron" label="Cron" size="40" theme="xhtml" />
      <tr>
        <td colspan="2">
          <s:submit value="Update Cron" />
        </td>
      </tr>
    </table>                 
  </s:form>
  
  <s:form action="updateDatabase" theme="simple">
    <s:submit value="Update Database Now"/>
  </s:form>

<h2>Database - Unprocessed Artifacts Scanning</h2>

<c:choose>
  <c:when test="${empty (unprocessedConsumers)}">
    <%-- No Consumers. Eeek! --%>
    <strong>There are no consumers for unprocessed artifacts.</strong>
  </c:when>
  <c:otherwise>
    <%-- Display the consumers. --%>

    <s:form method="post" action="database_updateUnprocessedConsumers"
             namespace="/admin" validate="false" theme="simple">
    <s:token/>         
    <table class="consumers">
      <tr>
        <th>&nbsp;</th>
        <th>Enabled?</th>
        <th>ID</th>
        <th>Description</th>
      </tr>
      <c:forEach items="${unprocessedConsumers}" var="consumer" varStatus="i">
        <c:choose>
          <c:when test='${(i.index)%2 eq 0}'>
            <c:set var="bgcolor" value="even" scope="page" />
          </c:when>
          <c:otherwise>
            <c:set var="bgcolor" value="odd" scope="page" />
          </c:otherwise>
        </c:choose>

        <tr>
          <td class="${bgcolor}">
            <input type="checkbox" name="enabledUnprocessedConsumers" theme="simple" value="${consumer.id}" <c:if test="${consumer.enabled}">checked</c:if> />
          </td>
          <td class="${bgcolor}">
            <c:if test="${consumer.enabled}">
              <strong>enabled</strong>
            </c:if>
          </td>
          <td class="${bgcolor}">
            <code>${consumer.id}</code>
          </td>
          <td class="${bgcolor}">${consumer.description}</td>
        </tr>
      </c:forEach>
      <tr>
        <td colspan="4">
          <s:submit value="Update Consumers" />
        </td>
      </tr>
    </table>
    </s:form>

  </c:otherwise>
</c:choose>

<h2>Database - Artifact Cleanup Scanning</h2>

<c:choose>
  <c:when test="${empty (cleanupConsumers)}">
    <%-- No Consumers. Eeek! --%>
    <strong>There are no consumers for artifact cleanup.</strong>
  </c:when>
  <c:otherwise>
    <%-- Display the consumers. --%>

    <s:form method="post" action="database_updateCleanupConsumers"
             namespace="/admin" validate="false" theme="simple">
    <s:token/>
    <table class="consumers">
      <tr>
        <th>&nbsp;</th>
        <th>Enabled?</th>
        <th>ID</th>
        <th>Description</th>
      </tr>
      <c:forEach items="${cleanupConsumers}" var="consumer" varStatus="i">
        <c:choose>
          <c:when test='${(i.index)%2 eq 0}'>
            <c:set var="bgcolor" value="even" scope="page" />
          </c:when>
          <c:otherwise>
            <c:set var="bgcolor" value="odd" scope="page" />
          </c:otherwise>
        </c:choose>

        <tr>
          <td class="${bgcolor}">
            <input type="checkbox" name="enabledCleanupConsumers" theme="simple" value="${consumer.id}" <c:if test="${consumer.enabled}">checked</c:if> />
          </td>
          <td class="${bgcolor}">
            <c:if test="${consumer.enabled}">
              <strong>enabled</strong>
            </c:if>
          </td>
          <td class="${bgcolor}">
            <code>${consumer.id}</code>
          </td>
          <td class="${bgcolor}">${consumer.description}</td>
        </tr>
      </c:forEach>
      <tr>
        <td colspan="4">
          <s:submit value="Update Consumers" />
        </td>
      </tr>
    </table>
    </s:form>

  </c:otherwise>
</c:choose>


</div>
</div>
</body>
</html>
