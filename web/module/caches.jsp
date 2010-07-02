<%@ include file="/WEB-INF/template/include.jsp" %>
<%@ include file="/WEB-INF/template/header.jsp" %>

<openmrs:require privilege="View Administration Functions" otherwise="/login.htm" redirect="/admin/index.htm"/>

<script type="text/javascript">
    function doCacheManagerAction(command, cacheName) {
        var cacheNameInput = document.getElementById("cacheName");
        var actionInput = document.getElementById("action");

        cacheNameInput.value = cacheName;
        if (command != '')
            actionInput.value = command;
        
        document.forms['formCacheManagerAction'].submit();
    }

    function editCache(cacheName) {
        var cacheNameInput = document.getElementById("editCacheName");
        cacheNameInput.value = cacheName;
        document.forms['formEditCache'].submit();
    }
</script>

<form action="caches.form" method="POST" name="formCacheManagerAction">
    <input type="hidden" id="cacheName" name="cacheName" value=""/>
    <input type="hidden" id="action" name="action" value="flush"/>
    <input type="button" id="shutdown" value="shutdown" onclick="doCacheManagerAction('shutdown', '')"/>
    <input type="button" id="refresh" value="refresh" onclick="location.replace('')"/>
</form>

<form action="cache.form" name="formEditCache">
    <input type="hidden" id="editCacheName" name="editCacheName" value=""/>
</form>

Logic caches (${cachesCount}):<br/>
<ul>
    <c:forEach var="cacheName" varStatus="stat" items="${cacheNames}">
        <li class="${stat.index % 2 == 1 ? "oddRow" : "evenRow" }">
            ${cacheName}
            <input type="button" id="edit" value="edit" onclick="editCache('${cacheName}')"/>
            <input type="button" id="flush" value="flush" onclick="doCacheManagerAction('flush', '${cacheName}')"/>
            <input type="button" id="clear" value="clear" onclick="doCacheManagerAction('clear', '${cacheName}')"/>
        </li>
    </c:forEach>
</ul>

<%@ include file="/WEB-INF/template/footer.jsp" %>