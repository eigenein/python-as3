package game.mediator.gui.popup.chest
{
   import game.command.rpc.stash.StashEventParams;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.chest.reward.ChestRewardFullscreenPopup;
   import idv.cjcat.signals.Signal;
   
   public class ChestRewardPopupMediator extends PopupMediator
   {
       
      
      private var _reward:ChestRewardPopupValueObject;
      
      private var _signal_reBuy:Signal;
      
      public function ChestRewardPopupMediator(param1:Player, param2:ChestRewardPopupValueObject)
      {
         _signal_reBuy = new Signal(ChestRewardPopupValueObject,StashEventParams);
         super(param1);
         this._reward = param2;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         return _loc1_;
      }
      
      public function get reward() : ChestRewardPopupValueObject
      {
         return _reward;
      }
      
      public function get signal_reBuy() : Signal
      {
         return _signal_reBuy;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ChestRewardFullscreenPopup(this);
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
