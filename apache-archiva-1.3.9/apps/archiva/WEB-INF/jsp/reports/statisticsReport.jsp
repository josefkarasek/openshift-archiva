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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="archiva"   uri="/WEB-INF/taglib.tld" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
<head>
  <title>Reports</title>
  <s:head/>
</head>

<body>
<h1>Statistics Report</h1>

<c:url var="imgNextPageUrl" value="/images/icon_next_page.gif"/>
<c:url var="imgPrevPageUrl" value="/images/icon_prev_page.gif"/>
<c:url var="imgPrevPageDisabledUrl" value="/images/icon_prev_page_disabled.gif"/>
<c:url var="imgNextPageDisabledUrl" value="/images/icon_next_page_disabled.gif"/>

<div id="contentArea">  		

  <%-- TODO: fix problem in date format! --%>

  <%-- Pagination - start --%>  
  <p>
    
    <%-- Set Prev & Next icons --%>
  <c:set var="prevPageUrl">
    <s:url action="generateStatisticsReport" namespace="/report">    
      <s:param name="selectedRepositories" value="%{#attr.selectedRepositories}"/>
      <s:param name="rowCount" value="%{#attr.rowCount}"/>
      <s:param name="startDate" value="%{#attr.startDate}"/>                      
      <s:param name="endDate" value="%{#attr.endDate}"/>
      <s:param name="page" value="%{#attr.page - 1}"/>
    </s:url>
  </c:set>
  <c:set var="nextPageUrl">
    <s:url action="generateStatisticsReport" namespace="/report">    
      <s:param name="selectedRepositories" value="%{#attr.selectedRepositories}"/>
      <s:param name="rowCount" value="%{#attr.rowCount}"/>
      <s:param name="startDate" value="%{#attr.startDate}"/>                      
      <s:param name="endDate" value="%{#attr.endDate}"/>                
      <s:param name="page" value="%{#attr.page + 1}"/>
    </s:url>
  </c:set>
    
  <c:choose>
    <c:when test="${page == 1}">                               
      <img src="${imgPrevPageDisabledUrl}"/>
    </c:when>
    <c:otherwise>
      <a href="${prevPageUrl}">
        <img src="${imgPrevPageUrl}"/>
      </a>
    </c:otherwise>
  </c:choose>
    
  <%-- Google-style pagination --%>
  <c:choose>
    <c:when test="${limits.countOfPages > 11}">
      <c:choose>
        <c:when test="${(page - 5) < 0}">
          <c:set var="beginVal">0</c:set>
          <c:set var="endVal">10</c:set> 
        </c:when>			        
        <c:when test="${(page + 5) > (limits.countOfPages - 1)}">
          <c:set var="beginVal">${(limits.countOfPages -1) - 10}</c:set>
          <c:set var="endVal">${limits.countOfPages - 1}</c:set>
        </c:when>
        <c:otherwise>
          <c:set var="beginVal">${page - 5}</c:set>
          <c:set var="endVal">${page + 5}</c:set>
        </c:otherwise>
      </c:choose>  
    </c:when>
    <c:otherwise>
      <c:set var="beginVal">0</c:set>
      <c:set var="endVal">${limits.countOfPages - 1}</c:set> 
    </c:otherwise>
  </c:choose>
    
  <c:forEach var="i" begin="${beginVal}" end="${endVal}">      
    <c:choose>                   			    
      <c:when test="${i != (page - 1)}">
        <c:set var="specificPageUrl">
          <s:url action="generateStatisticsReport" namespace="/report">
            <s:param name="selectedRepositories" value="%{#attr.selectedRepositories}"/>
            <s:param name="rowCount" value="%{#attr.rowCount}"/>
            <s:param name="startDate" value="%{#attr.startDate}"/>                      
            <s:param name="endDate" value="%{#attr.endDate}"/>
            <s:param name="page" value="%{#attr.page + 1}"/>
          </s:url>
        </c:set>
        <a href="${specificPageUrl}">${i + 1}</a>
      </c:when>
      <c:otherwise>		
        <b>${i + 1}</b>   
      </c:otherwise>				  			    
    </c:choose>      
  </c:forEach>
     
  <c:choose>
    <c:when test="${page == limits.countOfPages}">
      <img src="${imgNextPageDisabledUrl}"/>
    </c:when>
    <c:otherwise>
      <a href="${nextPageUrl}">
        <img src="${imgNextPageUrl}"/>
      </a>
    </c:otherwise>   
  </c:choose> 
  </p>   
  <%-- Pagination - end --%>
  
  <%-- Export to CSV link --%>
  <s:url id="downloadStatsReportUrl" action="downloadStatsReport" namespace="/report">
    <s:param name="selectedRepositories" value="%{#attr.selectedRepositories}"/>
    <s:param name="startDate" value="%{#attr.startDate}"/>                      
    <s:param name="endDate" value="%{#attr.endDate}"/>
  </s:url>
  <s:a href="%{downloadStatsReportUrl}">Export to CSV</s:a>
            
  <c:choose>
    <c:when test="${reposSize > 1}">
  	
      <h1>Latest Statistics Comparison Report</h1>  	    
      <table class="infoTable" border="1">
        <tr>
          <th>Repository</th>
          <th>Total File Count</th>
          <th>Total Size</th>
          <th>Artifact Count</th>
          <th>Group Count</th>
          <th>Project Count</th>
          <th>Plugins</th>
          <th>Archetypes</th>
          <th>Jars</th>
          <th>Wars</th>
          <th>Ears</th>
          <th>Exes</th>
          <th>Dlls</th>
          <th>Zips</th>
          <th>Deployments</th>
          <th>Downloads</th>
        </tr>			
		
        <c:forEach var="stats" items="${repositoryStatistics}">
        <tr>
          <td>${stats.repositoryId}</td>
          <td align="right">${stats.fileCount}</td>
          <td align="right">${stats.totalSize}</td>
          <td align="right">${stats.artifactCount}</td>
          <td align="right">${stats.groupCount}</td>
          <td align="right">${stats.projectCount}</td>
          <td align="right">${stats.pluginCount}</td>
          <td align="right">${stats.archetypeCount}</td>
          <td align="right">${stats.jarCount}</td>
          <td align="right">${stats.warCount}</td>
          <td align="right">${stats.earCount}</td>
          <td align="right">${stats.exeCount}</td>
          <td align="right">${stats.dllCount}</td>
          <td align="right">${stats.zipCount}</td>
          <td align="right">${stats.deploymentCount}</td>
          <td align="right">${stats.downloadCount}</td>
        </tr>				
        </c:forEach>
      </table>  		
    </c:when>
    <c:otherwise>
  	
      <h1>Statistics for Repository '${selectedRepo}'</h1>
      <table class="infoTable" border="1">
        <tr>
          <th>Date of Scan</th>
          <th>Total File Count</th>
          <th>Total Size</th>
          <th>Artifact Count</th>
          <th>Group Count</th>
          <th>Project Count</th>
          <th>Plugins</th>
          <th>Archetypes</th>
          <th>Jars</th>
          <th>Wars</th>
          <th>Ears</th>
          <th>Exes</th>
          <th>Dlls</th>
          <th>Zips</th>
          <th>Deployments</th>
          <th>Downloads</th>
        </tr>			
	  		
        <c:forEach var="stats" items="${repositoryStatistics}">
        <tr>
          <td align="right">${stats.dateOfScan}</td>
          <td align="right">${stats.fileCount}</td>
          <td align="right">${stats.totalSize}</td>
          <td align="right">${stats.artifactCount}</td>
          <td align="right">${stats.groupCount}</td>
          <td align="right">${stats.projectCount}</td>
          <td align="right">${stats.pluginCount}</td>
          <td align="right">${stats.archetypeCount}</td>
          <td align="right">${stats.jarCount}</td>
          <td align="right">${stats.warCount}</td>
          <td align="right">${stats.earCount}</td>
          <td align="right">${stats.exeCount}</td>
          <td align="right">${stats.dllCount}</td>
          <td align="right">${stats.zipCount}</td>
          <td align="right">${stats.deploymentCount}</td>
          <td align="right">${stats.downloadCount}</td>
        </tr>				
        </c:forEach>
      </table>
        		  		
    </c:otherwise>
  </c:choose>
 
</div>
</body>
</html>
