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
<title>Administration - Repository Scanning</title>
<s:head />
</head>

<body>

<h1>Administration - Repository Scanning</h1>

<div id="contentArea">

<s:actionerror /> 
<s:actionmessage /> 

<c:url var="iconDeleteUrl" value="/images/icons/delete.gif" /> 
<c:url var="iconCreateUrl" value="/images/icons/create.png" />
<s:url id="removeFiletypePatternUrl" action="repositoryScanning_removeFiletypePattern"/>
<s:url id="addFiletypePatternUrl" action="repositoryScanning_addFiletypePattern"/>
   
<script type="text/javascript">
<!--
  function removeFiletypePattern(filetypeId, pattern)
  {
     var f = document.getElementById('filetypeForm');
     
     f.action = "${removeFiletypePatternUrl}";
     f['pattern'].value = pattern;
     f['fileTypeId'].value = filetypeId;
     f.submit();
  }
  
  function addFiletypePattern(filetypeId, newPatternId)
  {
     var f = document.forms['filetypeForm'];
          
     f.action = "${addFiletypePatternUrl}";     
     f.elements['pattern'].value = document.getElementById(newPatternId).value;
     f.elements['fileTypeId'].value = filetypeId;
     f.submit();
  }
//-->
</script>

<div class="admin">
<h2>Repository Scanning - File Types</h2>

<c:choose>
  <c:when test="${empty (fileTypeMap)}">
    <%-- No File Types. Eeek! --%>
    <strong>There are no file types configured.</strong>
  </c:when>
  <c:otherwise>
    <%-- Display the filetypes. --%>

    <s:form method="post" action="repositoryScanning" 
             namespace="/admin" validate="false" 
             id="filetypeForm" theme="simple">
      <s:token/>
      <input type="hidden" name="pattern" />
      <input type="hidden" name="fileTypeId" />
    </s:form>
    
    <c:forEach items="${fileTypeIds}" var="filetypeId" varStatus="j">

      <div class="filetype">

      <div class="controls"><%-- Does this even make sense for file types? --%></div>

      <h3 class="filetype">${filetypeId}</h3>

      <table>
        <c:forEach items="${fileTypeMap[filetypeId].patterns}" var="pattern" varStatus="i">
          <c:choose>
            <c:when test='${(i.index)%2 eq 0}'>
              <c:set var="bgcolor" value="even" scope="page" />
            </c:when>
            <c:otherwise>
              <c:set var="bgcolor" value="odd" scope="page" />
            </c:otherwise>
          </c:choose>

          <c:set var="escapedPattern" value="${fn:escapeXml(pattern)}" scope="page" />
          
          <tr>
            <td class="pattern ${bgcolor}">
              <code>${escapedPattern}</code>
            </td>
            <td class="controls ${bgcolor}">
              <s:a href="#" title="Remove [%{#attr.escapedPattern}] Pattern from [%{#attr.filetypeId}]"
                    onclick="removeFiletypePattern( '%{#attr.filetypeId}', '%{#attr.escapedPattern}' )"
                    theme="simple">
                <img src="${iconDeleteUrl}" />
              </s:a>
            </td>
          </tr>
        </c:forEach>
        <tr>
          <td>
            <s:textfield size="40" 
                          id="newpattern_%{#attr.j.index}"
                          theme="simple" />
          </td>
          <td>
            <s:a href="#" 
                  title="Add Pattern to [%{#attr.filetypeId}]"
                  onclick="addFiletypePattern( '%{#attr.filetypeId}', 'newpattern_%{#attr.j.index}' )"
                  theme="simple">
              <img src="${iconCreateUrl}" />
            </s:a>
          </td>
        </tr>
      </table>

      </div>
    </c:forEach>

  </c:otherwise>
</c:choose>

<h2>Repository Scanning - Consumers of Known Content</h2>

<c:choose>
  <c:when test="${empty (knownContentConsumers)}">
    <%-- No Good Consumers. Eeek! --%>
    <strong>There are no consumers of known content available.</strong>
  </c:when>
  <c:otherwise>
    <%-- Display the consumers. --%>

    <s:form method="post" action="repositoryScanning_updateKnownConsumers"
             namespace="/admin" validate="false" theme="simple">
    <s:token/>
    <table class="consumers">
      <tr>
        <th>&nbsp;</th>
        <th>Enabled?</th>
        <th>ID</th>
        <th>Description</th>
      </tr>
      <c:forEach items="${knownContentConsumers}" var="consumer" varStatus="i">
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
            <input type="checkbox" name="enabledKnownContentConsumers" theme="simple" value="${consumer.id}" <c:if test="${consumer.enabled}">checked</c:if> />
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


<h2>Repository Scanning - Consumers of Invalid Content</h2>

<c:choose>
  <c:when test="${empty (invalidContentConsumers)}">
    <%-- No Consumers. Eeek! --%>
    <strong>There are no consumers of invalid content available.</strong>
  </c:when>
  <c:otherwise>
    <%-- Display the consumers. --%>

    <s:form method="post" action="repositoryScanning_updateInvalidConsumers"
             namespace="/admin" validate="false" theme="simple">
    <s:token/>         
    <table class="consumers">
      <tr>
        <th>&nbsp;</th>
        <th>Enabled?</th>
        <th>ID</th>
        <th>Description</th>
      </tr>
      <c:forEach items="${invalidContentConsumers}" var="consumer" varStatus="i">
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
            <input type="checkbox" name="enabledInvalidContentConsumers" theme="simple" value="${consumer.id}" <c:if test="${consumer.enabled}">checked</c:if> />
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
</c:choose></div>
</div>
</body>
</html>
