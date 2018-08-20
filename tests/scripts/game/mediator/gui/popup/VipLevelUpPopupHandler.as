package game.mediator.gui.popup
{
   import game.mediator.gui.popup.billing.vip.VipLevelUpPopupMediator;
   import game.model.user.Player;
   
   public class VipLevelUpPopupHandler
   {
      
      private static var _instance:VipLevelUpPopupHandler;
       
      
      private var player:Player;
      
      private var _popupOnHold:VipLevelUpPopupMediator;
      
      private var _hold:Boolean;
      
      public function VipLevelUpPopupHandler(param1:Player)
      {
         super();
         _instance = this;
         this.player = param1;
         param1.signal_update.vip_level.add(onPlayerVipLevelUp);
      }
      
      public static function get instance() : VipLevelUpPopupHandler
      {
         return _instance;
      }
      
      public function hold() : void
      {
         _hold = true;
      }
      
      public function release() : void
      {
         _hold = false;
         if(_popupOnHold)
         {
            _popupOnHold.open();
            _popupOnHold = null;
         }
      }
      
      private function onPlayerVipLevelUp() : void
      {
         var _loc1_:VipLevelUpPopupMediator = new VipLevelUpPopupMediator(player,player.vipLevel.level);
         if(!_hold)
         {
            _loc1_.openDelayed();
         }
         else
         {
            _popupOnHold = _loc1_;
         }
      }
   }
}
