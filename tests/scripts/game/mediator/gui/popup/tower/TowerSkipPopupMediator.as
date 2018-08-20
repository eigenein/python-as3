package game.mediator.gui.popup.tower
{
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   import game.view.popup.tower.TowerSkipPopup;
   
   public class TowerSkipPopupMediator extends PopupMediator
   {
       
      
      private var _minChests:int;
      
      private var _maxChests:int;
      
      public function TowerSkipPopupMediator(param1:Player)
      {
         super(param1);
      }
      
      override protected function dispose() : void
      {
         player.signal_update.vip_level.remove(handler_vipUpdate);
         super.dispose();
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney();
         return _loc1_;
      }
      
      public function get openCost() : int
      {
         return player.tower.fullSkipCost.starmoney;
      }
      
      public function get minChests() : int
      {
         return 15;
      }
      
      public function get maxChests() : int
      {
         if(player.vipLevel.level < 4)
         {
            return 30;
         }
         return 45;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TowerSkipPopup(this);
         return _popup;
      }
      
      public function action_skipFull() : void
      {
         player.tower.action_skipFull();
         close();
      }
      
      public function action_skipSelect() : void
      {
         player.tower.action_skipSelect();
         close();
      }
      
      private function handler_vipUpdate() : void
      {
      }
   }
}
