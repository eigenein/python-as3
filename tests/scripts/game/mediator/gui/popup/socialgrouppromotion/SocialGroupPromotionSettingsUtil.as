package game.mediator.gui.popup.socialgrouppromotion
{
   import game.command.timer.GameTimer;
   import game.data.storage.DataStorage;
   import game.model.user.Player;
   
   public class SocialGroupPromotionSettingsUtil
   {
       
      
      public function SocialGroupPromotionSettingsUtil()
      {
         super();
      }
      
      public static function getIsClosed(param1:Player, param2:String) : Boolean
      {
         var _loc4_:String = String(param1.settings.socialGroupPromotion.getValue());
         if(_loc4_ == "null")
         {
            return false;
         }
         var _loc3_:Object = JSON.parse(_loc4_);
         if(_loc3_.hasOwnProperty("closed"))
         {
            return false;
         }
         if(!_loc3_.closed[param2])
         {
            return false;
         }
         var _loc6_:int = DataStorage.rule.socialGroupPromotionRule.timeToReOpenClosedBlocks;
         var _loc5_:Number = _loc3_.closed[param2];
         return _loc5_ + _loc6_ >= GameTimer.instance.currentServerTime;
      }
      
      public static function setClosed(param1:Player, param2:String) : void
      {
         var _loc3_:* = null;
         var _loc4_:String = param1.settings.socialGroupPromotion.getValue();
         if(_loc4_ != null)
         {
            _loc3_ = JSON.parse(_loc4_);
         }
         if(_loc3_ == null)
         {
            _loc3_ = {};
         }
         if(_loc3_.closed == undefined)
         {
            _loc3_.closed = {};
         }
         _loc3_.closed[param2] = GameTimer.instance.currentServerTime;
         _loc4_ = JSON.stringify(_loc3_);
         param1.settings.socialGroupPromotion.setValue(_loc4_);
      }
   }
}
