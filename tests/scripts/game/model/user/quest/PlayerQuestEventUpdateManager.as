package game.model.user.quest
{
   import game.model.GameModel;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Stage;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class PlayerQuestEventUpdateManager
   {
       
      
      private var needUpdate:Boolean = false;
      
      public function PlayerQuestEventUpdateManager()
      {
         super();
      }
      
      public function requestUpdate() : void
      {
         if(!needUpdate)
         {
            needUpdate = true;
            subscribeForPlayerActivity();
         }
      }
      
      protected function subscribeForPlayerActivity() : void
      {
         var _loc1_:Stage = Starling.current.stage;
         if(_loc1_)
         {
            _loc1_.addEventListener("touch",handler_touch);
         }
      }
      
      protected function handlePlayerActivity() : void
      {
         if(needUpdate)
         {
            doUpdate();
         }
         var _loc1_:Stage = Starling.current.stage;
         if(_loc1_)
         {
            _loc1_.removeEventListener("touch",handler_touch);
         }
      }
      
      protected function doUpdate() : void
      {
         GameModel.instance.actionManager.quest.questGetAllQuestsAndEvents();
         needUpdate = false;
      }
      
      private function handler_touch(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(param1.currentTarget as DisplayObject,"hover");
         if(_loc2_)
         {
            handlePlayerActivity();
         }
      }
   }
}
