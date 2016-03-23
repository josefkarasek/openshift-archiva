<%--
  ~ Licensed to the Apache Software Foundation (ASF) under one
  ~ or more contributor license agreements.  See the NOTICE file
  ~ distributed with this work for additional information
  ~ regarding copyright ownership.  The ASF licenses this file
  ~ to you under the Apache License, Version 2.0 (the
  ~ "License"); you may not use this file except in compliance
  ~ with the License.  You may obtain a copy of the License at
  ~
  ~  http://www.apache.org/licenses/LICENSE-2.0
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

<html>
<head>
  <title>Admin: Add Remote Repository</title>
  <s:head/>
</head>

<body>

<h1>Admin: Add Remote Repository</h1>

<div id="contentArea">

  <s:actionmessage/>
  <s:form method="post" action="addRemoteRepository_commit" namespace="/admin" validate="true">
    <s:textfield name="repository.id" label="Identifier" size="10" requiredLabel="true"/>
    <%@ include file="/WEB-INF/jsp/admin/include/remoteRepositoryForm.jspf" %>
    <s:submit value="Add Repository"/>
  </s:form>

  <script type="text/javascript">
    document.getElementById("addRemoteRepository_id").focus();
  </script>

</div>

</body>
</html>
