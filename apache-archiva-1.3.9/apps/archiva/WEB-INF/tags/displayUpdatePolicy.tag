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

<%-- TODO: this could perhaps just be a i18n call --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ attribute name="policy" required="true" %>
<%@ attribute name="interval" %>

<c:choose>
  <c:when test="${policy == 'disabled'}">
    Disabled
  </c:when>
  <c:when test="${policy == 'always'}">
    Updated every request
  </c:when>
  <c:when test="${policy == 'hourly'}">
    Updated hourly
  </c:when>
  <c:when test="${policy == 'daily'}">
    Updated daily
  </c:when>
  <c:when test="${policy == 'interval'}">
    Updated every ${interval} minutes
  </c:when>
</c:choose>