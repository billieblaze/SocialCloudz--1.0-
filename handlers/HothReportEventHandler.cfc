component {
    public void function preHandler(required Event)
    {
        var rc = Event.getCollection();
        var prc = Event.getCollection(private=true);
 
        // Only allow access for debug mode.
       // if (!getDebugMode())
        //{
         //   redirectToNewEvent(event='home',eventObject=Event);
        //}
         
        // Create a new Hoth Reporter using our "Hoth" mapping
        // and pass a HothConfig object for this application. I am keeping
        // the HothConfig.cfc for my application in my /config folder where
        // I also keep my ColdBox, Routes, Cache and other configs.
        prc.HothReporter = new Hoth.HothReporter( new Hoth.config.HothConfig() );
    }
 
    public void function index (required Event) {
        var rc = Event.getCollection();
        var prc = Event.getCollection(private=true);
 
        if (!Event.valueExists('exception'))
        {
            Event.renderData(type='html',data=prc.HothReporter.getReportView());
        } else {
            local.report = (structKeyExists(rc, 'exception')
            ? rc.exception
            : 'all');
 			rc.exception = ucase(rc.exception);
            Event.renderData(type='json',data=prc.HothReporter.report(local.report));
        }
 
        return;
    }
	
	
    public void function delete (required Event) {
        var rc = Event.getCollection();
        var prc = Event.getCollection(private=true);
 
        if (!structKeyExists(rc, 'exception'))
        {
            rc.exception = 'all';
        }
 
        local.result = prc.HothReporter.delete(rc.exception);
 
        Event.renderData(type='json',data=local.result);
        return;
    }
}