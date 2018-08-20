package game.view.popup.ny.treeupgrade
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import feathers.core.PopUpManager;
   import game.command.rpc.ny.CommandNYFireworksLaunch;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.GamePopupManager;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   import game.view.popup.ny.NYPopupMediatorBase;
   import game.view.popup.ny.reward.NYRewardPopup;
   
   public class NYFireworksLaunchPopupMediator extends NYPopupMediatorBase
   {
       
      
      private var _property_hideNickname:BooleanPropertyWriteable;
      
      private var _property_hideClanName:BooleanPropertyWriteable;
      
      public function NYFireworksLaunchPopupMediator(param1:Player)
      {
         _property_hideNickname = new BooleanPropertyWriteable(false);
         _property_hideClanName = new BooleanPropertyWriteable();
         super(param1);
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         _loc1_.requre_coin(DataStorage.coin.getByIdent("ny_tree_coin"));
         _loc1_.requre_coin(DataStorage.coin.getByIdent("ny_gift_coin"));
         return _loc1_;
      }
      
      public function get property_hideNickname() : BooleanPropertyWriteable
      {
         return _property_hideNickname;
      }
      
      public function get property_hideClanName() : BooleanPropertyWriteable
      {
         return _property_hideClanName;
      }
      
      public function get price() : InventoryItem
      {
         return DataStorage.rule.ny2018TreeRule.fireworks.decorateAction.cost.outputDisplay[0];
      }
      
      public function get decorateActionRewardItem() : InventoryItem
      {
         return DataStorage.rule.ny2018TreeRule.fireworks.decorateAction.reward.outputDisplay[0];
      }
      
      public function get randomPlayerGiftRewardItem() : InventoryItem
      {
         return DataStorage.rule.ny2018TreeRule.fireworks.randomPlayerGiftReward.outputDisplay[0];
      }
      
      public function action_launch() : void
      {
         var _loc1_:CommandNYFireworksLaunch = new CommandNYFireworksLaunch(_property_hideNickname.value,_property_hideClanName.value);
         _loc1_.signal_complete.add(handler_treeDecorate);
         GameModel.instance.actionManager.executeRPCCommand(_loc1_);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new NYFireworksLaunchPopup(this);
         return _popup;
      }
      
      private function handler_treeDecorate(param1:CommandNYFireworksLaunch) : void
      {
         var _loc2_:String = Translate.translate("UI_DIALOG_NY_TREE_UPGRADE_REWARD_HEADER");
         PopUpManager.addPopUp(new NYRewardPopup(_loc2_,param1.reward.outputDisplay));
         GamePopupManager.closeAll();
      }
   }
}
