<%@ include file="/WEB-INF/template/include.jsp" %>
<%@ include file="/WEB-INF/template/header.jsp" %>

<openmrs:require privilege="View Administration Functions" otherwise="/login.htm" redirect="/admin/index.htm"/>

<form method="get" action="caches.form" name="back" id="back">
<p><a href="#" onclick="document.back.submit();">Back to the cache list page.</a></p><br/>
</form>

<h3>${cacheName}</h3>

<script type="text/javascript">
    function changeDiskPersistenceOption(persistenceCheckBox) {
        var diskPersistence = document.getElementById("diskPersistence");
        diskPersistence.value = persistenceCheckBox.checked;
    }

    function restartCache() {
        if (confirm("You`ll lose all cached data!\n Do you really want to restart this cache?")) { 
            var restart = document.getElementById("restart");
            restart.value = "true";
            document.cacheAction.submit();
        }
    }
</script>

<form action="cache.form" method="post">
    <input type="hidden" name="cacheName" value="${cacheName}" />
    <table cellpadding="1" cellspacing="1">
        <c:if test="${not empty configTTL}">
        <tr>
            <td class="evenRow">Default TTL</td>
            <td><input type="text" name="defaultTTL" value="${configTTL}"/></td>
        </tr>
        </c:if>
        <c:if test="${not empty configMaxElInMem}">
        <tr>
            <td class="evenRow">Max elements in memory</td>
            <td><input type="text" name="maxElemInMem" value="${configMaxElInMem}"/></td>
        </tr>
        </c:if>
        <c:if test="${not empty configMaxElOnDisk}">
        <tr>
            <td class="evenRow">Max elements on disk</td>
            <td><input type="text" name="maxElemOnDisk" value="${configMaxElOnDisk}" <c:if test="${not diskPersistence}">disabled=""</c:if> /></td>
        </tr>
        </c:if>
        <c:if test="${not empty diskPersistence}">
        <tr>
            <td class="evenRow"><label for="_diskPersistence">Disk persistence<code>onchange</code></label></td>
            <td>
                <input type="hidden" id="diskPersistence" name="diskPersistence" value="${diskPersistence}" />
                <input type="checkbox" id="_diskPersistence" onchange="changeDiskPersistenceOption(this);" <c:if test="${diskPersistence}">checked</c:if> />
            </td>
        </tr>
        </c:if>
        <tr class="evenRow">
            <td>Cache size</td>
            <td>${cacheSize}</td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="save"/>
                <input type="button" value="refresh" onclick="document.cacheAction.submit();"/>
                <c:if test="${cacheRestart}">
                    <input type="button" value="restart cache" onclick="restartCache();"/>
                </c:if>
            </td>
        </tr>
    </table>
</form>

<c:if test="${isRestartNeeded}">
<div style="font-style:italic; color:#d2691e; padding-top: 15px;">
    You need to restart this cache to activate the changed configuration.
    WARNING: you`ll lose cached entries of this cache during restart.
</div>
</c:if>

<form action="cache.form" id="cacheAction" name="cacheAction">
    <input type="hidden" name="cacheName" value="${cacheName}" />
    <c:if test="${cacheRestart}">
        <input type="hidden" id="restart" name="restart" value="false" />
    </c:if>
</form>

<br/>
<hr/>
TEMPORARY
<br/><b>${cacheName} Statisctics:</b><br/>
<table cellpadding="1" cellspacing="1">
    <tr>
        <td>Cache hits:</td>
        <td>${cacheHits}</td>
    </tr>
    <tr>
        <td>Cache misses:</td>
        <td>${cacheMisses}</td>
    </tr>
    <tr style="color:#bfbdbd;">
        <td>Cache specific stats:</td>
        <td>${cacheToStr}</td>
    </tr>
</table>
<br/>
<hr/>

<%@ include file="/WEB-INF/template/footer.jsp" %>