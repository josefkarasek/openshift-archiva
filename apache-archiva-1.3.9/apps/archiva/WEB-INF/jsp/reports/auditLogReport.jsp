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

<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.extremecomponents.org" prefix="ec" %>

<html>
<head>

  <title>Audit Log Report</title>
  <s:head />
  
  <link rel="stylesheet" href="<c:url value='/css/no-theme/jquery-ui-1.7.2.custom.css'/>" type="text/css" />
  <script type="text/javascript" src="<c:url value='/js/jquery-1.3.2.min.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/js/jquery-ui-1.7.2.custom.min.js'/>"></script>
  <script type="text/javascript" charset="utf-8">
    $(document).ready(function()
    {
		$('#startDate').datepicker()
		$('#endDate').datepicker()
    });
  </script>
</head>

<body>
<h1>Audit Log Report</h1>
  
<div id="contentArea">
  
  <s:form action="viewAuditLogReport" namespace="/report" validate="false">
     
    <s:hidden name="initial"/>
    
    <div id="auditLogReport"> 	
        <table id="auditLogFieds">
          <tbody>
            <tr>
	   	      <td>Repository: </td>
	   	      <td><s:select name="repository" list="repositories" theme="simple"/></td>
	   	    <tr>
	   	    <tr>
	   	      <td>Group ID: </td>
	   	      <td><s:textfield id="groupId" name="groupId" theme="simple"/></td>
	   	    <tr>
	   	    <tr>
	   	      <td>Artifact ID: </td>
	   	      <td><s:textfield id="artifactId" name="artifactId" theme="simple"/></td>
	   	    <tr>
	   	    <tr>
	   	      <td>Start Date: </td>
	   	      <td><s:textfield id="startDate" name="startDate" theme="simple"/>	      
			    <%--
			    <script type="text/javascript">
			      Calendar.setup({
			        inputField     :    "startDate",     
			        ifFormat       :    "%Y-%m-%d",             
			        align          :    "Tl",           
			        singleClick    :    true
			      });
			    </script>
			    --%>
	    	  </td>
	   	    <tr>
	   	    <tr>
	   	      <td>End Date: </td>
	   	      <td><s:textfield id="endDate" name="endDate" theme="simple"/>
				<%--
				<script type="text/javascript">
			      Calendar.setup({
			        inputField     :    "endDate",     
			        ifFormat       :    "%Y-%m-%d",             
			        align          :    "Tl",           
			        singleClick    :    true
			      });
			    </script>
				--%>    		
	    	  </td>
	   	    <tr>
	   	    <tr>
	   	      <td>Row Count: </td>
	   	      <td><s:textfield name="rowCount" theme="simple"/></td>
	   	    <tr>
	   	    <tr>
	   	      <td/>
	   	      <td style="text-align: right"><s:submit value="View Audit Log" theme="simple"/></td>
	   	    </tr>
	   	  </tbody>
	   	</table>	
    </div>    
    
    <p/>
    
    <div class="auditLogReportResults">
    
    <h2>${headerName}</h2>
      <p>
        <s:actionerror/>
      </p>
        
	    <c:if test="${not empty (auditLogs)}">  
		  <table class="auditlogs" cellspacing="0">
	         <tr>
		        <th>Event</th>
		        <th>Repository</th>
		        <th>Artifact</th>
		        <th>Event Date</th>
		        <th>Username</th>
		      </tr>
		    
		    <c:forEach items="${auditLogs}" var="auditLog" varStatus="i">	    
		      <tr>
		        <td>${auditLog.event}</td>
		        <td>${auditLog.repositoryId}</td>
		        <td>${auditLog.artifact}</td>
		        <td>${auditLog.eventDate}</td>
		        <td>${auditLog.username}</td>
		      </tr>		    
		    </c:forEach>
		  </table>	
		  
		  <s:set name="page" value="page"/>
	      <c:if test="${page > 1}"><a href="<s:property value='prev' />">&lt;&lt;</a></c:if>
			  <strong>Page: </strong>${page}
		  <s:set name="isLastPage" value="isLastPage"/>		  
		  <c:if test="${!isLastPage}"><a href="<s:property value='next' />">&gt;&gt;</a></c:if>
		</c:if>  
	</div>
   
  </s:form>
    
  
</div>

</body>
</html>
