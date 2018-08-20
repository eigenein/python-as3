package game.mediator.gui.debug
{
   import flash.utils.Dictionary;
   import game.model.GameModel;
   
   public class DebugGuiPush
   {
       
      
      public var actions:Dictionary;
      
      public function DebugGuiPush()
      {
         actions = new Dictionary();
         super();
         actions["testpush"] = function():void
         {
            GameModel.instance.actionManager.pushTest();
         };
      }
   }
}
