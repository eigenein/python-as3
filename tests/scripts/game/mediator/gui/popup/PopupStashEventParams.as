package game.mediator.gui.popup
{
   import game.command.rpc.stash.StashEventParams;
   
   public class PopupStashEventParams extends StashEventParams
   {
       
      
      public var windowName:String;
      
      public var buttonName:String;
      
      public var actionType:String;
      
      public var prevWindowName:String;
      
      public var prevButtonName:String;
      
      public var prevActionName:String;
      
      public function PopupStashEventParams()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         var _loc1_:Object = {};
         if(windowName)
         {
            _loc1_.windowName = windowName;
         }
         if(buttonName)
         {
            _loc1_.buttonName = buttonName;
         }
         if(prevWindowName)
         {
            _loc1_.prevWindowName = prevWindowName;
         }
         if(prevButtonName)
         {
            _loc1_.prevButtonName = prevButtonName;
         }
         if(prevActionName)
         {
            _loc1_.prevActionName = prevActionName;
         }
         if(timestamp)
         {
            _loc1_.timestamp = timestamp;
         }
         return _loc1_;
      }
   }
}
