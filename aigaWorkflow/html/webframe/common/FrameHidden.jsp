<html>
  <script language="javaScript">
    function createRowSetFactoryInHidden(aUrl,aWindow)
    {
      alert("aUrl="+aUrl);
      var tmpG = createRowSetFactory(aUrl,aWindow);
      return tmpG;
    }
    function createRowSetFactoryInHiddenByView(aViewName,aEventID,aPara)
    {
      var tmpG = createRowSetFactoryByView(aViewName,aEventID,aPara)
      return tmpG;
    }
    function createNewRowSetFactory()
    {
      var tmpG = new RowSetFactoryClass();
      return tmpG;
    }
  </script>
</html>
