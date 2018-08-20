package game.view.gui.debug
{
   import feathers.controls.Check;
   import game.util.logging.Log;
   import game.util.logging.LogRecord;
   
   public class LogCheck extends Check
   {
       
      
      public var log:Log;
      
      protected var group:LogGroupView;
      
      public function LogCheck(param1:Log, param2:LogGroupView)
      {
         super();
         this.log = param1;
         this.group = param2;
         updateLabel();
         styleProvider = LogStyleFactory.instance;
         x = 20;
         param2.addChild(this);
         param1.onRecordAdded.add(onRecordAddedHandler);
      }
      
      override public function dispose() : void
      {
         log.onRecordAdded.remove(onRecordAddedHandler);
      }
      
      public function updateLabel() : void
      {
         if(log.logs.length > 0)
         {
            label = log.name + " (" + log.logs.length + ")";
         }
         else
         {
            label = log.name;
         }
      }
      
      protected function onRecordAddedHandler(param1:LogRecord) : void
      {
         updateLabel();
         if(isSelected)
         {
            group.onRecordAdded.dispatch(param1);
         }
      }
   }
}
