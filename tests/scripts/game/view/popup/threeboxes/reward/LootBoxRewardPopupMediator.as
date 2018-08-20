package game.view.popup.threeboxes.reward
{
   import game.command.rpc.stash.StashEventParams;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.Signal;
   
   public class LootBoxRewardPopupMediator extends PopupMediator
   {
       
      
      private var _reward:LootBoxRewardVO;
      
      private var _signal_reBuy:Signal;
      
      public function LootBoxRewardPopupMediator(param1:Player, param2:LootBoxRewardVO)
      {
         _signal_reBuy = new Signal(LootBoxRewardVO,StashEventParams);
         super(param1);
         _reward = param2;
      }
      
      public function get reward() : LootBoxRewardVO
      {
         return _reward;
      }
      
      public function get signal_reBuy() : Signal
      {
         return _signal_reBuy;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new LootBoxRewardPopup(this);
         return _popup;
      }
      
      public function action_reBuy() : void
      {
         var _loc1_:StashEventParams = Stash.click("get_more",_popup.stashParams);
         close();
         _signal_reBuy.dispatch(reward,_loc1_);
      }
   }
}
